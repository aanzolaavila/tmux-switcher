#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

source "./utils.sh"

main() {
  selected="$(tmux ls | cut -d: -f1 | fzf)" || return

  create_if_needed_and_attach "$selected" "$selected"
}

main "$@"
