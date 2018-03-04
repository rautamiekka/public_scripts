REM REM NOTE: This'll auto-delete the FLAC after FFmpeg terminates.

FOR /R "%~dp0" %%f IN (*.flac) DO (
    "C:\Users\Public\Downloads\ffmpeg\bin\ffmpeg" -i "%%f" -codec:a libmp3lame -b:a 320k -compression_level 0 "%%~nf".mp3
    DEL /F "%%f"
)

PAUSE
