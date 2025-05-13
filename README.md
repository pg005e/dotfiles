# Dotfiles
This is dotfiles configuration of goose's system.
At the time of making this version, there are configuration for `bash`, `wezterm`, `neovim` and `tmux`.



# Requirements
Ensure you have the following installed on your system:  
#### Git
    sudo pacman -S git

#### Stow
    sudo pacman -S stow

#### Wezterm
    flatpak install flathub org.wezfurlong.wezterm

#### Starship
    sudo pacman -S starship

#### Neovim
    sudo pacman -S neovim

#### Tmux
    sudo pacman -S tmux

#### tpm
For tmux workflow, install tpm first before cloning this repo.
    `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

#### fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install



# Installation
First, clone the dotfiles repo to the `~`/`$HOME` directory.  
```
git clone https://github.com/prayushtwayana/dotfiles.git ~/.dotfiles
```

Then use GNU stow to create the symlinks to the dotfiles in your home directory.
```
cd dotfiles/
stow .
```
