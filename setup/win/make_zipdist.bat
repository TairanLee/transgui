@echo off

echo "Usage: %~nx0 <lazarus_dir>"

if "%1" NEQ "" (
    set "LAZARUS_DIR=%1"
) else (
    set "LAZARUS_DIR=C:\lazarus"
)

set path=%LAZARUS_DIR%;%LAZARUS_DIR%\fpc\3.2.2\bin\i386-win32;%path%
set "PROG_VER="
set /p "PROG_VER="<..\..\VERSION.txt
if not defined PROG_VER goto err

lazbuild -B ../../transgui.lpi
if errorlevel 1 goto err
make "PROG_VER=%PROG_VER%" -C ../.. clean
if errorlevel 1 goto err
make "PROG_VER=%PROG_VER%" -C ../.. all
if errorlevel 1 goto err
upx --best ../../transgui.exe
if errorlevel 1 goto err
make "PROG_VER=%PROG_VER%" -C ../.. zipdist
if errorlevel 1 goto err

pause
exit /b 0

:err
pause
exit /b 1
