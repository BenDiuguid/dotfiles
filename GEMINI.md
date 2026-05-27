# Project Overview

This is Ben Diuguid's dotfiles configuration project. Use this guide to understand the repository structure, execution flows, and guidelines on where files should be added or updated.

---

## 📂 Directory Structure & File Map

Here is an overview of the directory structure and where specific configuration files are stored:

| Directory/File | Purpose | What goes here? |
| :--- | :--- | :--- |
| [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh) | The primary installation and symlinking coordinator. | Orchestration logic for system setup. If you add a new symlink target, it must be added here. |
| [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) | Directory containing dotfiles to be symlinked to the user's home directory (`~`). | Global configuration files (e.g., `.gitconfig`, `.zshrc`, `.hyper.js`, `.zshenv`, `.zprofile`). |
| [`system/`](file:///Users/bendiuguid/.dotfiles/system) | Modular shell configuration files dynamically loaded by `.zshrc`. | Shell aliases, PATH alterations, completion definitions, environment variables. |
| [`system/functions/`](file:///Users/bendiuguid/.dotfiles/system/functions) | Custom autoloaded shell functions. | Interactive utility functions (e.g., `alert`). |
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

1. [`symlink/.zshenv`](file:///Users/bendiuguid/.dotfiles/symlink/.zshenv) (via symlink `~/.zshenv`): Sets initial critical environment variables (e.g., `ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR`).
2. [`symlink/.zprofile`](file:///Users/bendiuguid/.dotfiles/symlink/.zprofile) (via symlink `~/.zprofile`): Sources the Homebrew shell environment.
3. [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc) (via symlink `~/.zshrc`): Performs interactive configuration setup:
   - Sets the `$OS` and `$DOTFILES_DIR` variables.
   - Sources the system files from [`system/`](file:///Users/bendiuguid/.dotfiles/system) in this exact order:
     - `system/.path` (initializes path and appends custom directories)
     - `system/.env` (history, language, shell options, and editor defaults)
     - `system/.alias` (command shortcuts and finder toggle commands)
     - `system/.completion` (autocomplete hooks)
     - `system/.secret` (local sensitive keys/exports, if present)
   - Appends [`system/functions/`](file:///Users/bendiuguid/.dotfiles/system/functions) to the autoload path (`$FPATH`).
   - Sources external plugins (autosuggestions, syntax highlighting, history substring search).
   - Initializes NVM (`nvm.sh` & `bash_completion`).

---

## 🛠️ Guidelines for Making Updates (What Goes Where?)

When asked to update settings, packages, or aliases in this repository, follow these rules:

### 1. Adding/Modifying Shell Aliases
* **Where to place**: [`system/.alias`](file:///Users/bendiuguid/.dotfiles/system/.alias)
* **Convention**: Write clean aliases. For example: `alias mycommand="real_command --flags"`
* **Tip**: Use `reSource` (an existing alias) in terminal to reload changes.

### 2. Modifying Environment Variables
* **Where to place**: [`system/.env`](file:///Users/bendiuguid/.dotfiles/system/.env)
* **Convention**: Export standard variables using `export KEY="value"`. Keep shell settings configured via `setopt` and `unsetopt` in this file.

### 3. Modifying the `PATH` Variable
* **Where to place**: [`system/.path`](file:///Users/bendiuguid/.dotfiles/system/.path)
* **Convention**: 
  - Use the helper function `append-path "/path/to/directory"` to safely append a folder to `$PATH` only if it exists.
  - The script automatically strips duplicate paths at the end, preserving order. Do not manually modify the duplicate-filtering logic.
  - Check for executable presence before calling utilities (e.g., using `is-executable`).

### 4. Adding/Creating Custom Shell Functions
* **Where to place**: Create a new file under [`system/functions/`](file:///Users/bendiuguid/.dotfiles/system/functions/). The file name should match the function name (e.g., `system/functions/my_func`).
* **Convention**:
  - The function must be structured in Zsh syntax.
  - Ensure the function is registered/loaded using `autoload` in [`symlink/.zshrc`](file:///Users/bendiuguid/.dotfiles/symlink/.zshrc).

### 5. Adding CLI or GUI Applications (Homebrew)
* **Where to place**:
  - Command-line binaries: Add to the `binaries` array in [`install/brew.sh`](file:///Users/bendiuguid/.dotfiles/install/brew.sh).
  - GUI application casks: Add to the `apps` array in [`install/brew-cask.sh`](file:///Users/bendiuguid/.dotfiles/install/brew-cask.sh).

### 6. Adding Global Package Manager Dependencies
* **Where to place**:
  - Global npm packages: Add to the `packages` array in [`install/npm.sh`](file:///Users/bendiuguid/.dotfiles/install/npm.sh).
  - Python runtime or global packages: Edit [`install/python.sh`](file:///Users/bendiuguid/.dotfiles/install/python.sh).
  - Ruby gems: Edit [`install/gem.sh`](file:///Users/bendiuguid/.dotfiles/install/gem.sh).

### 7. Adding a New Dotfile for Symlinking
* **Where to place**: Place the file in [`symlink/`](file:///Users/bendiuguid/.dotfiles/symlink) (e.g., `symlink/.tmux.conf`).
* **Registration**: Update [`setup.sh`](file:///Users/bendiuguid/.dotfiles/setup.sh) to link this file. Add the line:
  ```bash
  ln -sfv "$DOTFILES_DIR/symlink/.my_new_config" ~
  ```

---

## ⚠️ Important Rules for Agents
* **Do NOT hardcode user paths**: Use variables like `$HOME` or dynamic paths derived from the current script location (`$DOTFILES_DIR`) instead of hardcoding `/Users/bendiuguid`.
* **Be careful with OS detection**: Keep scripts portable, particularly for macOS.
* **Testing changes**: Ensure any scripts you edit run cleanly in standard Zsh/Bash, and verify that variables or functions you introduce do not cause syntax errors on startup.
