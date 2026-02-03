# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- `common-functions.sh` - Shared helper functions for all installation scripts
- `versions.env` - Centralized version management for all dependencies
- Idempotency checks in all installation scripts - scripts can now be run multiple times safely
- Comprehensive logging system with log files stored in `~/.workstation-logs/`
- Error handling with `set -euo pipefail` in all scripts
- Enhanced `.gitignore` to protect sensitive data (logs, env files, secrets)
- Better user feedback with color-coded log messages (INFO, SUCCESS, SKIP, ERROR)
- Check for existing installations before attempting to install packages
- Automatic creation of log directory
- Installation progress tracking

### Changed
- Updated NVM version from v0.37.2 to v0.40.1 in `install-node.sh`
- Refactored `install-cli.sh` to use helper functions and idempotency checks
- Refactored `install-nvim-tmux.sh` to check for existing configurations
- Refactored `install-go.sh` to use versioning from `versions.env`
- Refactored `install-node.sh` to use versioning and idempotency
- Refactored `install-db.sh` to use helper functions
- Refactored `install-docker-k8s.sh` to check existing installations
- Refactored `install-ai.sh` to handle LM Studio bootstrap gracefully
- Refactored `install-ui-apps.sh` to use consistent installation pattern
- Improved `install.sh` main script with better user feedback and summary
- All scripts now create detailed logs of their execution

### Fixed
- Scripts no longer fail when packages are already installed
- Prevented duplicate entries in `.zshrc` from multiple runs
- NVM version mismatch between Mac and Ubuntu installations
- LM Studio CLI bootstrap errors when directory doesn't exist
- MySQL client version now uses consistent `MYSQL_CLIENT_VERSION` variable

### Security
- Added protection for sensitive files in `.gitignore`:
  - Log files (`*.log`)
  - Environment files (`.env*`)
  - Secrets directory
  - Private keys (`*.key`, `*.pem`)
  - Temporary installation files

## [1.0.0] - 2024-02-01

### Initial Release
- Mac workstation setup scripts
- Ubuntu workstation setup scripts
- Neovim configuration with LazyVim
- Tmux configuration with plugins
- Wezterm terminal configuration
- CLI tools installation (zsh, fzf, ripgrep, etc.)
- Development tools (git, go, node, python, docker, kubernetes)
- UI applications installation
- AI tools installation (opencode, LM Studio)
- Database tools (redis, mysql-client)
- Comprehensive README with keyboard shortcuts
- Custom `.clinerules` for AI assistants

---

## Migration Guide

### Upgrading from 1.0.0 to Unreleased

The new version introduces breaking changes in how scripts are structured. Follow these steps:

1. **Pull latest changes:**
   ```bash
   cd ~/git/workstation
   git pull
   ```

2. **Review new files:**
   - `common-functions.sh` - Contains shared utilities
   - `versions.env` - Manages all version numbers

3. **Re-run installation:**
   All scripts are now idempotent, so you can safely re-run:
   ```bash
   ./install.sh
   ```

4. **Check logs:**
   Installation logs are now saved in `~/.workstation-logs/`
   ```bash
   ls -lh ~/.workstation-logs/
   ```

5. **Update versions:**
   Edit `versions.env` to customize versions if needed

---

[Unreleased]: https://github.com/tot-ra/mac-work/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/tot-ra/mac-work/releases/tag/v1.0.0
