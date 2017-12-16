# compile
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
   zcompile ~/.zshrc
fi

# emacs like keybind
bindkey -e
# delete
function delete-region() {
    zle kill-region
    CUTBUFFER=$killring[1]
    shift killring
}
zle -N delete-region

function backward-delete-char-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle backward-delete-char
    else
        zle delete-region
    fi
}
zle -N backward-delete-char-or-region

function delete-char-or-list-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle delete-char-or-list
    else
        zle delete-region
    fi
}
zle -N delete-char-or-list-or-region

bindkey "^h" backward-delete-char-or-region
bindkey "^d" delete-char-or-list-or-region

# copy
function copy-region() {
    zle copy-region-as-kill
    REGION_ACTIVE=0
}
zle -N copy-region
bindkey "^[w" copy-region
# kill
function backward-kill-word-or-region() {
    if [ $REGION_ACTIVE -eq 0 ]; then
        zle backward-kill-word
    else
        zle kill-region
    fi
}
zle -N backward-kill-word-or-region
bindkey "^w" backward-kill-word-or-region

# language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTTIMEFORMAT="%F %T "
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt share_history

# completion
fpath=(~/.zsh.d $fpath)
fpath=(~/.zsh.d/completion $fpath)
autoload -Uz compinit
compinit -uC
zstyle ':completion:*:default' menu select=2

source ~/.zsh.d/incr-0.2.zsh
autoload bashcompinit
bashcompinit

# percol
function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt list_packed
zstyle ':completion:*' list-colors ''

zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

setopt auto_param_slash
setopt mark_dirs

setopt magic_equal_subst
setopt list_types
setopt auto_menu
setopt auto_param_keys
bindkey "^[[Z" reverse-menu-complete


setopt correct
setopt no_beep

# prompt
autoload -Uz colors
colors
setopt prompt_subst
PROMPT='
%{${fg[green]}%}%n@%m %{${fg[yellow]}%}%~%{${reset_color}%}
$ '

# Ctrl-h = backspace
stty sane
if [ "$(stty | grep erase)" = "" ] ; then
    stty erase 
fi

export LESS='-R'
export EDITOR='emacs'

LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.i386.rpm=01;31:*.src.rpm=01;30:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:' ; export LS_COLORS

# alias
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias la='ls -aF'
alias sc='screen -D -RR'

alias ls='ls --color=auto -NF --show-control-chars'
alias emacs='/usr/bin/emacs -nw'
alias Emacs='/usr/bin/emacs'

read_only_emacs() {
[ -f "$1" ] || (echo "No such file or directory: $1" >&2; exit 1)
  emacs "$1" --eval '(setq buffer-read-only t)'
}     
alias remacs='read_only_emacs'

