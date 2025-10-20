# My Dotfiles

A collection of my personal configuration files for various tools, primarily for a Linux environment (Arch-based). This guide provides instructions for manual installation.

## Overview of Configurations

*   **Shells**: Configurations for `bash` and `fish`, including custom prompts, aliases, and helper functions.
*   **Terminal**: `kitty` terminal emulator settings.
*   **Prompt**: `starship` cross-shell prompt configuration.
*   **System Info**: `fastfetch` configuration for a customized system information display.

## Tested Environment & Recommendations

I actively use these dots and configs for my arch + hyprland setup.
For a full Hyprland environment, I highly recommend exploring these projects:

*   **[end-4/dots-hyprland](https://github.com/end-4/dots-hyprland)**: My best recommendation(and my daily driver!). I found it has the most ready-to-use features out of the box, while still offering creative liberty for tweaking.
*   **[caelestia-dots/caelestia](https://github.com/caelestia-dots/caelestia)**: Another beautiful set of dotfiles.
*   **[HyDE-Project/HyDE](https://github.com/HyDE-Project/HyDE)**: Another great project.



## Installation


### Quick Start

These commands are for an **Arch-based system using `yay`**. For other systems, please see the detailed steps below.

**1. Install All Dependencies (Core + Optional):**

```bash
yay -S --needed git fish starship kitty fastfetch eza p7zip unrar zstd flatpak
```

**2. Backup Existing Configs and Install New Ones:**

```bash
# Make sure you are inside the 'configs' directory of this repository
for f in bashrc kitty.conf starship.toml; do SRC_FILE=$(find "$(pwd)" -type f -name "$f"); DEST_FILE="$HOME/.$(basename "$SRC_FILE")"; [ -f "$DEST_FILE" ] && mv "$DEST_FILE" "$DEST_FILE.bak.$(date +%s)"; cp "$SRC_FILE" "$DEST_FILE"; done && for d in fish fastfetch; do SRC_DIR=$(find "$(pwd)" -type d -name "$d" | head -n 1); DEST_DIR="$HOME/.config/$(basename "$SRC_DIR")"; [ -d "$DEST_DIR" ] && mv "$DEST_DIR" "$DEST_DIR.bak.$(date +%s)"; cp -r "$SRC_DIR" "$DEST_DIR"; done && echo "Dotfiles installed."
```

### Manual Installation: Step-by-Step

#### Step 1: Clone the Repository

First, clone this repository to your local machine.

```bash
git clone https://github.com/monojitgoswami69/configs.git
cd configs
```

#### Step 2: Install Dependencies

Dependencies are listed for Arch Linux and Debian/Ubuntu.

**Core Dependencies:**

| Application | Arch Linux (`pacman`) | Debian/Ubuntu (`apt`) | Notes |
| :--- | :--- | :--- | :--- |
| **Fish Shell** | `sudo pacman -S fish` | `sudo apt install fish` | Required for `config.fish`. |
| **Kitty** | `sudo pacman -S kitty` | `sudo apt install kitty` | Terminal emulator. |
| **Starship** | `sudo pacman -S starship` | `curl -sS https://starship.rs/install.sh \| sh` | Cross-shell prompt. |
| **Fastfetch** | `sudo pacman -S fastfetch` | `sudo apt install fastfetch` | System information tool. |
| **Git** | `sudo pacman -S git` | `sudo apt install git` | For `bash` prompt & version control. |
| **Nerd Font** | `yay -S ttf-firacode-nerd` | [Manual Install](https://www.nerdfonts.com/font-downloads) | **Highly Recommended** for icons in Starship/Fastfetch. FiraCode Nerd Font is a good choice. |

**Optional Dependencies (for aliases/helpers):**

| Tool | Arch Linux (`yay`) | Debian/Ubuntu (`apt`) | Used For |
| :--- | :--- | :--- | :--- |
| **eza** | `yay -S eza` | `sudo apt install eza` | Replaces `ls` in `fish` config. |
| **p7zip** | `yay -S p7zip` | `sudo apt install p7zip-full` | `extract` function for `.7z` files. |
| **unrar** | `yay -S unrar` | `sudo apt install unrar` | `extract` function for `.rar` files. |
| **zstd** | `yay -S zstd` | `sudo apt install zstd` | `extract` function for `.zst` files. |
| **Flatpak** | `yay -S flatpak` | `sudo apt install flatpak` | `update` alias to include Flatpak apps. |

#### Step 3: Backup and Install Configs

The following commands will back up your existing configuration (if it exists) with a `.bak` extension and then copy the new one from this repository.

**Run these commands from inside the `configs` directory.**

*   **Bash:**
    ```bash
    # Backup and copy bashrc
    [ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
    cp shell/bashrc ~/.bashrc
    ```

*   **Fish:**
    ```bash
    # Backup and copy fish config directory
    [ -d ~/.config/fish ] && mv ~/.config/fish ~/.config/fish.bak
    mkdir -p ~/.config/fish
    cp -r shell/fish/* ~/.config/fish/
    ```

*   **Kitty:**
    ```bash
    # Backup and copy kitty config
    [ -f ~/.config/kitty/kitty.conf ] && mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.bak
    mkdir -p ~/.config/kitty
    cp kitty/kitty.conf ~/.config/kitty/
    ```

*   **Starship:**
    ```bash
    # Backup and copy starship config
    [ -f ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.bak
    cp starship/starship.toml ~/.config/
    ```

*   **Fastfetch:**
    ```bash
    # Backup and copy fastfetch config directory
    [ -d ~/.config/fastfetch ] && mv ~/.config/fastfetch ~/.config/fastfetch.bak
    mkdir -p ~/.config/fastfetch
    cp -r fastfetch/* ~/.config/fastfetch/
    ```

#### Step 4: Apply Changes

*   For **Bash**, open a new terminal or run: `source ~/.bashrc`
*   For **Fish**, open a new terminal or run: `source ~/.config/fish/config.fish`
*   For **Kitty**, restart the terminal.

## Configuration Details & Fallbacks

### Shell Prompts

#### Fish Prompt (`starship`)

The `fish` configuration is set up to use `starship` by default. It provides a rich, context-aware prompt.

*   **Dependency**: `starship` must be installed.
*   **Fallback**: If you do **not** want to use `starship`:
    1.  Edit `~/.config/fish/config.fish`.
    2.  **Comment out** or **delete** this line:
        ```fish
        starship init fish | source
        ```
    3.  **Uncomment** the `fish_prompt` function at the top of the file:
        ```fish
        function fish_prompt -d "Write out the prompt"
            printf '%s@%s %s%s%s > ' $USER $hostname \
                (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        end
        ```
    This will give you a simple, functional `user@host dir >` prompt.

#### Bash Prompt (Custom Git Prompt)

The `bash` prompt is a custom script that shows the current Git branch and status. It does not depend on `starship`.

### Kitty Terminal

The `kitty.conf` is configured to use a Nerd Font (`FiraCode Nerd Font`). If you don't have a Nerd Font installed, icons and symbols may not render correctly. It is highly recommended to install one for the best experience, as it also benefits `starship` and `fastfetch`.
