REM REM Typically this file needs to be run through the 'Run as Admin' option.

START "Anaconda 3" /MAX C:\ProgramData\Anaconda3\Scripts\conda.exe update --verbose conda pip --all
START "Anaconda 2" /MAX C:\ProgramData\Anaconda2\Scripts\conda.exe update --verbose conda pip --all