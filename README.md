# dotfiles

~/.bashrc:
```
source ~/dotfiles/bash/.bashrc
```

~/.bash_profile:
```
source ~/.bashrc
```

~/.gitconfig:
```
[include]
    path = ~/dotfiles/git/.gitconfig
```

~/.vimrc
```
source ~/dotfiles/vim/.vimrc
```

~/.tmux.conf
```
source "$HOME/dotfiles/tmux/.tmux.conf"
```

for custom powerline configs:
```
mkdir ~/.config
ln -s ~/dotfiles/powerline/ ~/.config/powerline
```
