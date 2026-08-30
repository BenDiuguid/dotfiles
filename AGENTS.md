# Project Overview

This is Ben Diuguid's dotfiles configuration project. Use this guide to understand the repository structure, execution flows, and guidelines on where files should be added or updated.

---

## 📂 Directory Structure & File Map

Here is an overview of the directory structure and where specific configuration files are stored:

| Directory/File | Purpose | What goes here? |
| :--- | :--- | :--- |
| [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh) | The primary installation and symlinking coordinator. | Orchestration logic for system setup across macOS and Linux. Symlinks dotfiles, dispatches to OS modules, and runs shared installers. |
| [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) | Directory containing cross-platform dotfiles symlinked to `$HOME`. | Global configuration files (`.gitconfig`, `.zshrc`, `.tmux.conf`, `.gitignore_global`) and XDG configs in `.config/` (e.g., `.config/ghostty/config`). |
| [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc) | Consolidated cross-platform interactive shell configuration. | Environment, options, PATH, completions, prompt, aliases, functions, plugins, and local overrides for macOS & Linux. |
| [`macOS/`](file:///Users/bendiuguid/.dotfiles/macOS) | macOS-specific setup scripts. | Homebrew setup (`brew.sh`), macOS shells (`shells.sh`), and system/dock preferences (`defaults.sh`, `defaults.dock.sh`). |
| [`linux/`](file:///Users/bendiuguid/.dotfiles/linux) | Linux-specific setup scripts. | Distro package management (`packages.sh` for apt, dnf, pacman, or linuxbrew), and Linux shell setup (`shells.sh`). |
| [`install/`](file:///Users/bendiuguid/.dotfiles/install) | Cross-platform language runtimes and package manager installers. | Runtimes and package managers that run everywhere: FNM/Node (`npm.sh`), pnpm (`pnpm.sh`), Bun (`bun.sh`), Python/uv (`python.sh`), and AntiGravity CLI (`agy.sh`). |

---

## ⚙️ Installation Flow & Orchestration

The project is initialized and updated via [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh). The setup steps are executed in this order:

1. **Git Pull**: Automatically pulls latest changes from `origin master` if the repository is a git repo.
2. **Symlinks**: Dynamically links all dotfiles inside [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) to the user's home directory (`~/`).
3. **OS Dispatch**:
   - On **macOS**: executes [`macOS/setup.sh`](file:///Users/bendiuguid/.dotfiles/macOS/setup.sh) (installs Homebrew packages, configures macOS shells, sets git credential helper to `osxkeychain`).
   - On **Linux**: executes [`linux/setup.sh`](file:///Users/bendiuguid/.dotfiles/linux/setup.sh) (installs distro packages via apt/dnf/pacman or linuxbrew, configures Linux shells, sets git credential helper to `cache`).
4. **Shared Runtime Tooling**: Sources platform-agnostic installers in [`install/`](file:///Users/bendiuguid/.dotfiles/install):
   - `npm.sh` (FNM & Node LTS)
   - `pnpm.sh` (pnpm package manager)
   - `agy.sh` (AntiGravity CLI)
   - `bun.sh` (Bun runtime & package manager)
   - `python.sh` (uv & Python)
5. **Shell Reload**: Reload the shell or run the `reSource` alias (`source ~/.zshrc`).

---

## 🐚 Zsh Shell Startup Lifecycle

When a new Zsh session is started, [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc) (via symlink `~/.zshrc`) performs all interactive shell configuration in a cleanly sectioned order:

- **Section 1: Environment & Shell Options**: History, locale, editor defaults, `setopt`/`unsetopt`.
- **Section 2: Platform Detection**: Detects macOS vs Linux dev server, initializes Homebrew environment.
- **Section 3: PATH Configuration**: `typeset -U path PATH` deduplication, user bin folders, PNPM, FNM, Bun.
- **Section 4: Completions & Prompt**: `compinit`, `prompt pure`, case-insensitive completion styling.
- **Section 5: Aliases & Custom Functions**: Common navigation aliases, `reSource`, and platform-specific clipboard (`pbcopy`/`wl-copy`/`xclip`) and networking utilities.
- **Section 6: Plugins & Keybindings**: Safe conditional sourcing of `zsh-autosuggestions`, `zsh-syntax-highlighting` across multiple search paths (`HOMEBREW_PREFIX`, `/usr/share`), and `zsh-history-substring-search`.
- **Section 7: Local Overrides**: Loads `~/.zshrc.local` if present for sensitive/machine-specific settings.

---

## 🛠️ Guidelines for Making Updates (What Goes Where?)

When asked to update settings, packages, or aliases in this repository, follow these rules:

### 1. Shell Configuration (Aliases, PATH, Functions, Env Vars)
* **Where to place**: Directly inside the corresponding section of [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc).
* **Convention**: Keep the section comments intact. Use `typeset -U path PATH` for paths, and guard OS-specific commands with `if [[ "$IS_MACOS" == true ]]` / `else`.
* **Tip**: Use `reSource` in terminal to reload changes.

### 2. Machine-Specific or Sensitive Settings
* **Where to place**: In `~/.zshrc.local` (for shell settings) or `~/.gitconfig.local` (for git settings). These files are automatically loaded and not committed to version control.

### 3. Adding macOS Applications & Packages
* **Where to place**:
  - Command-line binaries: Add to the `binaries` array in [`macOS/brew.sh`](file:///Users/bendiuguid/.dotfiles/macOS/brew.sh).

### 4. Adding Linux Packages
* **Where to place**: In [`linux/packages.sh`](file:///Users/bendiuguid/.dotfiles/linux/packages.sh) under the appropriate distro installer function or linuxbrew installer.

### 5. Adding Global Language Runtimes & Tooling
* **Where to place**:
  - Global npm packages: Add to the `packages` array in [`install/npm.sh`](file:///Users/bendiuguid/.dotfiles/install/npm.sh).
  - Python runtime or global packages: Edit [`install/python.sh`](file:///Users/bendiuguid/.dotfiles/install/python.sh).
  - Bun tooling: Edit [`install/bun.sh`](file:///Users/bendiuguid/.dotfiles/install/bun.sh).

### 6. Adding a New Dotfile for Symlinking
* **Where to place**:
  - Home directory dotfiles (`~/.filename`): Place the file directly in [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) (e.g., `symlink/.my_config`).
  - XDG application configs (`~/.config/app/config`): Place inside [`symlink/.config/`](file:///Users/bendiuguid/.dotfiles/symlink) (e.g., `symlink/.config/ghostty/config`).
  - Both are automatically symlinked by [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh).

---

## ⚠️ Important Rules for Agents
* **Do NOT hardcode user paths**: Use variables like `$HOME` instead of hardcoding `/Users/bendiuguid`.
* **Be careful with OS detection**: Keep scripts portable between macOS and Linux dev servers.
* **Testing changes**: Ensure any scripts you edit run cleanly in standard Zsh/Bash, and verify that variables or functions you introduce do not cause syntax errors on startup.
* **Non-Destructive**: Preserve existing configurations and comments.
