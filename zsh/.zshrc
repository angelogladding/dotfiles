ZSH=$HOME/.oh-my-zsh
ZSH_THEME=../../simplified-agnoster
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git mercurial poetry)
source $ZSH/oh-my-zsh.sh
unsetopt correct_all

## HISTORY ##

export HISTSIZE=250000 SAVEHIST=250000
STARTING="true"
LOG=~/.logfiles/zsh
function precmd() {
  if [[ "$STARTING" == "true" ]]; then
    STARTING="false"
    return
  fi
  if [ "$(id -u)" -ne 0 ]; then
    echo -n "`/bin/date +%Y-%m-%dT%H:%M:%S.%N` $$ `pwd`" >> ${LOG};
    echo " !! `fc -l -1 | sed 's/^  *//g' | sed 's/  / /'`" >> ${LOG};
  fi
}
function preexec() {
  if [ "$(id -u)" -ne 0 ]; then
    echo -n "`/bin/date +%Y-%m-%dT%H:%M:%S.%N` $$ `pwd`" >> ${LOG};
    echo " \$\$ $3" >> ${LOG};
  fi
}

## AUTOCOMPLETE ##

_force_rehash() {
  (( CURRENT == 1 )) && rehash
  return 1
}

zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete

# nose autocomplete
autoload -U compinit
compinit
autoload -U bashcompinit
bashcompinit
# _nosetests() {
#   cur="${COMP_WORDS[COMP_CWORD]}"
#   COMPREPLY=(`nosecomplete ${cur} 2>/dev/null`)
# }
# complete -o nospace -F _nosetests nosetests
# 
# # pip autocomplete
# function _pip_completion {
#   local words cword
#   read -Ac words
#   read -cn cword
#   reply=( $( COMP_WORDS="$words[*]" \
#              COMP_CWORD=$(( cword-1 )) \
#              PIP_AUTO_COMPLETE=1 $words[1] ) )
# }

stty stop undef  # unmap ^s
stty start undef  # unmap ^q

export DEFAULT_USER="angelo"
export NAME="Angelo Gladding"
export EMAIL="angelo@ragt.ag"
export WEBSITE="ragt.ag"

# export TERM="xterm-256color"
export TERM="screen-256color"
export EDITOR="vim"
export PAGER="less"
export COLORS_ON=True

export LANGUAGE="en_US.UTF-8"
export LANG="en_us.utf-8"
export LC_ALL="en_US.UTF-8"
export TZ="America/Los_Angeles"

export XDG_CONFIG_HOME=$HOME/.config

export PATH=/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin  # XXX
export PATH=$PATH:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games  # XXX
export PATH=/home/angelo/.software/bin:/home/angelo/.local/bin:$PATH
export PATH=/home/angelo/.var/nvim/bin:$PATH

export PYTHONDONTWRITEBYTECODE="true"
export PIP_DOWNLOAD_CACHE=$HOME/.env/pip-download-cache
export LD_LIBRARY_PATH=$HOME/.env/envs/sys/lib:$LD_LIBRARY_PATH  # POSTGRES

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias g='grep'
alias df='df -h'

alias l='ls -shC1F'
alias la='l -a'
alias ll='ls -lhF'

alias tree='tree -AvI __pycache__'
alias t='tree'
alias t1='tree -L 1'
alias t2='tree -L 2'
alias t3='tree -L 3'
alias t4='tree -L 4'
alias t5='tree -L 5'

alias loc='pss --py -f | head -n-1 | xargs wc -l | sort -h'

alias dv='killall devilspie2 > /dev/null; nohup devilspie2 > /dev/null 2>&1 &!'

alias pbcopy='xclip -selection clipboard -r'
alias pbpaste='xclip -selection clipboard -o'

# alias ssh='ssh -o TCPKeepAlive=no -o ServerAliveInterval=15'

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'  # e.g.: "sleep 10; alert"
alias pcat='pygmentize -f terminal256 -O style=Solar -g'
alias free='free -m'
alias cleanup='pss -ag "((nosetests|coverage).xml|.coverage|.*\.pyc)\$" | xargs --no-run-if-empty rm'
# alias most_used_history='cat .zsh_history | tr "\|\;" "\n" | sed -e "s/^ //g" | cut -d " " -f 1 | sort | uniq -c | sort -n | tail'
# !!OLDER!! alias play='cvlc -q --no-osd -L --no-video-title-show --x11-display :0 -I ncurses'
# alias play='mplayer'
alias vpn='sudo openvpn ~/.openvpn/US-California-2048.ovpn'
alias ring='echo -e "\a"'
alias dir_status='for dir in $(ls); do echo $dir; git -C $dir status; echo ""; done'

play() {
  cvlc $@ > /dev/null 2>&1
  # cvlc -I rc --rc-host localhost:3859 $@ > /dev/null 2>&1 &!
  # sleep 1
  # nc localhost 3859
}

di() {
  (~/di ~/di.flv $1 & (sleep 4 && mplayer ~/di.flv))
}

sql() {
  sqlite3 $1 $2 2> /dev/null
}

sumlines() {
  awk '{ sum += $1 } END { print sum }' $1
}

stats() {
  radon raw $1 | grep -i $2 | cut -d" " -f6 | sumlines
}

fs() {
  du -sh $1/* | sort -hr
}

vi() {
  poetry show -q;
  if [[ $? -ne 0 ]]; then
    nvim $1;
  else
    poetry run nvim $1;
  fi
}

# activate() {
#   source ~/.env/envs/$1/bin/activate
#   export PATH=$PATH:~/.env/envs/$1/local/bin:~/.env/envs/$1/sbin
#   compctl -K _pip_completion pip
#   # export HOME=~/.gaea
# }
# activate sys

# source /home/angelo/.working/x/bin/activate

# for termapp in pkg web; do
#     eval "$(register-python-argcomplete $termapp)"
# done

# [[ $- != *i* ]] && return  # if not running interactively, exit
# [[ -z "$TMUX" ]] && exec tmux new -n "~"
# source ~/.zsh/zaw/zaw.zsh

export DISABLE_AUTO_TITLE="true"

export PATH="$HOME/.poetry/bin:$PATH"
fpath+=~/.zfunc
