#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

# --- color capability detection (now actually meaningful) ---
use_color=false
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

# --- git prompt ---
[[ -r ~/.git-prompt.sh ]] && . ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=1        # * unstaged, + staged
GIT_PS1_SHOWSTASHSTATE=1        # $
GIT_PS1_SHOWUNTRACKEDFILES=1    # %
GIT_PS1_SHOWUPSTREAM="verbose"  # u+2-1 ahead/behind
GIT_PS1_SHOWCONFLICTSTATE=yes   # |CONFLICT  (must be literally "yes")
GIT_PS1_STATESEPARATOR=" "
GIT_PS1_SHOWCOLORHINTS=1        # pcmode only
GIT_PS1_HIDE_IF_PWD_IGNORED=1

__prompt() {
    local ec=$?                       # must be the very first line
    local pre="" post=""

    pre="\n"
    # exit status, only when nonzero
    if (( ec != 0 )); then
        pre+="\[\e[31m\]${ec}\[\e[0m\] "
    fi

    # background/stopped jobs, only when present
    local nj=${#___jobs[@]}
    if (( nj > 0 )); then
        pre+="\[\e[33m\][${nj}]+\[\e[0m\] "
    fi

    pre+="\[\e[1;32m\][\u@\h]\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]"
    post="\n\$ "

    if type -t __git_ps1 >/dev/null; then
        __git_ps1 "$pre" "$post" " (%s)"
    else
        PS1="$pre$post"
    fi
}

# jobs must be counted in the parent shell, not a subshell
__count_jobs() { mapfile -t ___jobs < <(jobs -p); }

PROMPT_COMMAND='__count_jobs; __prompt'
if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

hidetitlebar() {
  user=$(whoami)
  host=$(hostname)

  if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    win_id=$(wmctrl -l | grep "$user@$host" | awk '{print $1}')

    # hide for each wezterm window
    for win in $win_id; do
      xprop -id $win -format _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS 2
    done
  fi
}

# custom alias
alias ll="ls -lah"
alias rm="rm -v"
alias wezterm="flatpak run org.wezfurlong.wezterm "
alias tma="tmux a"
alias tm="tmux"
alias ox="sudo oxker"
alias tw="task +twork"
alias tp="task +tpersonal"
alias e="nvim"

# defaults
export EDITOR="nvim"

# nvm completion
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# pnpm
export PNPM_HOME="/home/prayush/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fzf shell integration
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# terminal colors
export TERM="xterm-256color"
. "$HOME/.cargo/env"

# opencode
export PATH=/home/prayush/.opencode/bin:$PATH

# golang
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"

# Enable bash-completion if available
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# java
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/prayush/.lmstudio/bin"
# End of LM Studio CLI section

# android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH

# # openclaw
# export PATH="$(npm prefix -g)/bin:$PATH"
