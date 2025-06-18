# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a modern terminal configuration repository for macOS that provides dotfiles and setup instructions for iTerm2 with Starship prompt. The setup prioritizes performance and developer productivity without using Oh-My-Zsh.

## Key Commands

### Configuration Management
- `reload` - Reload the shell configuration after changes
- `zshconfig` - Edit the .zshrc file
- `starshipconfig` - Edit the Starship configuration

### Testing Configuration Changes
```bash
# Test .zshrc syntax
zsh -n .zshrc

# Test Starship configuration
STARSHIP_CONFIG=.config/starship.toml starship explain
```

## Architecture & Design Principles

### Performance-First Design
- **No Oh-My-Zsh**: Deliberately avoids framework overhead for faster startup
- **Conditional Loading**: All tools check for existence before configuration
- **Lazy Loading**: Language version managers only initialize when needed

### File Structure & Purpose
- `.zshrc` - Main shell configuration with modular tool integration
- `.config/starship.toml` - Prompt configuration optimized for common use cases
- `com.googlecode.iterm2.plist` - iTerm2 preferences including Night Owl theme
- `.hushlogin` - Suppresses macOS login messages

### Integration Patterns
When adding new tools or features:
1. Use conditional checks: `if command -v toolname &> /dev/null; then`
2. Support both Homebrew paths: `/opt/homebrew` (Apple Silicon) and `/usr/local` (Intel)
3. Keep aliases grouped by category (git, docker, navigation, etc.)
4. Maintain the existing order: core settings → aliases → tool integrations → prompt

## Important Configuration Details

### Starship Modules
- Performance-critical modules (AWS, Kubernetes, package) are disabled by default
- Git integration is essential and always enabled
- Language modules auto-detect based on project files

### Shell Features
- History: 10,000 entries with deduplication
- Syntax highlighting must load before substring search
- Starship must initialize last in .zshrc

### Tool Dependencies
Essential tools that should be installed:
- `starship` - The prompt itself
- `bat` - Syntax highlighting for cat
- `eza` - Modern ls replacement
- `fzf` + `fd` - Fast fuzzy finding
- Nerd Font - Required for icons

## Development Workflow

When modifying configurations:
1. Always backup existing configs before testing
2. Test syntax before committing
3. Document any new aliases or features in README
4. Maintain compatibility with both zsh and bash where possible
5. Consider startup time impact of any additions