# dotfiles

## Environment
* WSL Ubuntu-24.04 on Windows11
* zsh 5.9 (x86_64-ubuntu-linux-gnu)
* percol 0.2.1 (requires python2.7 and pip)
* incr 0.2

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

- Prepare Python venv

    ```sudo apt install python3-venv```

    ```python3 -m venv .python3_venv```

- Install en locale

l    ```sudo apt install language-pack-en```

- Install percol

    ```pip install percol```

    ```cp ./rc.py ~/.percol.d/```

## Usage
* On command line
    * "TAB" List candidates
    * "C-r" Narrowing down history
