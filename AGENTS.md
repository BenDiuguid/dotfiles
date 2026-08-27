# Agent Guidelines: Dotfiles

Lightweight guide for AI coding agents modifying this dotfiles repository.

## Repository Overview

This repository manages personal dotfiles, shell configurations, and system bootstrap scripts for macOS/Zsh.

### Directory Structure & Edit Targets

| Configuration Type | File / Directory | Notes |
| :--- | :--- | :--- |
| **Shell Configuration** | `symlink/.zshrc` | Unified, sectioned Zsh configuration (env, path, aliases, completions, plugins). |
| **Symlinked Dotfiles** | `symlink/` (e.g. `symlink/.gitconfig`) | Symlinked to `~/<filename>`. Register new entries in `setup.sh`. |
| **Local / Private Overrides** | `~/.zshrc.local` | Machine-specific or uncommitted overrides, automatically sourced at end of `.zshrc`. |
| **Homebrew Formulae/Casks** | `install/brew.sh`, `install/brew-cask.sh` | Add package names to the respective arrays. |
| **Package Managers** | `install/npm.sh`, `install/python.sh`, `install/gem.sh` | Node/NPM, Python/uv, Ruby tools. |
| **Orchestration** | `setup.sh` | Coordinates installation and symlinking (`ln -sfv`). |

## Key Rules & Conventions

1. **No Hardcoded Home Paths**: Never hardcode `/Users/bendiuguid`. Use `$HOME` or dynamic paths.
2. **Symlink Registration**: When adding a new file in `symlink/`, register the symlink command in `setup.sh`.
3. **Syntax Safety & Portability**: Ensure scripts and shell functions are valid across macOS and Linux dev servers and do not break startup sourcing. Guard OS-specific commands.
4. **Non-Destructive**: Preserve existing configurations and comments.
