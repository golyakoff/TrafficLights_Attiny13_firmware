@echo off
:: Path to avr-gcc bin (no quotes, no trailing backslash)
set AVRBINPATH=d:\Programs\avr-gcc-15.2.0-x64-windows\bin

:: Get full path to the folder where this batch file resides
set CURDIR=%~dp0
if "%CURDIR:~-1%"=="\" set CURDIR=%CURDIR:~0,-1%

:: Output folder
set OUTDIR=%CURDIR%\out
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

echo Building TrafficLight13 for attiny13a...

:: Compile
@"%AVRBINPATH%\avr-gcc.exe" -Wall -Os -mmcu=attiny13a -c "%CURDIR%\TrafficLight13.cpp" -o "%OUTDIR%\TrafficLight13.o"
if errorlevel 1 goto error

:: Link
@"%AVRBINPATH%\avr-gcc.exe" -Wall -Os -mmcu=attiny13a -o "%OUTDIR%\TrafficLight13.elf" "%OUTDIR%\TrafficLight13.o"
if errorlevel 1 goto error

:: Generate HEX
@"%AVRBINPATH%\avr-objcopy.exe" -j .text -j .data -O ihex "%OUTDIR%\TrafficLight13.elf" "%OUTDIR%\TrafficLight13.hex"
if errorlevel 1 goto error

:: Show section sizes (Berkeley format)
@"%AVRBINPATH%\avr-size.exe" --format=berkeley --mcu=attiny13a "%OUTDIR%\TrafficLight13.elf"

echo Build succeeded. HEX file is in %OUTDIR%
pause
exit /b 0

:error
echo Build failed!
pause
exit /b 1