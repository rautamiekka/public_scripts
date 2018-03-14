#!/usr/bin/env bash
##NOTE: This'll auto-delete the file after FFmpeg terminates.

while [ "${1}" != "" ]; do
    if [[ -f "${1}" ]]; then
        ffmpeg -i "${1}" -loop 1 "${1%.*}".gif

        rm -f "${1}"

        shift
    fi
done
