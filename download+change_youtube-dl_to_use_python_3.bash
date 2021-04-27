#!/usr/bin/env bash
##This script requires Bash !

##This script is a hack which creates a copy of the original ytdl with a shebang which forces the use _
##  of Python 3, since (at least in Bash) the shebang can't be anywhere else but the very first line, _
##  thus the original used (and still present) is ignored.

##Either run as a script or copypaste the code below, including the starting and ending brackets.

##Change the §_target_filename§ below to what filename you want the Python 3 one to have.
##    The modified one is saved into the current folder.
(
    _target_filename='youtube-dl-py3'

    _owner_and_repo='ytdl-org/youtube-dl'
    _releases_html=$(wget --quiet 'https://github.com/'"${_owner_and_repo}"'/releases/latest' -O -)
    if [ "${_releases_html}" ]; then
        _link=$(sed -rne 's|.*href="(/'"${_owner_and_repo}"'/releases/download/[^/]++/youtube-dl)".*+|\1|p' <<< "${_releases_html}")

        if [ "${_link}" ]; then
            echo '#!/usr/bin/env python3' > "${_target_filename}"
            wget --verbose --no-check-certificate --no-glob -O - 'https://github.com'"${_link}" >> "${_target_filename}"
        else
            echo 'Detecting the software version failed. Quitting.'
        fi
    else
        echo 'Downloading the HTML for the latest release failed. Quitting.'
    fi
)
