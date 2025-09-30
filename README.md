# 🚀 Modern Terminal Setup with iTerm2 & Starship

A fast, modern terminal configuration for macOS featuring iTerm2 and Starship prompt. This setup provides a clean, efficient development environment with the most commonly used configurations.

![Terminal Demo](https://img.shields.io/badge/shell-zsh-green) ![Prompt-starship-blue](https://img.shields.io/badge/prompt-starship-blue)

## 🎯 Features

- **Fast Startup**: No Oh-My-Zsh overhead, pure Zsh configuration
- **Modern Prompt**: Starship with emoji-based indicators and comprehensive language support
- **Developer Tools**: Pre-configured for Ruby, Node.js, Python, Go, Java, Kotlin, Docker, and more
- **Enhanced Commands**: Better `ls` (eza), `cat` (bat), fuzzy finding (fzf)
- **Smart Navigation**: Autojump for quick directory switching
- **Syntax Highlighting**: Real-time command highlighting in terminal
- **Cloud Integration**: Support for AWS, Google Cloud, and Kubernetes
- **Version Managers**: ASDF, rbenv, nvm, and pyenv support
- **Security**: Sensitive data isolation via `.zshrc.local`

## 📦 Prerequisites

- macOS (tested on macOS 13+)
- [Homebrew](https://brew.sh/) package manager
- [iTerm2](https://iterm2.com/) terminal emulator

## 🛠️ Quick Installation

### 1. Clone the Repository

```bash
git clone https://github.com/AbdallahMH/terminal-setup.git
cd terminal-setup
```

### 2. Install Dependencies

**Option A: Using Brewfile (Recommended)**

Install all packages at once using the included Brewfile:

```bash
brew bundle install
```

**Option B: Manual Installation**

```bash
# Install Starship prompt
brew install starship

# Install Nerd Font (choose one)
brew install --cask font-fira-code-nerd-font
# OR
brew install --cask font-jetbrains-mono-nerd-font

# Install essential tools
brew install \
  bat \
  eza \
  fzf \
  fd \
  ripgrep \
  autojump \
  thefuck \
  lazygit \
  zsh-syntax-highlighting \
  zsh-history-substring-search
```

### 3. Copy Configuration Files

```bash
# Copy Zsh configuration files
cp .zshrc ~/.zshrc
cp .zprofile ~/.zprofile

# Copy Starship configuration
mkdir -p ~/.config
cp -r .config/starship.toml ~/.config/

# Copy iTerm2 preferences (optional)
cp com.googlecode.iterm2.plist ~/Library/Preferences/

# Copy login silencer
cp .hushlogin ~/

# Create local configuration file for sensitive data (optional)
cp .zshrc.local.example ~/.zshrc.local
# Edit ~/.zshrc.local to add your API keys and machine-specific settings

# Copy Git configuration template (optional)
cp .gitconfig.example ~/.gitconfig
# Edit ~/.gitconfig with your name, email, and GPG key

# Copy SSH configuration template (optional)
mkdir -p ~/.ssh
cp .ssh_config.example ~/.ssh/config
chmod 600 ~/.ssh/config
# Edit ~/.ssh/config with your SSH keys and server settings

# Copy asdf version manager configuration (optional)
cp .tool-versions ~/
```

### 4. Configure iTerm2

1. Open iTerm2
2. Go to **Preferences** → **Profiles** → **Text**
3. Change font to one of the installed Nerd Fonts (e.g., "FiraCode Nerd Font")
4. Recommended size: 14pt
5. Go to **Preferences** → **Profiles** → **Colors**
6. Import or select your preferred color scheme (Night Owl recommended)

### 5. Restart Your Terminal

```bash
# Reload configuration
source ~/.zshrc
```

## 🎨 Customization

### Starship Configuration

Edit `~/.config/starship.toml` to customize your prompt:

```bash
starshipconfig  # Opens in your default editor
```

Popular customizations:
- **Two-line prompt**: Already configured by default
- **Show command duration**: Shows for commands > 2 seconds
- **Git status**: Comprehensive git information
- **Language versions**: Shows versions for detected projects

### Zsh Configuration

Edit `~/.zshrc` for shell customizations:

```bash
zshconfig  # Opens in your default editor
```

## 📚 Included Aliases

### Navigation
- `ll` - Detailed list with hidden files
- `la` - List all files
- `..` - Go up one directory
- `...` - Go up two directories
- `dev` - Jump to ~/Development

### Git Shortcuts
- `g` - git
- `gs` - git status
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gl` - git pull
- `glog` - Pretty git log

### Docker
- `d` - docker
- `dc` - docker-compose
- `dps` - docker ps
- `di` - docker images

### Utilities
- `reload` - Reload shell configuration
- `zshconfig` - Edit Zsh configuration
- `starshipconfig` - Edit Starship configuration

## 🔧 Tools Included

| Tool | Purpose | Usage |
|------|---------|-------|
| **Starship** | Fast, customizable prompt | Automatic |
| **bat** | Better `cat` with syntax highlighting | `cat file.py` |
| **eza** | Modern `ls` replacement | `ls`, `ll`, `la` |
| **fzf** | Fuzzy finder | `Ctrl+R` (history), `Ctrl+T` (files) |
| **autojump** | Smart directory navigation | `j project` |
| **thefuck** | Command correction | Type `fuck` after error |
| **lazygit** | Terminal UI for git | `lazygit` |

## 🚀 Performance Tips

1. **Disable unused language modules** in `~/.config/starship.toml`
2. **Use `fd` with fzf** for faster file searching (already configured)
3. **Limit git status** scanning in large repositories

## 🔍 Troubleshooting

### Fonts not displaying correctly
- Ensure you've selected a Nerd Font in iTerm2 preferences
- Try a different Nerd Font if icons appear broken

### Slow startup
- Check for duplicate PATH entries in `.zshrc`
- Disable unused language version managers

### Command not found
- Run `brew install <package>` for missing tools
- Ensure Homebrew is in your PATH

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📝 License

MIT License - feel free to use this configuration as a starting point for your own setup.

## 🙏 Acknowledgments

- Inspired by modern terminal setups from the developer community
- [Starship](https://starship.rs/) for the amazing prompt
- [iTerm2](https://iterm2.com/) for the best macOS terminal

---

**Happy coding!** 🎉 If you found this helpful, please give it a ⭐!