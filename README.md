# dotfiles

## Environment
### zsh 5.1.1 (x86_64-ubuntu-linux-gnu)
### percol 0.2.1 (requires python2.7 and pip)
### incr 0.2

## Setup
- Link .zshrc

    ```cd```

    ```ln -s  /path/to/dotfiles/dot.zshrc .zshrc```

- Create .zsh.d

    ```mkdir .zsh.d```

    ```cd .zsh.d```

    ```git clone git://github.com/zsh-users/zsh-completions.git```

    ```mv zsh-completions completion```

    ```wget http://mimosa-pudica.net/src/incr-0.2.zsh```

- Install percol

    ```pip install percol```

    ```cp ./rc.py ~/.percol.d/```

## Usage
* On command line
    * "TAB" List candidates
    * "C-r" Narrowing down history
