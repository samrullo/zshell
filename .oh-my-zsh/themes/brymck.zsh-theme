function collapse_pwd {
  echo $(pwd | sed -e "s#^$HOME#~#" | sed -e "s#^$Bfm#\$Bfm#")
}

function show_client {
  echo "%{$fg_bold[red]%}$(hostname)%{$reset_color%}"
}

function as_client {
  if [ -n "$CLIENT" ]; then
    echo "%{$fg_no_bold[magenta]%}${CLIENT:l}%{$reset_color%} via "
  fi
}

function precmd() {
  print
}

local prompt_user="%{$fg_no_bold[yellow]%}$USER%{$reset_color%}"
local prompt_machine="%{$fg_bold[red]%}%M%{$reset_color%}"
local prompt_time="%{$fg_no_bold[cyan]%}%D{%-m/%d %-I:%M:%S %p}%{$reset_color%}"
local prompt_char="%{$fg_bold[white]%}\$%{$reset_color%}"

PROMPT="$prompt_user on \$(as_client)$prompt_machine in %{$fg_no_bold[green]%}\$(collapse_pwd)%{$reset_color%} at $prompt_time"$'\n'"$prompt_char "

# vim:ft=zsh
