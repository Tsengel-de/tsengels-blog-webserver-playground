<?php

/**
 * @package    Grav\Plugin\WarmCache
 *
 * @copyright  Copyright (C) 2014 - 2019 Trilby Media, LLC. All rights reserved.
 * @license    MIT License; see LICENSE file for details.
 */

namespace Grav\Plugin\Console;

use Grav\Console\ConsoleCommand;
use Grav\Common\Grav;
use Grav\Plugin\Views\Views;
use Grav\Plugin\WarmCachePlugin;
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Helper\ProgressBar;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Style\SymfonyStyle;

/**
 * Class WarmCacheCommand
 *
 * @package Grav\Console\Cli
 */
class WarmCacheCommand extends ConsoleCommand
{

    /**
     * Configure the command
     */
    protected function configure()
    {
        $this
            ->setName('warm')
            ->addArgument(
                'url',
                InputArgument::OPTIONAL,
                'Optional URL of sitemap'
            )
            ->addOption(
                'show-all',
                's',
                InputOption::VALUE_NONE,
                'Show all URLs being processed (by default only failures are shown)'
            )
            ->addOption(
                'dry-run',
                'd',
                InputOption::VALUE_NONE,
                'Show what would be warmed without making requests'
            )
            ->addOption(
                'filter',
                'f',
                InputOption::VALUE_REQUIRED,
                'Only process URLs matching this pattern (regex)'
            )
            ->addOption(
                'resume-from',
                'r',
                InputOption::VALUE_REQUIRED,
                'Resume from a specific URL number'
            )
            ->addOption(
                'limit',
                'l',
                InputOption::VALUE_REQUIRED,
                'Limit number of URLs to process'
            )
            ->addOption(
                'no-progress',
                null,
                InputOption::VALUE_NONE,
                'Disable progress bar'
            )
            ->addOption(
                'show-slow',
                null,
                InputOption::VALUE_REQUIRED,
                'Show pages that take longer than X seconds (e.g., --show-slow=3)',
                false
            )
            ->setDescription('Warm the cache from CLI')
            ->setHelp('The <info>warm-cache</info> command warms the Grav cache by visiting all pages in the sitemap.

Examples:
  <info>bin/plugin warm-cache warm</info>
  Use the default sitemap

  <info>bin/plugin warm-cache warm https://example.com/sitemap.json</info>
  Use a specific sitemap URL

  <info>bin/plugin warm-cache warm --filter="/blog/"</info>
  Only warm URLs containing /blog/

  <info>bin/plugin warm-cache warm --dry-run</info>
  Show what would be warmed without making requests

  <info>bin/plugin warm-cache warm --show-all</info>
  Show all URLs being processed (not just failures)

  <info>bin/plugin warm-cache warm --resume-from=100 --limit=50</info>
  Resume from URL #100 and process only 50 URLs')
        ;
    }

    /**
     * @return int|null|void
     */
    protected function serve()
    {
        include __DIR__ . '/../vendor/autoload.php';

        $grav = Grav::instance();
        $io = new SymfonyStyle($this->input, $this->output);

        // Initialize Plugins
        $this->initializePlugins();

        // Get options
        $url = $this->input->getArgument('url');
        $showAll = $this->input->getOption('show-all');
        $dryRun = $this->input->getOption('dry-run');
        $filter = $this->input->getOption('filter');
        $resumeFrom = (int) $this->input->getOption('resume-from');
        $limit = $this->input->getOption('limit') ? (int) $this->input->getOption('limit') : null;
        $noProgress = $this->input->getOption('no-progress');
        $showSlowThreshold = $this->input->getOption('show-slow') !== false ? (float) $this->input->getOption('show-slow') : null;

        $io->title('Warming Cache' . ($dryRun ? ' (Dry Run)' : ''));
        $io->newLine();

        // Pass options to warmCache
        $options = [
            'dry_run' => $dryRun,
            'filter' => $filter,
            'resume_from' => $resumeFrom,
            'limit' => $limit,
            'show_all' => $showAll,
            'show_slow' => $showSlowThreshold
        ];
        
        // Track progress
        $progressBar = null;
        $url_count = 0;
        $success_count = 0;
        $fail_count = 0;
        $current_stats = [];
        
        $callback = function ($code, $url, $processed = null, $total = null, $stats = null) use ($io, &$progressBar, $showAll, $noProgress, &$url_count, &$success_count, &$fail_count, &$current_stats, $dryRun, $showSlowThreshold) {
            if ($code === 'status') {
                // Status messages during setup
                $io->writeln("<comment>$url</comment>");
            } elseif ($code === 'total_urls') {
                // Initialize progress bar when we know the total
                if (!$noProgress && !$showAll && $total > 0) {
                    $progressBar = $io->createProgressBar($total);
                    $progressBar->setFormat(' %current%/%max% [%bar%] %percent:3s%% | %message%');
                    $progressBar->setMessage('Warming cache...');
                }
            } elseif ($code === 'filtered') {
                // URL was filtered out
                if ($showAll) {
                    $io->writeln("<fg=gray>[SKIP] $url</>");
                }
            } elseif ($code === 'progress' && $stats) {
                // Update stats
                $current_stats = $stats;
                $current_url = $stats['current_url'] ?? '';
                
                if ($progressBar && !$noProgress && !$showAll) {
                    $memory = round($stats['memory'] / 1024 / 1024, 1);
                    $eta_formatted = $stats['eta'] > 0 ? gmdate("H:i:s", (int)$stats['eta']) : '--:--:--';
                    
                    // Truncate URL if too long
                    $display_url = $current_url;
                    if (strlen($display_url) > 50) {
                        $display_url = '...' . substr($display_url, -47);
                    }
                    
                    $message = sprintf(
                        "%s | S:%d F:%d | %.1fMB | %s",
                        $display_url,
                        $stats['successful'],
                        $stats['failed'],
                        $memory,
                        $eta_formatted
                    );
                    $progressBar->setMessage($message);
                    $progressBar->setProgress($processed);
                }
            } else if ($code !== 'progress' && $code !== 'filtered' && $code !== 'total_urls' && $code !== 'status') {
                $url_time = isset($stats['time']) ? $stats['time'] : 0;
                $slow_threshold = isset($stats['show_slow']) ? $stats['show_slow'] : null;
                $is_slow = $slow_threshold !== null && $url_time >= $slow_threshold;
                
                if ($code === 'dry' || $dryRun) {
                    if ($progressBar) {
                        $progressBar->clear();
                    }
                    $io->writeln(sprintf("[%d/%d] <comment>DRY RUN</comment> %s", $processed, $total, $url));
                    if ($progressBar) {
                        $progressBar->display();
                    }
                } else {
                    // Output URL status
                    $color = $code >= 200 && $code < 300 ? 'green' : 'red';
                    $status_text = $code >= 200 && $code < 300 ? 'OK' : "HTTP $code";
                    
                    // Show if: showAll is on, OR it's an error, OR it's a slow page
                    if ($showAll || $code < 200 || $code >= 300 || $is_slow) {
                        if ($progressBar) {
                            $progressBar->clear();
                        }
                        
                        $time_str = sprintf("%.2fs", $url_time);
                        if ($is_slow) {
                            $time_str = "<fg=yellow>$time_str</>";
                        }
                        
                        $io->writeln(sprintf("[%d/%d] <$color>%-8s</$color> %s %s", $processed, $total, $status_text, $time_str, $url));
                        if ($progressBar) {
                            $progressBar->display();
                        }
                    }
                    
                    if ($code >= 200 && $code < 300) {
                        $success_count++;
                    } else {
                        $fail_count++;
                    }
                }
                $url_count++;
            }
        };

        $start = microtime(true);

        [$status, $message, $stats] = WarmCachePlugin::warmCache($url, $callback, $options);

        // Finish progress bar
        if ($progressBar) {
            $progressBar->finish();
            $io->newLine(2);
        } else {
            $io->writeln(''); // Clear any remaining output
            $io->newLine();
        }
        
        // Summary statistics
        $elapsed = microtime(true) - $start;
        $rate = $url_count > 0 ? round($url_count / $elapsed, 2) : 0;
        
        $io->section('Summary');
        $rows = [
            ['Total time', round($elapsed, 2) . ' seconds'],
            ['URLs processed', $url_count],
            ['Successful', "<fg=green>$success_count</>"],
            ['Failed', $fail_count > 0 ? "<fg=red>$fail_count</>" : '0'],
            ['Rate', "$rate URLs/second"],
            ['Peak memory', round(memory_get_peak_usage(true) / 1024 / 1024, 1) . ' MB']
        ];
        
        if ($filter) {
            $rows[] = ['Filter', $filter];
        }
        if ($resumeFrom > 0) {
            $rows[] = ['Resumed from', "URL #$resumeFrom"];
        }
        if ($limit) {
            $rows[] = ['Limited to', "$limit URLs"];
        }
        
        $io->table(['Metric', 'Value'], $rows);

        if ($status === 'success') {
            $io->success($message);
        } elseif ($status === 'warning') {
            $io->warning($message);
        } else {
            $io->error($message);
        }
    }
}
