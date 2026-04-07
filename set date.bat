cd "%~dp0"
if exist processed.txt del processed.txt
if exist error.txt del error.txt
FOR /F "tokens=*" %%G IN ('dir/b/s *.png') DO call "xchk.bat" "%%G"
FOR /F "tokens=*" %%G IN ('dir/b/s *.jpg') DO call "xchk.bat" "%%G"
FOR /F "tokens=*" %%G IN ('dir/b/s *.jpeg') DO call "xchk.bat" "%%G"
FOR /F "tokens=*" %%G IN ('dir/b/s *.jfif') DO call "xchk.bat" "%%G"
::FOR /F "tokens=*" %%G IN ('dir/b/s ^"*.bmp^"') DO call "xchk.bat" "%%G" ;EXIF for bmp is non existent
::FOR /F "tokens=*" %%G IN ('dir/b/s *.gif') DO call "xchk.bat" "%%G" ;No date metadata
echo delete error log if no errors
for /f %%i in ("error.txt") do set size=%%~zi
if %size% leq 0 del error.txt
