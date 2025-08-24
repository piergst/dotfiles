#!/bin/bash
set -e

# This script will be executed on the first startup of each new container with the "my-resources" feature enabled.
# Arbitrary code can be added in this file, in order to customize Exegol (dependency installation, configuration file copy, etc).
# It is strongly advised **not** to overwrite the configuration files provided by exegol (e.g. /root/.zshrc, /opt/.exegol_aliases, ...), official updates will not be applied otherwise.

# Exegol also features a set of supported customization a user can make.
# The /opt/supported_setups.md file lists the supported configurations that can be made easily.
# Oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d /root/.local/bin
install -D /opt/my-resources/setup/zsh/my-theme.omp.json /root/.config/zsh/my-theme.omp.json

# zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# zodide
sudo apt update && sudo apt install -y zoxide ripgrep xclip

# eza (pb with apt install retry later)
/opt/my-resources/setup/install-eza.sh

# Keybindings
install -D /opt/my-resources/setup/zsh/keybindings.zsh /root/.oh-my-zsh/custom/keybindings.zsh
cp /opt/my-resources/setup/zsh/aliases /root/.oh-my-zsh/custom/aliases.zsh

# Aliases (forced in zshrc)
cp /opt/my-resources/setup/zsh/aliases /root/.oh-my-zsh/custom/aliases.zsh

# Init nvim config
nvim --headless "+Lazy! sync" +qa || true

# Custom exegol default plugins
TARGET_ZSHRC="/root/.zshrc"

cp -a "$TARGET_ZSHRC" "${TARGET_ZSHRC}.bak.exegol"
sed -i -E 's/plugins=\(.*\)$/plugins=(zsh-syntax-highlighting zsh-completions zsh-autosuggestions tmux fzf zsh-nvm)/' "$TARGET_ZSHRC"
