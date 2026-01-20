# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS, containing configuration files for various development tools. The repository is designed to be cloned to `~/.config/`.

## Key Directories

- **nvim/**: Neovim configuration using lazy.nvim plugin manager
- **zsh/**: ZSH shell configuration (sourced via `.zshenv` symlinked to home)
- **tmux/**: Tmux configuration with tpm (tmux plugin manager) as a git submodule
- **bin/**: Custom shell scripts
- **install/**: Setup scripts for new machines
- **karabiner/**: Keyboard remapping configuration (includes Dvorak layout)
- **cron/**: Cron jobs (auto-saves tmux sessions every minute)

## Setup Commands

Initial machine setup:
```bash
./install/setup.sh    # Full macOS setup (brew, apps, SSH keys, etc.)
./install/install.sh  # Symlinks and vim plugin installation
```

Cron installation:
```bash
./cron/install_cron.sh
```

## Neovim Architecture

Entry point: `nvim/init.lua` loads:
1. `jeffrey/core` - Core options, keymaps, and autocommands
2. `jeffrey/lazy` - lazy.nvim bootstrap and plugin loading

Plugins are organized in `nvim/lua/jeffrey/plugins/`:
- LSP configs in `plugins/lsp/` subdirectory
- Each plugin file returns a lazy.nvim spec table

Sync plugins after changes:
```
:Lazy sync
```

## ZSH Configuration

- Main config: `zsh/.zshrc`
- Environment: `zsh/.zshenv_in_root` (symlinked to `~/.zshenv`)
- Git aliases: `zsh/git_aliases.zsh`
- Custom prompt: `zsh/prompt/`
- Private/local config: `zsh/.zsh_private` (gitignored, create from `.zsh_private_template`)

Reload shell config:
```bash
reload  # alias for: source ~/.config/zsh/.zshrc
```

## Tmux

Config location: `tmux/tmux.conf`

Key bindings:
- `!` - Split horizontal (replaces `%`)
- `-` - Split vertical (replaces `"`)
- `r` - Reload config
- `hjkl` - Resize panes
- `m` - Maximize pane

Session management:
```bash
tmux-session save     # Save all sessions
tmux-session restore  # Restore sessions
```

## Git Aliases (from zsh/git_aliases.zsh)

Common: `gs` (status), `ga` (add), `gp` (push), `gpra` (pull --rebase --autostash), `gc` (commit), `gd` (diff), `gco` (checkout), `glol` (log graph)

Quick vimwiki commit: `gvwcp` - prompts, then adds all, commits with date, and pushes

## Useful Shell Aliases

- `editconfig` / `nvimconfig` - Edit config files
- `sync` - Pull latest config and vimwiki repos
- `cdr <name>` / `cdr -l` - Navigate to ~/repositories/
- `pv` / `createVenv` - Python venv helpers
- `br` - Brew update/upgrade/doctor/cleanup
