IF [%1] == [] (
    GOTO :EOF
)

:loop
"C:\Users\Public\Downloads\ffmpeg\bin\ffmpeg.exe" -i "%~1" -loop -1 "%~dp1%~n1".gif
SHIFT

IF NOT [%1] == [] (
    GOTO LOOP
)

PAUSE
EXIT