#!/usr/bin/env bash
##NOTE: This'll auto-delete the file after FFmpeg terminates.

shopt -s nocasematch

for i in *'.flac'; do
    if [[ -f "${i}" ]]; then
        ffmpeg -i "${i}" -codec:a libmp3lame -b:a 320k -compression_level 0 "${i%.*}"'.mp3'

        rm -f "${i}"

        shift
    fi
done
