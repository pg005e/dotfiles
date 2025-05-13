# Setup fzf
# ---------
if [[ ! "$PATH" == */home/prayush/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/prayush/.fzf/bin"
fi

eval "$(fzf --bash)"
