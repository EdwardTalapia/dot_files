echo "[*] Setting up terminal environment..."

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "[*] Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Starship
if ! command -v starship &> /dev/null; then
  echo "[*] Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install kitty
if ! command -v kitty &> /dev/null; then
  echo "[*] Installing kitty..."
  sudo apt update && sudo apt install -y kitty
fi

# Clone MY_ZSH_SCRIPTS if missing
if [ ! -d "$HOME/MY_ZSH_SCRIPTS" ]; then
  echo "[*] Cloning MY_ZSH_SCRIPTS..."
  git clone git@github.com:EdwardTalapia/zsh-scripts.git ~/MY_ZSH_SCRIPTS
fi

# Symlink dotfiles
DOTFILES="$HOME/git_clones/dot_files"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

# Symlink neofetch config
mkdir -p "$HOME/.config/neofetch"
ln -sf "$DOTFILES/config.conf" "$HOME/.config/neofetch/config.conf"

# Symlink starship config
ln -sf "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"

# Symlink kitty config
mkdir -p "$HOME/.config/kitty"
ln -sf "$DOTFILES/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

echo "[✓] Setup complete. Restart your terminal."
