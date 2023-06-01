#!/usr/bin/env bash

# Copy text to the clipboard
cp_to_clipboard() {
  if [[ "$(uname)" == "Darwin" ]] && is_binary_exist "pbcopy"; then
    echo -n "$1" | pbcopy
  elif [[ "$(uname)" == "Linux" ]] && is_binary_exist "wl-copy"; then
    echo -n "$1" | wl-copy
  elif [[ "$(uname)" == "Linux" ]] && is_binary_exist "xsel"; then
    echo -n "$1" | xsel -b
  elif [[ "$(uname)" == "Linux" ]] && is_binary_exist "xclip"; then
    echo -n "$1" | xclip -i
  else
    return 1
  fi
}

# Check if binary exist
is_binary_exist() {
  local binary=$1

  command -v "$binary" &> /dev/null
  return $?
}

# Get tmux option
get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value=$(tmux show-option -gv "$option")

  if [[ -z "$option_value" ]]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

not_in_tmux() {
  [ -z "$TMUX" ]
}

# Display tmux message in status bar
display_tmux_message() {
  local message=$1
  tmux display-message "tmux-switcher: $message"
}

session_exists() {
  local session_name=$1
  tmux has-session -t "=$session_name"
}

create_detached_session() {
  local session_name=$1
  local selected=$2
  (TMUX='' tmux new-session -Ad -s "$session_name" -c "$selected")
}

create_if_needed_and_attach() {
  local session_name=$1
  local selected=$2
  if not_in_tmux; then
    tmux new-session -As "$session_name" -c "$selected"
  else
    if ! session_exists "$session_name"; then
      create_detached_session "$session_name" "$selected"
    fi
    tmux switch-client -t "$session_name"
  fi
}
