#!/usr/bin/env bash

set -x

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

source "./utils.sh"

get_locations() {
  local locs
  locs=$(get_tmux_option @tmux-switcher-locations "")

  echo -n "${locs}"
}

main() {
  local locations
  locations=$(get_locations)

  selected="$(fd --type d -H '.git$' "${locations}" | sed 's/\/.git\///' | fzf)" || return
  session_name="$(basename "$selected" | tr . _)"

  create_if_needed_and_attach "$session_name" "$selected"
}

main "$@"
