# Project Overview

This is Ben Diuguid's dotfiles configuration project. Use this guide to understand the repository structure, execution flows, and guidelines on where files should be added or updated.

---

## 📂 Directory Structure & File Map

Here is an overview of the directory structure and where specific configuration files are stored:

| Directory/File | Purpose | What goes here? |
| :--- | :--- | :--- |
| [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh) | The primary installation and symlinking coordinator. | Orchestration logic for system setup. If you add a new symlink target, it must be added here. |
| [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) | Directory containing dotfiles to be symlinked to the user's home directory (`~`). | Global configuration files (e.g., `.gitconfig`, `.zshrc`, `.hyper.js`, `.zshenv`, `.zprofile`). |
| [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc) | Consolidated interactive shell configuration. | Environment, options, PATH, completions, prompt, aliases, functions, plugins, and local overrides. |
| [`install/`](file:///Users/bendiuguid/.dotfiles/install) | Individual platform and package manager installation scripts. | Package manager setups (Brew, npm, Python/uv, Ruby/rbenv, Zsh/Bash, and the AntiGravity CLI). |
| [`macOS/`](file:///Users/bendiuguid/.dotfiles/macOS) | OS-specific default configuration scripts. | Mac-specific application and dock preferences (using `defaults write`). |

---

## ⚙️ Installation Flow & Orchestration

The project is initialized and updated via [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh). The setup steps are executed in this order:

1. **Git Pull**: Automatically pulls the latest changes from `origin master` if the repository is a git repo.
2. **Symlinks**: Creates symbolic links from files inside the [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) directory to the user's home directory (`~/`) using `ln -sfv`.
3. **Dependency Sourcing**: Runs the package installation scripts located in [`install/`](file:///Users/bendiuguid/.dotfiles/install) in the following order:
   - `brew.sh` (Homebrew & command-line packages)
   - `bash.sh` (Bash upgrade and registering it in `/private/etc/shells`)
   - `zsh.sh` (Zsh upgrade and registering it in `/private/etc/shells`)
   - `npm.sh` (NVM, node version, and global npm packages like `yarn` and `trash-cli`)
   - `agy.sh` (AntiGravity CLI installation)
   - *(Optional/Commented)* `gem.sh`, `python.sh`, `brew-cask.sh`, and `macOS/defaults.*.sh`
4. **Shell Reload**: The user should reload the shell or run the `reSource` alias (`source ~/.zshrc`) to apply the configurations.

---

## 🐚 Zsh Shell Startup Lifecycle

When a new Zsh session is started, the system follows this sourcing lifecycle:

1. [`symlink/.zshenv`](file:///Users/bendiuguid/.dotfiles/symlink/.zshenv) (via symlink `~/.zshenv`): Sets initial critical environment variables portably (e.g., `ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR`).
2. [`symlink/.zprofile`](file:///Users/bendiuguid/.dotfiles/symlink/.zprofile) (via symlink `~/.zprofile`): Safely sources the Homebrew shell environment if installed.
3. [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc) (via symlink `~/.zshrc`): Performs interactive configuration setup in cleanly sectioned order:
   - **Section 1: Environment & Shell Options**: History, locale, editor defaults, `setopt`/`unsetopt`.
   - **Section 2: Platform Detection**: Detects macOS vs Linux dev server, initializes Homebrew env.
   - **Section 3: PATH Configuration**: `typeset -U path PATH` deduplication, user bin folders, PNPM, NVM.
   - **Section 4: Completions & Prompt**: `compinit`, `prompt pure`, case-insensitive completion styling.
   - **Section 5: Aliases & Custom Functions**: Common navigation aliases, `reSource`, and macOS Finder/clipboard shortcuts.
   - **Section 6: Plugins & Keybindings**: Safe conditional sourcing of `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`.
   - **Section 7: Local Overrides**: Loads `~/.zshrc.local` if present for sensitive/machine-specific settings.

---

## 🛠️ Guidelines for Making Updates (What Goes Where?)

When asked to update settings, packages, or aliases in this repository, follow these rules:

### 1. Shell Configuration (Aliases, PATH, Functions, Env Vars)
* **Where to place**: Directly inside the corresponding section of [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc).
* **Convention**: Keep the section comments intact. Use `typeset -U path PATH` for paths, and guard macOS-specific commands with `if [[ "$IS_MACOS" == true ]]`.
* **Tip**: Use `reSource` in terminal to reload changes.

### 2. Machine-Specific or Sensitive Settings
* **Where to place**: In `~/.zshrc.local` on the host machine. This file is automatically loaded at the end of `.zshrc` and is not committed to version control.

### 3. Adding CLI or GUI Applications (Homebrew)
* **Where to place**:
  - Command-line binaries: Add to the `binaries` array in [`install/brew.sh`](file:///Users/bendiuguid/.dotfiles/install/brew.sh).
  - GUI application casks: Add to the `apps` array in [`install/brew-cask.sh`](file:///Users/bendiuguid/.dotfiles/install/brew-cask.sh).

### 4. Adding Global Package Manager Dependencies
* **Where to place**:
  - Global npm packages: Add to the `packages` array in [`install/npm.sh`](file:///Users/bendiuguid/.dotfiles/install/npm.sh).
  - Python runtime or global packages: Edit [`install/python.sh`](file:///Users/bendiuguid/.dotfiles/install/python.sh).
  - Ruby gems: Edit [`install/gem.sh`](file:///Users/bendiuguid/.dotfiles/install/gem.sh).

### 5. Adding a New Dotfile for Symlinking
* **Where to place**: Place the file in [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) (e.g., `symlink/.tmux.conf`).
* **Registration**: Update [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh) to link this file. Add the line:
  ```bash
  ln -sfv "$DOTFILES_DIR/symlink/.my_new_config" ~
  ```

---

## ⚠️ Important Rules for Agents
* **Do NOT hardcode user paths**: Use variables like `$HOME` instead of hardcoding `/Users/bendiuguid`.
* **Be careful with OS detection**: Keep scripts portable between macOS and Linux dev servers.
* **Testing changes**: Ensure any scripts you edit run cleanly in standard Zsh/Bash, and verify that variables or functions you introduce do not cause syntax errors on startup.
* **Non-Destructive**: Preserve existing configurations and comments.
