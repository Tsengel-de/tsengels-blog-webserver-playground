# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2025-12-24

### Changed
- Updated `.gitignore` to exclude all `*.txt` files prevents accidental commit of sensitive data.
- Verified deployment on production server (`192.168.88.123`) and confirmed paths.
- Updated all README files (English and Mongolian) with verified deployment details.

### Security
- Removed tracking of sensitive text files (`cronjob.txt`, `env.txt`) from the repository.
