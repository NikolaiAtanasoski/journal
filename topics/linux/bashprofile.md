# Configuration #
--------------------
## aliases ## 
```bash
# # # # # ALIASES # # # # #
# rm 
alias rm='rm -i'
# ls
alias ls='ls --color=auto'
alias ll='ls -l'
alias lla='ls -la'
alias lt='ls -latr'
alias l.='ls -d .* --color=auto'

# grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# misc
alias cls='printf "\033c"'
alias vi='vim'
alias mci='mvn clean install'
alias cd..="cd .."

#because ms windows has some programs with same name
alias find="/usr/bin/find.exe"
alias curl="/usr/bin/curl.exe"
alias tar="/usr/bin/tar.exe"
```

## environment variables ## 
```bash
# # # # # ENVIRONMENT VARIABLES # # # # #
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PS1='\n\e[36m\u@$FULLHOSTNAME\e[0m \e[33m$PWD\e[0m \n> '

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

```
## functions ##
```bash
# # # # # FUNCTIONS # # # # #
function clip () {
    cp $* $HOME/trash/clipboard
}
function unclip () {
    mv $HOME/trash/clipboard/* $PWD
}

function hexxdump () {
    hexdump -e '"%08_ad (0x%08_ax)    "8/1 "%02x ""   "8/1 "%02x "' -e '"    "8/1 "%_p""|"8/1 "%_p""\n"' $1
}

function trash () {
    mv $* $HOME/trash/
}

function abspath() {
    # generate absolute path from relative path
    # $1     : relative filename
    # return : absolute path
    if [ -d "$1" ]; then
        # dir
        (cd "$1"; pwd)
    elif [ -f "$1" ]; then
        # file
        if [[ $1 = /* ]]; then
            echo "$1"
        elif [[ $1 == */* ]]; then
            echo "$(cd "${1%/*}"; pwd)/${1##*/}"
        else
            echo "$(pwd)/$1"
        fi
    fi
}
```
