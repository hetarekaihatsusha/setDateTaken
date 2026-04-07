SETLOCAL
FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-FileModifyDate" %1') DO set fmod=%%G:%%H:%%I:%%J:%%K
FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-FileCreateDate" %1') DO set fcre=%%G:%%H:%%I:%%J:%%K
FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-ModifyDate" %1') DO set mod=%%G:%%H:%%I:%%J:%%K
FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-CreateDate" %1') DO set crea=%%G:%%H:%%I:%%J:%%K
FOR /F "tokens=3 delims=:/" %%G IN ('exiftool "-MimeType" %1') DO set rext=%%G
if /i "jpeg"=="%rext%" FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-DateTimeOriginal" %1') DO set dori=%%G:%%H:%%I:%%J:%%K
if /i "jpeg"=="%rext%" FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-DateAcquired" %1') DO set dacq=%%G:%%H:%%I:%%J:%%K
if /i "jfif"=="%rext%" FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-DateAcquired" %1') DO set dacq=%%G:%%H:%%I:%%J:%%K
if /i "png"=="%rext%" FOR /F "tokens=2-8 delims=:+" %%G IN ('exiftool "-CreationTime" %1') DO set pcre=%%G:%%H:%%I:%%J:%%K
set sx=%~x1
if /i "%~x1"==".jpg" set sx=.jpeg
if /i "%sx%"==".%rext%" goto :ok
::if /i "%rext%"=="jpeg" goto :ok
echo Faked or renamed extension: %rext% as %~x1>>processed.txt
ren %1 "%~n1.%rext%"
call df.bat "%~d1%~p1%~n1.%rext%"
goto :eof
:ok
call df.bat %1