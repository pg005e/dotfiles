# Dotfiles
This is the `goose`'s configuration of dotfiles on his system.
At the time of making this version, there are configuration for `bash`, `wezterm`, `neovim` and `tmux`.



## Tools
Get your tools here.

#### Wezterm
    flatpak install flathub org.wezfurlong.wezterm

#### Neovim
    sudo pacman -S neovim

#### Tmux
    sudo pacman -S tmux



## Requirements
Ensure you have the following installed on your system:  
#### Git
    sudo pacman -S git

#### Stow
    sudo pacman -S stow



## Installation
First, clone the dotfiles repo to the `~`/`$HOME` directory.  
```
git clone https://github.com/prayushtwayana/dotfiles.git
```

Then use GNU stow to create the symlinks to the dotfiles in your home directory.
```
cd dotfiles/
stow .
```