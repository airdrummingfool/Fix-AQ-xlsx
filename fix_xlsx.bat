cd
@echo off
: make temp dir
mkdir temp

: copy local, make .zip
copy /Y %1 temp\temp.zip

: cd into to tmp dir
cd temp

: unzip xlsx file
..\izarc\izarce.exe -e -d -o temp.zip
del temp.zip
cd
..\izarc\IZARCC.exe -a -r -p -x"tempfixed.zip" ..\temp\tempfixed.zip
copy /Y tempfixed.zip ..\fixed.xlsx
cd ..
rd /S /Q temp
pause
start fixed.xlsx