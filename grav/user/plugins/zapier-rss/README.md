# Zapier RSS Plugin

The **Zapier RSS** Plugin is an extension for [Grav CMS](http://github.com/getgrav/grav). This plugin is intended to be used to integrate Grav content with Zapier via RSS feeds and in turn be integrated with other services like Facebook, Twitter, etc. The basic use case is to expose a collection of content (e.g. a blog) as an RSS feed to be able to automatically post on a social media service such as Facebook

## Installation

Installing the Zapier RSS plugin can be done in one of three ways: The GPM (Grav Package Manager) installation method lets you quickly install the plugin with a simple terminal command, the manual method lets you do so via a zip file, and the admin method lets you do so via the Admin Plugin.

### GPM Installation (Preferred)

To install the plugin via the [GPM](http://learn.getgrav.org/advanced/grav-gpm), through your system's terminal (also called the command line), navigate to the root of your Grav-installation, and enter:

    bin/gpm install zapier-rss

This will install the Zapier RSS plugin into your `/user/plugins`-directory within Grav. Its files can be found under `/your/site/grav/user/plugins/zapier-rss`.

### Manual Installation

To install the plugin manually, download the zip-version of this repository and unzip it under `/your/site/grav/user/plugins`. Then rename the folder to `zapier-rss`. You can find these files on [GitHub](https://github.com/trilbymedia/grav-plugin-zapier-rss) or via [GetGrav.org](http://getgrav.org/downloads/plugins#extras).

You should now have all the plugin files under

    /your/site/grav/user/plugins/zapier-rss
	
> NOTE: This plugin is a modular component for Grav which may require other plugins to operate, please see its [blueprints.yaml-file on GitHub](https://github.com/trilbymedia/grav-plugin-zapier-rss/blob/master/blueprints.yaml).

### Admin Plugin

If you use the Admin Plugin, you can install the plugin directly by browsing the `Plugins`-menu and clicking on the `Add` button.

## Configuration

Before configuring this plugin, you should copy the `user/plugins/zapier-rss/zapier-rss.yaml` to `user/config/plugins/zapier-rss.yaml` and only edit that copy.

Here is the default configuration and an explanation of available options:

```yaml
enabled: true                                                 # plugin enabled
active: false                                                 # default zapier state
template: zapier-feed.zrss.twig                               # TWIG template to use
description: For Zapier RSS integration with other services   # Description
limit: 20                                                     # Number of items to include
length: 1000                                                  # Number of chars per item
order:                                                        # Ordering of items
  by: date
  dir: desc
```

Note that if you use the Admin Plugin, a file with your configuration named zapier-rss.yaml will be saved in the `user/config/plugins/`-folder once the configuration is saved in the Admin.

## Usage

Simply install the plugin and then the URL you would use to integrate with would be your existing blog page with the new `.zrss` extension appended to it:

```
http://yoursite.com/your/blog.zrss
```  
  
This ensures the feed uses the custom `templates/zapier-feed.zrss.twig` file to process.  To modify this Twig file, simply copy it into your theme or plugin's `templates/` folder and modify as you like.

You can override the regular collection properties, or any of the other config options at the blog level, by modifying the frontmatter of the page that contains the collection.  For example:

```yaml
---
title: 'My Blog'
header_image: custom_header.jpg
content:
    items:
        - self@.children
    order:
        by: date
        dir: desc
    limit: 8

zapier-rss:
    active: true
    description: 'My Custom Zapier ZRSS Feed'
    template: 'zapier-custom-feed.rss.twig'
    limit: 20
    length: 500
---
```

You can also control if a particular item in the collection should not be included in this feed by skipping it:

```yaml
---
title: 'My Blog Post"

zapier-rss:
    skip: true
---
```

## To Do

- [X] Support Multiple feed layouts for multiple concurrent integrations (ie, 'zapier-feed.rss.twig')
- [ ] Support dynamic blueprint additions for the custom frontmatter options

