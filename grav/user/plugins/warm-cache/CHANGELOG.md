# v3.0.0
## 08/03/2025

1. [](#new)
    * Added extensive CLI options: `--show-all`, `--dry-run`, `--filter`, `--resume-from`, `--limit`, `--no-progress`, `--show-slow`
    * Added real-time progress bar with ETA, memory usage, and success/failure counts
    * Added batch processing support for better memory management on large sites
    * Added configurable retry logic with exponential backoff
    * Added automatic saving of failed URLs to JSON file for analysis
    * Added slow page detection to identify performance bottlenecks
    * Added ability to resume from a specific URL if process is interrupted
2. [](#improved)
    * Significantly improved performance for large sites through batch processing
    * Better error handling with detailed error messages
    * Enhanced CLI output with color-coded status and summary statistics
    * Improved memory management with automatic garbage collection between batches
    * Updated default configuration with many new options for fine-tuning
    * Better support for various sitemap formats
3. [](#bugfix)
    * Fixed memory issues when processing large sitemaps

# v2.0.3
## 03/13/2023

1. [](#improved)
   * Allow for more flexible checking of `application/json` [#351](https://github.com/getgrav/grav-premium-issues/issues/351)

# v2.0.2
## 03/09/2022

1. [](#new)
   * Added success message to the log after completing the warm-cache process [#189](https://github.com/getgrav/grav-premium-issues/issues/189)

# v2.0.1
## 02/02/2022

1. [](#new)
   * Added options for `client_connections` (concurrent calls) , `client_timeout` (timeout to wait before aborting) and `client_request_type` (HEAD, GET)

# v2.0.0
## 10/28/2021

1. [](#new)
   * Require **Grav 1.7.24**
   * Use Grav's new HTTP\Client with Proxy support
   * Added processing time to `warm` CLI command
2. [](#improved)
   * Use `HEAD` instead of `GET` for page warming for increased performance

# v1.1.3
## 06/28/2021

1. [](#bugfix)
   * Fix issue with passing in sitemap URL [#119](https://github.com/getgrav/grav-premium-issues/issues/119)
   
# v1.1.2
## 06/28/2021

1. [](#improved)
   * Forcing re-release to get picked up in GPM

# v1.1.1
## 06/07/2021

1. [](#improved)
    * Added an error if you try to use `.xml` URL passed in rather than new `.json` format

# v1.1.0
## 04/27/2021

1. [](#improved)
    * Use sitemap plugin version 3.0's `.json` format for multi-language support
    * Fully translate all strings in plugin for better internationalization

# v1.0.1
## 01/25/2021

1. [](#improved)
    * Disable `verify_peer` and `verify_host` to allow for use in developmental SSL environments [#22](https://github.com/getgrav/grav-premium-issues/issues/22)
    
# v1.0.0
## 12/14/2020

1. [](#new)
    * Initial Release
