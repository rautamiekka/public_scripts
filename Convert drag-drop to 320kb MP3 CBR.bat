REM REM NOTE: This'll auto-delete the file after FFmpeg terminates.

IF [%1] == [] (
    GOTO :EOF
)

:loop
"C:\Users\Public\Downloads\ffmpeg\bin\ffmpeg.exe" -i "%~1" -codec:a libmp3lame -b:a 320k -compression_level 0 "%~dp1%~n1".mp3
DEL /F "%~1"
SHIFT

IF NOT [%1] == [] (
    GOTO LOOP
)

PAUSE
EXIT
