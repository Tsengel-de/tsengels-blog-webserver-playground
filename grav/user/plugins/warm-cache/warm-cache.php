<?php
namespace Grav\Plugin;

use Composer\Autoload\ClassLoader;
use Grav\Common\Grav;
use Grav\Common\HTTP\Client;
use Grav\Common\Plugin;
use Grav\Common\Utils;
use Monolog\Logger;
use RocketTheme\Toolbox\Event\Event;

/**
 * Class WarmCachePlugin
 * @package Grav\Plugin
 */
class WarmCachePlugin extends Plugin
{
    /**
     * @return array
     *
     * The getSubscribedEvents() gives the core a list of events
     *     that the plugin wants to listen to. The key of each
     *     array section is the event that the plugin listens to
     *     and the value (in the form of an array) contains the
     *     callable (or function) as well as the priority. The
     *     higher the number the higher the priority.
     */
    public static function getSubscribedEvents()
    {
        return [
            'onPluginsInitialized' => [
                ['autoload', 100000], // TODO: Remove when plugin requires Grav >=1.7
                ['onPluginsInitialized', 0]
            ],
            'onAfterCacheClear' => ['onAfterCacheClear', 0],
        ];
    }

    /**
    * Composer autoload.
    *is
    * @return ClassLoader
    */
    public function autoload(): ClassLoader
    {
        return require __DIR__ . '/vendor/autoload.php';
    }

    /**
     * Initialize the plugin
     */
    public function onPluginsInitialized()
    {
        // Don't proceed if we are in the admin plugin
        if ($this->isAdmin()) {
            $this->enable([
                'onAdminMenu' => ['onAdminMenu', 0],
                'onAdminTaskExecute' => ['onAdminTaskExecute', 0],
                'onTwigSiteVariables' => ['onTwigAdminVariables', 0],
            ]);
            return;
        }

        // Enable the main events we are interested in
        $this->enable([
            // Put your main events here
        ]);
    }

    public function onAfterCacheClear(Event $e)
    {
        if ($this->config->get('plugins.warm-cache.on_cache_clear', false)) {
            [$status, $message] = static::warmCache();
        }
    }

    /**
     * Add warm-ache button to the admin QuickTray
     */
    public function onAdminMenu(): void
    {
        if ($this->config->get('plugins.warm-cache.enable_quicktray')) {

            $base = rtrim($this->grav['base_url'], '/') . '/' . trim($this->grav['admin']->base, '/');
            $options = [
                'hint' => $this->grav['language']->translate('PLUGIN_WARM_CACHE.QUICKTRAY_TOOLTIP'),
                'class' => 'warm-cache',
                'route' => 'admin/plugins/warm-cache',
                'icon' => $this->config->get('plugins.warm-cache.quicktray_icon')
            ];

            $options['data'] = [
                'warm-cache-useraction' => 'warm-cache',
                'warm-cache-uri' => $base . '/plugins/warm-cache'
            ];

            $this->grav['twig']->plugins_quick_tray['Warm Cache'] = $options;
        }
    }

    /**
     * Handle the warming cache task from the admin
     *
     * @param Event $e
     */
    public function onAdminTaskExecute(Event $e): void
    {
        if ($e['method'] === 'taskWarmCache') {
            $controller = $e['controller'];
            header('Content-type: application/json');

            if (!$controller->authorizeTask('warmCache', ['admin.configuration', 'admin.super'])) {
                $json_response = [
                    'status'  => 'error',
                    'message' => '<i class="fa fa-warning"></i> Unable to warm cache',
                    'details' => $this->grav['language']->translate('PLUGIN_WARM_CACHE.INSUFFICIENT_PERMS')
                ];
                echo json_encode($json_response);
                exit;
            }

            error_reporting(1);
            set_time_limit(0);

            [$status, $message] = static::warmCache();

            $json_response = [
                'status'  => $status,
                'message' => $message,
            ];

            echo json_encode($json_response);
            exit;
        }
    }

