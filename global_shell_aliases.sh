##Without a shebang so other shells than Bash can benefit.##
# shellcheck shell=bash  #As far as ShellCheck is considered it can think of the script as a Bash script since that's usually what I'm writing for, and Zsh runs most Bash scripts as is anyway; sadly ShellCheck doesn't support Zsh.

##Typically loaded through the in-built `source` command (in Bash).

alias lavh='ls -lavh --color=always '
alias lavhR='ls -lavhR --color=always '
alias lavhr='ls -lavhR --color=always '  ##Only to make writing the above easier, the small 'r' ain't the same (reverse) as the big 'R' (recursive).
alias egrep='egrep --line-number --color=always --with-filename '
alias grep='grep --line-number --color=always --with-filename '

##Change this according to what the 7-Zip binary is called on your system.
##  As of Ubuntu 22.04 LTS the package is called `7zip` in which the binary is called `7zz`. The old package `p7zip[-full]` in which it's called `7z` was abandoned for ages and not updated beyond 16.02. The one for Ubuntu 22.04 LTS is still behind Ubuntu 22.10, but still better than the ancient 7-Zip 16.02.
_binary_7z='7zz'

##Change this according to how many threads you want the 7-Zip and XZ binaries to use for compression.
##  REMEMBER TO TEST THE MEMORY USAGE BEFOREHAND !
_threads_7z_xz=3

for _mb in 64 128 192 256 384 512 768 1000 1536; do
    ##Enable only if `7z` is somehow installed in `$PATH`.
    ##  Compress using P7-Zip with LZMA2, ${_mb}MB dictionary size, and ${_threads_7z_xz} threads. 64MB still works on 32-bit software and system.
    ##  Uses lowest possible non-idle priorities to impose as little performance penalty as possible on the other processes, _
    ##    which in turn makes the compression slower.
    [ "$(command -v "${_binary_7z}")" ] && {
        # shellcheck disable=SC2139  #We know the var expands during definition of the alias.
        alias 7zfull${_mb}='echo '\''NOTE: §7zfull'"${_mb}"'§ stores the target data of a symlink instead of the symlink itself.'\''; ionice -c 2 -n 7 nice -n 20 '"${_binary_7z}"' a -t7z -mx=9 -ms=on -mhc=on -mhe=off -m0=LZMA2:a=1:d='"${_mb}"'m:mf=bt4:fb=273:mc=1000000000:lc=3:lp=1:pb=4 -mmt='"${_threads_7z_xz}"' -mtc=off -bb3 -bt -ssw '

        # shellcheck disable=SC2139  #We know the var expands during the definition of the alias.
        alias 7zfullsym${_mb}='echo '\''NOTE: §7zfullsym'"${_mb}"'§ stores symlinks as is instead of the target data.'\''; ionice -c 2 -n 7 nice -n 20 '"${_binary_7z}"' a -t7z -mx=9 -ms=on -mhc=on -mhe=off -m0=LZMA2:a=1:d='"${_mb}"'m:mf=bt4:fb=273:mc=1000000000:lc=3:lp=1:pb=4 -mmt='"${_threads_7z_xz}"' -mtc=off -bb3 -bt -ssw '
    }

    ##Enable only if `xz` is somehow installed in `$PATH`.
    ##  Compress using XZ with LZMA2, ${_mb}MB dictionary size, and ${_threads_7z_xz} threads, in Extreme mode. 64MB still works on 32-bit software and system.
    ##  Uses lowest possible non-idle priorities to impose as little performance penalty as possible on the other processes, _
    ##    which in turn makes the compression slower.
    [ "$(command -v 'xz')" ] && {
        # shellcheck disable=SC2139  #We know the var expands during the definition of the alias.
        alias xzfull${_mb}='ionice -c 2 -n 7 nice -n 20 xz -vvz9e --lzma2=dict='"${_mb}"'MiB,mf=bt4,nice=273 --threads='"${_threads_7z_xz}"' '
    }
done

for _app in 'aptitude' 'apt' 'apt-get'; do
    [ "$(command -v "${_app}")" ] && {
        ##Along with updating the Snap packages, update the native Debian packages, only creating an alias matching the app in the given order.
        ##Uses lowest possible non-idle priorities to impose as little performance penalty as possible on the other processes, _
        ##  which in turn potentially makes the upgrade process slower since every process spawned by ${_app} will inherit its priorities.
        # shellcheck disable=SC2139  #We know the var expands during the definition of the alias.
        alias upg='sudo snap refresh; sudo '"${_app}"' update; sudo '"${_app}"' full-upgrade ' && break
    }
done

[ "$(command -v 'ethstatus')" ] && {
    ##Make `ethstatus` have the lowest possible non-idle priorities.
    alias ethstatus='sudo ionice -c 2 -n 7 nice -n 20 ethstatus '

    ##Optional: same as above, but for first WLAN.
    alias ethstatus_wlan0='sudo ionice -c 2 -n 7 nice -n 20 ethstatus -i wlan0 '
}

[ "$(command -v 'iotop')" ] && {
    ##Make `iotop` have the lowest possible non-idle priorities and show only the processes which are doing IO.
    alias iotop='sudo ionice -c 2 -n 7 nice -n 20 iotop -o '
}

[ "$(command -v 'dpkg')" ] && {
    ##If it doesn't print anything but the standard warning about GNOME Virtual File System, it's safe to manually delete the lock.
    alias print_dpkg_lock_holders='sudo lsof | grep '\''/var/lib/dpkg/lock'\'' '
}

####Make both `htop`, `top`, and any other programs have the lowest possible non-idle priorities.####
for _app in 'htop' 'top' 'btop'; do
    [ "$(command -v "${_app}")" ] && {
        # shellcheck disable=SC2139  #We know the var expands during the definition of the alias.
        alias ${_app}='sudo ionice -c 2 -n 7 nice -n 20 '"${_app}"' '
    }
done
################################################################################
