<?php
namespace Grav\Plugin;

use Composer\Autoload\ClassLoader;
use Grav\Common\Page\Collection;
use Grav\Common\Page\Page;
use Grav\Common\Plugin;
use Grav\Common\Uri;
use RocketTheme\Toolbox\Event\Event;

/**
 * Class ZapierRSSPlugin
 * @package Grav\Plugin
 */
class ZapierRSSPlugin extends Plugin
{
    protected $conf;

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
            ['autoload', 100000], // TODO: Remove when plugin requires Grav >=1.7
            'onPluginsInitialized' => ['onPluginsInitialized', 0],
            'onBlueprintCreated'   => ['onBlueprintCreated', 0]
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
     * Activate feed plugin only if feed was requested for the current page.
     *
     * Also disables debugger.
     */
    public function onPluginsInitialized()
    {
        if ($this->isAdmin()) {
            return;
        }

        if ($this->grav['uri']->extension() === 'zrss') {
            $this->enable([
                'onPageInitialized' => ['onPageInitialized', 0],
                'onTwigTemplatePaths'   => ['onTwigTemplatePaths', 0],
                'onTwigSiteVariables'   => ['onTwigSiteVariables', 0]
            ]);

            // Dynamically add custom type
            $this->enableCustomType();
        }
    }

    protected function enableCustomType()
    {
        // Force absolute URLs for the feed
        $this->config->set('system.absolute_urls', true);
        $this->config->set('system.cache.enabled', false);

        // Supported Page types
        $page_types = $this->config->get('system.pages.types');
        if (!in_array('zrss', $page_types)) {
            $page_types[] = 'zrss';
            $this->config->set('system.pages.types', $page_types);
        }

        // Page Media
        $media = $this->config->get('media.types');
        if (!isset($media['zrss'])) {
            $media['zrss'] = ['mime' => 'application/rss+xml'];
            $this->config->set('media.types', $media);
        }
    }

    /**
     * Initialize feed configuration.
     */
    public function onPageInitialized()
    {
        /** @var Page $page */
        $page = $this->grav['page'];
        $this->conf = $this->mergeConfig($page);

        if ($this->conf->active) {
            $this->enable([
                'onCollectionProcessed' => ['onCollectionProcessed', 0],
            ]);
        }
    }

    /**
     * Feed consists of all sub-pages.
     *
     * @param Event $event
     */
    public function onCollectionProcessed(Event $event)
    {
        /** @var Collection $collection */
        $collection = $event['collection'];

        // Set collection overrides
        $params = $collection->params();
        $params['limit'] = $this->conf->limit;
        $params['order'] = $this->conf->order;
        $params['description'] = $this->conf->description;
        $params['length'] = $this->conf->length;
        $params['pagination'] = false;
        $params['url_taxonomy_filters'] = false;
        $collection->setParams($params);

        foreach ($collection as $slug => $page) {
            $zrss_header = $page->header()->{$this->name} ?? [];
            if ($zrss_header['skip'] ??  false) {
                $collection->remove($page);
            }
        }
    }

    /**
     * Set feed template as current twig template
     */
    public function onTwigSiteVariables()
    {
        $this->grav['twig']->template = $this->conf->template ?? 'zapier-feed.zrss.twig';
    }

    /**
     * Add current directory to twig lookup paths.
     */
    public function onTwigTemplatePaths()
    {
        $this->grav['twig']->twig_paths[] = __DIR__ . '/templates';
    }


    /**
     * Extend page blueprints with feed configuration options.
     *
     * @param Event $event
     */
    public function onBlueprintCreated(Event $event)
    {
//        static $inEvent = false;
//
//        /** @var Data\Blueprint $blueprint */
//        $blueprint = $event['blueprint'];
//        $form = $blueprint->form();
//
//        $blog_tab_exists = isset($form['fields']['tabs']['fields']['blog']);
//
//        if (!$inEvent && $blog_tab_exists) {
//            $inEvent = true;
//            $blueprints = new Data\Blueprints(__DIR__ . '/blueprints/');
//            $extends = $blueprints->get('feed');
//            $blueprint->extend($extends, true);
//            $inEvent = false;
//        }
    }
}
