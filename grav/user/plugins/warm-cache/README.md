# Warm Cache Plugin

The **Warm Cache** Plugin is an extension for [Grav CMS](http://github.com/getgrav/grav). Warms the cache by hitting all the pages in the sitemap to ensure they are cached and ready for users who will have a cache-hit when they view the pages.

## Installation

Installing the Warm Cache plugin can be done in one of three ways: The GPM (Grav Package Manager) installation method lets you quickly install the plugin with a simple terminal command, the manual method lets you do so via a zip file, and the admin method lets you do so via the Admin Plugin.

### GPM Installation (Preferred)

To install the plugin via the [GPM](http://learn.getgrav.org/advanced/grav-gpm), through your system's terminal (also called the command line), navigate to the root of your Grav-installation, and enter:

    bin/gpm install warm-cache

This will install the Warm Cache plugin into your `/user/plugins`-directory within Grav. Its files can be found under `/your/site/grav/user/plugins/warm-cache`.

### Manual Installation

To install the plugin manually, download the zip-version of this repository and unzip it under `/your/site/grav/user/plugins`. Then rename the folder to `warm-cache`. You can find these files on [GitHub](https://github.com/trilbymedia/grav-plugin-warm-cache) or via [GetGrav.org](http://getgrav.org/downloads/plugins#extras).

You should now have all the plugin files under

    /your/site/grav/user/plugins/warm-cache
	
> NOTE: This plugin is a modular component for Grav which may require other plugins to operate, please see its [blueprints.yaml-file on GitHub](https://github.com/trilbymedia/grav-plugin-warm-cache/blob/master/blueprints.yaml).

### Admin Plugin

If you use the Admin Plugin, you can install the plugin directly by browsing the `Plugins`-menu and clicking on the `Add` button.

## Configuration

Before configuring this plugin, you should copy the `user/plugins/warm-cache/warm-cache.yaml` to `user/config/plugins/warm-cache.yaml` and only edit that copy.

Here is the default configuration and an explanation of available options:

```yaml
enabled: true
enable_quicktray: true
on_cache_clear: false
quicktray_icon: 'fa fa-tachometer'
show_count: true
log_results: false
user_agent: 'Grav Warm-Cache Plugin'
client_timeout: 30
client_connections: 1
client_request_type: GET
batch_size: 25
delay_between_requests: 50
delay_between_batches: 500
max_retries: 2
continue_on_error: true
memory_limit: '256M'
progress_interval: 10
save_failed_urls: true
failed_urls_file: 'user://data/warm-cache-failed.json'
```

Configuration Options:
- `enabled`: Enable/disable the plugin
- `enable_quicktray`: Show warm cache button in admin quicktray
- `on_cache_clear`: Automatically warm cache after cache clear
- `quicktray_icon`: Icon to use in admin quicktray
- `show_count`: Show page count in success messages
- `log_results`: Log detailed results to Grav log
- `user_agent`: User agent string for HTTP requests
- `client_timeout`: HTTP request timeout in seconds
- `client_connections`: Number of concurrent connections (currently limited to 1)
- `client_request_type`: HTTP method to use (GET, HEAD, etc.)
- `batch_size`: Number of URLs to process per batch
- `delay_between_requests`: Delay between requests in milliseconds
- `delay_between_batches`: Delay between batches in milliseconds
- `max_retries`: Number of retries for failed requests
- `continue_on_error`: Continue processing if errors occur
- `memory_limit`: PHP memory limit for the process
- `progress_interval`: Progress update interval (currently unused)
- `save_failed_urls`: Save failed URLs to a file
- `failed_urls_file`: Location to save failed URLs

Note that if you use the Admin Plugin, a file with your configuration named warm-cache.yaml will be saved in the `user/config/plugins/`-folder once the configuration is saved in the Admin.

## Usage

#### Admin Plugin

To use warm-cache plugin in the admin, you simply click the icon in the quicktray.  This is configurable but is a **Tachometer** by default.  You should see a 'toast' message in the top-right corner with a message after completion.

#### CLI Command

The warm-cache plugin includes a powerful CLI command with many options for fine-tuning the cache warming process. It can be scripted or used via a cron-job or scheduler as needed.

Basic usage:

```shell
bin/plugin warm-cache warm https://mysite.com/sitemap.json
```

##### CLI Options

The CLI command supports several options to control the warming process:

```shell
bin/plugin warm-cache warm [options] [<url>]
```

**Options:**

- `-s, --show-all`: Show all URLs being processed (by default only failures are shown)
- `-d, --dry-run`: Show what would be warmed without making requests
- `-f, --filter=FILTER`: Only process URLs matching this pattern (regex)
- `-r, --resume-from=RESUME-FROM`: Resume from a specific URL number
- `-l, --limit=LIMIT`: Limit number of URLs to process
- `--no-progress`: Disable progress bar
- `--show-slow=SHOW-SLOW`: Show pages that take longer than X seconds (e.g., --show-slow=3)

**Examples:**

```shell
# Warm cache using default sitemap
bin/plugin warm-cache warm

# Use a specific sitemap URL
bin/plugin warm-cache warm https://example.com/sitemap.json

# Only warm URLs containing /blog/
bin/plugin warm-cache warm --filter="/blog/"

# Show what would be warmed without making requests
bin/plugin warm-cache warm --dry-run

# Show all URLs being processed (not just failures)
bin/plugin warm-cache warm --show-all

# Resume from URL #100 and process only 50 URLs
bin/plugin warm-cache warm --resume-from=100 --limit=50

# Show pages that take longer than 2 seconds to load
bin/plugin warm-cache warm --show-slow=2

# Process only the first 10 URLs without progress bar
bin/plugin warm-cache warm --limit=10 --no-progress
```

##### Performance Features

The plugin has been optimized for large sites with the following features:

- **Batch Processing**: URLs are processed in configurable batches to manage memory usage
- **Memory Management**: Automatic garbage collection between batches
- **Progress Tracking**: Real-time progress bar showing current URL, success/failure counts, memory usage, and ETA
- **Error Handling**: Configurable retry logic with exponential backoff
- **Slow Page Detection**: Identify pages that take longer to load with `--show-slow`
- **Resume Capability**: Continue from a specific URL if the process is interrupted
- **Failed URL Tracking**: Automatically saves failed URLs to a JSON file for analysis

Interestingly you can run this from any Grav instance that has warm-cache installed, and warm the cache of any other Grav server that has the sitemap plugin installed. This is because warm-cache simply iterates over the entries in the sitemap and causes Grav to respond with the page requested, hence forcing Grav to warm the cache for that page.

#### Scripted

The simplest way to script the warm cache process for a site we have in `/Users/joe/workspace/grav-example-site` is to create a shell script that runs the CLI command.  In this example, we'll create `/Users/joe/bin/warm-cache.sh` file with the contents:

```shell
#!/bin/sh
cd /Users/joe/workspace/grav-example-site
bin/plugin warm-cache warm https://localhost/grav-example-site/sitemap.json
```

Then we ensure this `warm-cache.sh` is executable via:

```shell
chmod +x warm-cache.sh
```

Assuming the `bin/` folder is in Joe's path, then anytime we're in the CLI we can simply run:

```shell
warm-cache.sh
```

#### Cron Job

With the `warm-cache.sh` script created you can run this daily by running this file via crontab.  Edit your crontab file with `crontab -e` then add the following line:

```crontab
* 3 * * * /Users/joe/bin/warm-cache.sh
```

#### Grav Scheduler

To use the Grav Scheduler, a simple approach is to first creat a `warm-cache.sh` script as provided above, then set that up in the scheduler in the "Custom Schedular Jobs"

First make sure your scheduler is working, then you can add a custom entry in your `user/config/scheduler.yaml` configuration file:

```yaml
...
custom_jobs:
  warm-cache:
    command: /Users/joe/bin/warm-cache.sh
    args: null
    at: '* 3 * * *'
    output: logs/warm-cache.log
    output_mode: append
    email: null
```

This will run the warm-cache script every day at 3am and store the output in Grav's `logs/warm-cache.log` file by appending the output each time.

