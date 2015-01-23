@echo off
REM - File: fix_xlsx.bat
REM - Description: Fix corrupted .xlsx file exported from AutoQuotes
REM - Author: Tommy Goode
REM - Copyright 2015 International Restaurant Distributors, Inc.

: set up temp vars
set "script_dir=%~dp0"
set "tempdir=%script_dir%temp"
set "tempfile=%tempdir%\temp.zip"
set "tempfixed=%tempdir%\tempfixed.zip"
set "file_dir=%~dp1"
set "fixedfilename=fixed.xlsx"
set "fixedfile=%file_dir%%fixedfilename%"
echo.
echo Fixed file will be: %fixedfile%

: make temp dir and ensure it is empty
if exist "%tempdir%\" rd /s /q %tempdir%
mkdir "%tempdir%"

: copy local, make .zip
copy /Y %1 %tempdir%\temp.zip > nul

: cd into to tmp dir
cd "%tempdir%"

: unzip xlsx file
%script_dir%\izarc\izarce.exe -e -d -o %tempfile% > nul
del "%tempfile%"
%script_dir%\izarc\IZARCC.exe -a -r -p %tempfixed% > nul

copy /Y "%tempfixed%" "%fixedfile%" > nul
del "%tempfixed%" > nul

echo.
echo Done!
pause

: for some reason we can't open the file with an absolute path
cd "%file_dir%"
start %fixedfilename%
