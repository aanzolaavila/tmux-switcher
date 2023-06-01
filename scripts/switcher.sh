#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

source "./utils.sh"

main() {
  selected_session=$(tmux ls | cut -d: -f1 | fzf)
  session_name=$(basename "$selected_session" | tr . _)

  create_if_needed_and_attach "$session_name" "$selected_session"
}

main "$@"
