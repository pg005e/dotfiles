#! /bin/sh

[ ${#@} -gt 1 ] && echo "too many arguments" && exit 1;

pkg_mngr=""

case "$1" in
  [Dd][Ee][Bb][Ii][Aa][Nn] | [Uu][Bb][Uu][Nn][Tt][Uu] | [Mm][Ii][Nn][Tt])
    pkg_mngr="apt"
    ;;
  [Aa][Rr][Cc][Hh] | [Mm][Aa][Nn][Jj][Aa][Rr][Oo])
    pkg_mngr="pacman"
    ;;
  *)
    echo "provide a valid linux distro (arch/debian based)"
    exit 1;
    ;;
esac

if [ "$pkg_mngr" == "apt" ]; then
  sudo apt install git && sudo apt install stow && sudo apt install starship
fi

if [ "$pkg_mngr" == "pacman" ]; then
  # install from package repositories
  sudo pacman -S git stow neovim starship flatpak tmux
fi

if [ "$pkg_mngr" == "apt" ]; then
  # install from package repositories
  sudo apt install git stow starship flatpak tmux

  # build neovim from scratch for latest version (apt has outdated versions)
  sudo apt install ninja-build gettext cmake curl build-essential &&
  git clone https://github.com/neovim/neovim &&
  cd neovim &&
  git checkout stable &&
  make CMAKE_BUILD_TYPE=RelWithDebInfo &&
  sudo make install &&
  if [ -z $(nvim --version) ]; then
    echo "error in building neovim, refer to the official docs (https://github.com/neovim/neovim/blob/master/BUILD.md)"
  fi
fi

# install the remaining tools
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &&
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install &&
flatpak install flathub org.wezfurlong.wezterm &&
~/.tmux/plugins/tpm/bin/install_plugins

# remove existing configs
if [ -f ~/.bashrc ]; then
  rm ~/.bashrc
fi

# set the config (link using GNU stow)
cd ~/.dotfiles &&
stow .

