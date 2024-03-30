#!/bin/bash
# Maps spaces for displays in yabai
#
# For a single display, the output is an unchanged input
# e.g., 1 -> 1, 2 -> 2, 3 -> 3
#
# but when a second display is used, space 1 is mapped to start with display 2
# e.g., for 4 spaces split across 2 displays: 1 -> 3, 2 -> 4, 3 -> 1, 4 -> 2
#

INDICES=$(yabai -m query --spaces | jq '[.[] | {index: .index, display: .display}] | [group_by(.display)[] | sort_by(.index)] | sort_by(.[0].display) | reverse | flatten | .[] | .index')

declare -a indices_array
for index in $INDICES; do
    indices_array+=("$index")
done

echo "${indices_array[$(( $1 - 1 ))]}"
