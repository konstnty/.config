autoload -U colors && colors
setopt autocd

# History
HISTFILE=~/.config/zsh/histfile
SAVEHIST=10000

# tab autocomp
autoload -U compinit
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1


# change cursor for diffrent vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[4 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[4 q"
}
zle -N zle-line-init
echo -ne '\e[4 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[4 q' ;} # Use beam shape cursor for each new prompt.

# aliases
alias snre='sudo netctl restart eduroam'
alias sbtop='sudo btop'
alias re='sudo renoise'
alias p='sudo pacman'
alias nv='nvim'
alias ls='ls -h --color=auto'
alias sdn='sudo shutdown now'
alias sr='sudo reboot'
alias br='brightnessctl'
alias bl='bluetoothctl'
alias su='su -'
alias ncmpcpp='ncmpcpp -q'
alias z='zathura'
alias pipes='bash-pipes -t0 -t1 -t3 -r5000'
alias pa='ping -c 12 archlinux.org'
alias pm='pulsemixer'
alias ncdu='ncdu --color dark'
alias wtr='curl -s wttr.in/$(curl -s ifconfig.co/city)\?T | grep -v "updates$"'
alias nn='neo -m "NNOONNEE  OOFF  TTHHIISS  IISS  RREEAALL" -F -S 9.0 -s'

# color of ls output
LS_COLORS=$LS_COLORS:'di=0;31' ; export LS_COLORS
LS_COLORS=$LS_COLORS:'ex=0;32' ; export LS_COLORS

# script path
export PATH=/home/konst/Scripts:$PATH
export FZF_DEFAULT_COMMAND="find -L"
export VST_PATH=/home/konst/.vst:$VST_PATH
export VST3_PATH=/home/konst/.vst3:$VST3_PATH



# Usage: prompt-length TEXT [COLUMNS]
#
# If you run `print -P TEXT`, how many characters will be printed
# on the last line?
#
# Or, equivalently, if you set PROMPT=TEXT with prompt_subst
# option unset, on which column will the cursor be?
#
# The second argument specifies terminal width. Defaults to the
# real terminal width.
#
# Assumes that `%{%}` and `%G` don't lie.
#
# Examples:
#
#   prompt-length ''            => 0
#   prompt-length 'abc'         => 3
#   prompt-length $'abc\nxy'    => 2
#   prompt-length '❎'          => 2
#   prompt-length $'\t'         => 8
#   prompt-length $'\u274E'     => 2
#   prompt-length '%F{red}abc'  => 3
#   prompt-length $'%{a\b%Gb%}' => 1
#   prompt-length '%D'          => 8
#   prompt-length '%1(l..ab)'   => 2
#   prompt-length '%(!.a.)'     => 1 if root, 0 if not
function prompt-length() {
  emulate -L zsh
  local COLUMNS=${2:-$COLUMNS}
  local -i x y=$#1 m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ));
    done
    local xy
    while (( y > x + 1 )); do
      m=$(( x + (y - x) / 2 ))
      typeset ${${(%):-$1%$m(l.x.y)}[-1]}=$m
    done
  fi
  echo $x
}

# Usage: fill-line LEFT RIGHT
#
# Prints LEFT<spaces>RIGHT with enough spaces in the middle
# to fill a terminal line.
function fill-line() {
  emulate -L zsh
  local left_len=$(prompt-length $1)
  local right_len=$(prompt-length $2 9999)
  local pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
  if (( pad_len < 1 )); then
    # Not enough space for the right part. Drop it.
    echo -E - ${1}
  else
    local pad=${(pl.$pad_len.. .)}  # pad_len spaces
    echo -E - ${1}${pad}${2}
  fi
}

# Sets PROMPT and RPROMPT.
#
# Requires: prompt_percent and no_prompt_subst.
function set-prompt() {
  emulate -L zsh
  local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  git_branch=${${git_branch//\%/%%}/\\/\\\\\\}  # escape '%' and '\'

  local top_left='%F{blue}%~%f'
  local top_right="%F{green}${git_branch}%f"
  local bottom_left="%{$fg[blue]%}%~ »%{$reset_color%}%b "
  local bottom_right='%F{green}%*%f'

  PROMPT=$bottom_left
  RPROMPT=$bottom_right
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
setopt noprompt{bang,subst} prompt{cr,percent,sp}


# this whole prompt is stolen from https://gist.github.com/romkatv/2a107ef9314f0d5f76563725b42f7cab
# by romkatv (Roman Perepelitsa)