    /**
     * Set some twig vars and load CSS/JS assets for admin
     */
    public function onTwigAdminVariables(): void
    {
        $this->grav['assets']->addJs('plugin://warm-cache/assets/admin/warm-cache.js');
    }

    public static function warmCache($url = null, $callback = null, $options = [])
    {
        $grav = Grav::instance();
        $lang = $grav['language'];
        $config = $grav['config'];
        $log = $grav['log'];

        // Set memory limit if configured
        $memory_limit = $config->get('plugins.warm-cache.memory_limit', '256M');
        @ini_set('memory_limit', $memory_limit);

        if (!is_null($url)) {
            $url_ext = pathinfo($url, PATHINFO_EXTENSION);
            if ($url_ext !== 'json') {
                $msg = sprintf($lang->translate('PLUGIN_WARM_CACHE.NOT_JSON_URL'), $url_ext);
                return ['error', $msg, []];
            }
        }

        // Extract options first before overwriting
        $dry_run = $options['dry_run'] ?? false;
        $filter_pattern = $options['filter'] ?? null;
        $resume_from = $options['resume_from'] ?? 0;
        $limit = $options['limit'] ?? null;
        $show_all = $options['show_all'] ?? false;
        $show_slow = $options['show_slow'] ?? null;

        // Configuration for HTTP client
        $client_options = [
            'headers' => ['User-Agent' => $config->get('plugins.warm-cache.user_agent')],
            'verify_peer' => false,
            'verify_host' => false,
            'timeout' => 60,
        ];

        $client_connections = $config->get('plugins.warm-cache.client_connections', 1);
        $client_timeout = $config->get('plugins.warm-cache.client_timeout', 30);
        $client_type = $config->get('plugins.warm-cache.client_request_type', 'GET');
        $batch_size = $config->get('plugins.warm-cache.batch_size', 10);
        $delay_between_requests = $config->get('plugins.warm-cache.delay_between_requests', 100);
        $delay_between_batches = $config->get('plugins.warm-cache.delay_between_batches', 1000);
        $max_retries = $config->get('plugins.warm-cache.max_retries', 2);
        $continue_on_error = $config->get('plugins.warm-cache.continue_on_error', true);
        $progress_interval = $config->get('plugins.warm-cache.progress_interval', 10);
        $save_failed_urls = $config->get('plugins.warm-cache.save_failed_urls', true);

        $client = Client::getClient($client_options, $client_connections);

        // Get sitemap URL
        $sitemap_route = $config->get('plugins.sitemap.route', '/sitemap');
        $sitemap_url = $url ?? Utils::url($sitemap_route . '.json', true);
        
        $timer_start = microtime(true);
        
        if ($callback) {
            $callback('status', 'Fetching sitemap from ' . $sitemap_url . '...', 0, 0);
        }
        
        try {
            $sitemap_response = $client->request('GET', $sitemap_url, ['timeout' => $client_timeout]);
        } catch (\Exception $e) {
            $error_msg = sprintf($lang->translate('PLUGIN_WARM_CACHE.INVALID_SITEMAP'), $sitemap_url) . ' Error: ' . $e->getMessage();
            $log->error($error_msg);
            return ['error', $error_msg, []];
        }

        // Check if sitemap exists
        if ($sitemap_response->getStatusCode() !== 200 ||
            !Utils::contains($sitemap_response->getHeaders()['content-type'][0], 'application/json')) {
            return ['error', sprintf($lang->translate('PLUGIN_WARM_CACHE.INVALID_SITEMAP'), $sitemap_url), []];
        }

        if ($callback) {
            $callback('status', 'Parsing sitemap...', 0, 0);
        }
        
        $sitemap = $sitemap_response->toArray();
        
        // Extract URLs from various sitemap formats
        $urls = self::extractUrlsFromSitemap($sitemap);
        $initial_count = count($urls);
        
        $sitemap_time = microtime(true) - $timer_start;
        
        if ($initial_count === 0) {
            return ['error', 'No URLs found in sitemap', []];
        }
        
        if ($callback) {
            $callback('status', "Found $initial_count URLs in " . round($sitemap_time, 2) . "s", 0, 0);
        }
        
        // Apply filter if specified
        if ($filter_pattern) {
            $filtered_urls = [];
            foreach ($urls as $url_data) {
                $url = is_array($url_data) ? $url_data['location'] : $url_data;
                if (preg_match($filter_pattern, $url)) {
                    $filtered_urls[] = $url_data;
                } else {
                    if ($callback && $show_all) {
                        $callback('filtered', $url);
                    }
                }
            }
            $urls = $filtered_urls;
            
            if ($callback) {
                $callback('status', "Filtered to " . count($urls) . " URLs matching pattern: $filter_pattern", 0, 0);
            }
        }
        
        // Apply resume and limit
        if ($resume_from > 0) {
            $urls = array_slice($urls, $resume_from - 1);
            if ($callback) {
                $callback('status', "Resuming from URL #$resume_from", 0, 0);
            }
        }
        
        if ($limit !== null && $limit > 0) {
            $urls = array_slice($urls, 0, $limit);
            if ($callback) {
                $callback('status', "Limited to $limit URLs", 0, 0);
            }
        }
        
        $total_urls = count($urls);
        
        if ($total_urls === 0) {
            return ['error', 'No URLs to process after filtering/limiting', []];
        }

        // Show final count if different from initial
        if ($callback && $total_urls != $initial_count) {
            $callback('status', "Will process $total_urls URLs", 0, 0);
        }

        // Notify callback about total URLs for progress bar initialization
        if ($callback) {
            $callback('total_urls', null, 0, $total_urls);
        }

        // Initialize counters
        $processed = 0;
        $successful = 0;
        $failed = 0;
        $failed_urls = [];
        $start_time = microtime(true);

        if ($config->get('plugins.warm-cache.log_results')) {
            $log->notice("Starting warm cache for $total_urls URLs in " . count(array_chunk($urls, $batch_size)) . " batches of $batch_size");
            $log->notice("Configuration: timeout={$client_timeout}s, retries=$max_retries, delay={$delay_between_requests}ms");
        }

        // Process URLs in batches
        $batches = array_chunk($urls, $batch_size);
        
        foreach ($batches as $batch_num => $batch) {
            foreach ($batch as $url_data) {
                $url = is_array($url_data) ? $url_data['location'] : $url_data;
                $retries = 0;
                $success = false;
                $url_start_time = microtime(true);
                
                // For dry run, skip actual requests
                if ($dry_run) {
                    $success = true;
                    $successful++;
                } else {
                    while ($retries <= $max_retries && !$success) {
                        try {
                            $request_options = [
                                'timeout' => $client_timeout,
                                'verify_peer' => false,
                                'verify_host' => false
                            ];
                            
                            $response = $client->request($client_type, $url, $request_options);
                            $code = $response->getStatusCode();
                            
                            if ($code >= 200 && $code < 300) {
                                $successful++;
                                $success = true;
                            } else {
                                throw new \Exception("HTTP $code");
                            }
                            
                            if ($config->get('plugins.warm-cache.log_results')) {
                                $msg = sprintf($lang->translate('PLUGIN_WARM_CACHE.WARM_NOTICE'), $url, $code);
                                $log->notice($msg);
                            }
                            
                        } catch (\Exception $e) {
                            $retries++;
                            $error_detail = $e->getMessage();
                            
                            // Add more context to the error
                            if (strpos($error_detail, 'cURL error') !== false) {
                                $error_detail = "Connection failed: " . $error_detail;
                            }
                            
                            if ($retries > $max_retries) {
                                $failed++;
                                $failed_urls[] = [
                                    'url' => $url,
                                    'error' => $error_detail,
                                    'timestamp' => time()
                                ];
                                
                                if ($config->get('plugins.warm-cache.log_results')) {
                                    $log->error("Failed to warm $url after $max_retries retries: $error_detail");
                                }
                                
                                if (!$continue_on_error) {
                                    return ['error', "Failed to warm cache for $url: " . $error_detail, []];
                                }
                            } else {
                                // Wait before retry with exponential backoff
                                usleep($delay_between_requests * 1000 * pow(2, $retries - 1));
                            }
                        }
                    }
                }
                
                $processed++;
                $url_time = microtime(true) - $url_start_time;
                
                // Progress callback
                if ($callback) {
                    $code = $dry_run ? 'dry' : ($success ? 200 : 0);
                    $callback($code, $url, $processed, $total_urls, [
                        'time' => $url_time,
                        'show_slow' => $show_slow
                    ]);
                    
                    // Always update progress for smooth progress bar
                    $elapsed = microtime(true) - $start_time;
                    $rate = $processed > 0 ? $processed / $elapsed : 1;
                    $eta = ($total_urls - $processed) / $rate;
                    
                    $callback('progress', null, $processed, $total_urls, [
                        'successful' => $successful,
                        'failed' => $failed,
                        'elapsed' => $elapsed,
                        'eta' => $eta,
                        'memory' => memory_get_usage(true),
                        'current_url' => $url
                    ]);
                }
                
                // Delay between requests (skip for dry run)
                if (!$dry_run && $delay_between_requests > 0 && $processed < $total_urls) {
                    usleep($delay_between_requests * 1000);
                }
            }
            
            // Delay between batches
            if ($batch_num < count($batches) - 1 && $delay_between_batches > 0) {
                usleep($delay_between_batches * 1000);
            }
            
            // Clean up memory
            unset($batch);
            if (function_exists('gc_collect_cycles')) {
                gc_collect_cycles();
            }
        }

        // Save failed URLs if configured
        if ($save_failed_urls && !empty($failed_urls)) {
            $failed_file = $grav['locator']->findResource($config->get('plugins.warm-cache.failed_urls_file'), true, true);
            file_put_contents($failed_file, json_encode($failed_urls, JSON_PRETTY_PRINT));
        }

        // Prepare result message
        $result = "$successful/$total_urls";
        $show_count = $config->get('plugins.warm-cache.show_count') ? "for $result pages" : "was";
        $message = sprintf($lang->translate('PLUGIN_WARM_CACHE.SUCCESS_MESSAGE'), $show_count);
        
        if ($failed > 0) {
            $message .= sprintf(" (%d failed)", $failed);
        }

        $elapsed_time = number_format(microtime(true) - $start_time, 2);
        $message .= " in {$elapsed_time}s";

        if ($config->get('plugins.warm-cache.log_results')) {
            $log->notice($message);
        }

        $stats = [
            'total' => $total_urls,
            'processed' => $processed,
            'successful' => $successful,
            'failed' => $failed,
            'elapsed' => microtime(true) - $start_time,
            'failed_urls' => $failed_urls
        ];
        
        return [$failed === 0 ? 'success' : 'warning', $message, $stats];
    }

    /**
     * Extract URLs from various sitemap formats
     */
    private static function extractUrlsFromSitemap($sitemap)
    {
        $urls = [];
        
        // Handle different sitemap structures
        if (!is_array($sitemap)) {
            return $urls;
        }
        
        // Fast path: Check if it's a simple array first
        if (array_key_exists(0, $sitemap)) {
            // Array format: [{"location": "url"}, ...]
            foreach ($sitemap as $entry) {
                if (isset($entry['location'])) {
                    $urls[] = $entry;
                }
            }
            return $urls;
        }
        
        // Language-keyed or other format
        foreach ($sitemap as $key => $value) {
            if (!is_array($value)) {
                continue;
            }
            
            // Check if it's an array of entries (numeric keys)
            if (array_key_exists(0, $value)) {
                foreach ($value as $entry) {
                    if (isset($entry['location'])) {
                        $urls[] = $entry;
                    }
                }
            } else {
                // It's an object with URL keys - most common for this site
                foreach ($value as $path => $entry) {
                    if (isset($entry['location'])) {
                        $urls[] = $entry;
                    }
                }
            }
        }
        
        return $urls;
    }

}
