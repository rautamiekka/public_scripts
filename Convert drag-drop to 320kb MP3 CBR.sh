#!/usr/bin/env bash
##NOTE: This'll auto-delete the file after FFmpeg terminates.

while [ "${1}" != "" ]; do
    if [[ -f "${1}" ]]; then
        ffmpeg -i "${1}" -codec:a libmp3lame -b:a 320k -compression_level 0 "${1%.*}".mp3

        rm -f "${1}"

        shift
    fi
done
