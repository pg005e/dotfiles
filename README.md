# Dotfiles
This is a collection of all my dotfiles configuration for `bash`, `wezterm`, `neovim`, `fzf` and `tmux`.



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
After installing `tpm`, you would need to install the plugins with `Prefix` + `I`.
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

Or you can run the script `setup.sh` inside `scripts/` as
`sh setup.sh <distro>`, where `<distro>` is either `arch` or `debian`, that's what i use.
