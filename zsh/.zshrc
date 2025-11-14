# path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# path to custom configuration
export CONFIG="$HOME/.config"

# theme
ZSH_THEME="half-life"

# plugins
plugins=(git)

# disable annoying auto update
export DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

# user custom config
if [ -e "$CONFIG/zsh/custom.zsh" ]; then
    source $CONFIG/zsh/custom.zsh
else
    mkdir -p $CONFIG/zsh
    touch $CONFIG/zsh/custom.zsh
fi

# tools path
TOOLS_DIR="$HOME/tools"
# desktop path
DESKTOP_DIR="$HOME/Desktop"
# code path
CODE_PATH="$DESKTOP_DIR/code"
# temp path
TEMP_PATH="$DESKTOP_DIR/temp"

# if exist, add tools to system path
if [ -d $TOOLS_DIR ]; then
    for tool in "$TOOLS_DIR"/*/; do
       if [[ -d "$tool" ]]; then
           export PATH="$PATH:$tool"
           # add tools to path from  bin directory
           if [[ -d "$tool/bin" ]] then
               export PATH="$PATH:${tool}bin"
           fi
       fi
    done
fi

# ssh flag
if [ -n "$SSH_CONNECTION" ]; then
    PS1="%F{red}<ssh>%f $PS1"
fi

# load .profile
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# language setting
export LANG=en_US.UTF-8

# Aliases
# edit custom config file
alias custom="vim $CONFIG/zsh/custom.zsh && source $CONFIG/zsh/custom.zsh"

# common directory aliases
if [ -d $DESKTOP_DIR ]; then
    alias desktop="$DESKTOP_DIR"
    if [ -d $TEMP_PATH ]; then
        alias temp="~/Desktop/temp"
        alias draft="vim $TEMP_PATH/draft.temp"
    fi
    if [ -d $CODE_PATH ]; then
        alias code="~/Desktop/code"
    fi
    if [ -d $DESKTOP_DIR/Document/Markdown ]; then
        alias markdown='~/Desktop/Document/Markdown'
    fi
fi

# emacs aliases
if command -v emacs > /dev/null; then
    # emacs editor
    alias emacs='emacs -nw'
    # todo list
    alias todo='emacs -nw ~/.emacs.d/org/todo-list.org'
fi

# xh aliases
if command -v xh >/dev/null; then
    alias hpg='xh get'
    alias hpp='xh post'
    alias hpgv='xh -v get'
    alias hppv='xh -v post'
fi

# vim aliases
if command -v vim >/dev/null; then
    # disable coc
    alias cvim="OSTYPE=msys vim"
    # lite vim
    alias lvim="vim -u $HOME/.vim/lite.vimrc"
fi

# git extension alias
# shallow clone
alias 'gcls'='git clone --depth 1'

# Custom functions
# use grep & fzf to find content in dir
if command -v fzf >/dev/null; then
    grepf() {
        grep -REIHns --exclude-dir=.git "$1" . | \
            fzf --delimiter : \
            --preview 'bat --color=always --style=numbers -r {2}: {1}' \
            --bind 'enter:become(vim {1} +{2})' \
            --bind 'j:down' \
            --bind 'k:up' \
            --layout=reverse
        }
fi

# use rg & fzf to find content in dir
if command -v fzf >/dev/null && command -v rg >/dev/null; then
rgf() {
    rg -F --no-heading --line-number --color=never --follow "$1" . | \
        fzf --delimiter : \
        --preview 'bat --color=always --style=numbers -r {2}: {1}' \
        --bind 'enter:become(vim {1} +{2})' \
        --bind 'j:down' \
        --bind 'k:up' \
        --layout=reverse
}
fi

# use ag & fzf to find content in dir
if command -v fzf >/dev/null && command -v ag >/dev/null; then
agf() {
    ag --literal --nobreak --noheading --numbers --ignore-dir=.git "$1" . | \
        fzf --delimiter : \
        --preview 'bat --color=always --style=numbers -r {2}: {1}' \
        --bind 'enter:become(vim {1} +{2})' \
        --bind 'j:down' \
        --bind 'k:up' \
        --layout=reverse
}
fi

# set do not raise error when can't match
setopt nonomatch

