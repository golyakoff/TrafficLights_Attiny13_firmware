@echo off
:: Path to avr-gcc bin (same as in build.bat)
set AVRBINPATH=d:\Programs\avr-gcc-15.2.0-x64-windows\bin

:: Get full path to the folder where this batch file resides
set CURDIR=%~dp0
if "%CURDIR:~-1%"=="\" set CURDIR=%CURDIR:~0,-1%

:: Output folder
set OUTDIR=%CURDIR%\out

:: Check if HEX file exists
if not exist "%OUTDIR%\TrafficLight13.hex" (
    echo ERROR: HEX file not found at %OUTDIR%\TrafficLight13.hex
    echo Please run build.bat first.
    pause
    exit /b 1
)

echo Programming fuses and flash for attiny13a...

:: Burn fuses
@"%AVRBINPATH%\avrdude.exe" -C"%AVRBINPATH%\avrdude.conf" -p t13 -c usbasp -b 115200 -Ulfuse:w:0x7a:m -q
if errorlevel 1 goto error

:: Flash firmware
@"%AVRBINPATH%\avrdude.exe" -C"%AVRBINPATH%\avrdude.conf" -p t13 -c usbasp -b 115200 -Uflash:w:"%OUTDIR%\TrafficLight13.hex":a -q
if errorlevel 1 goto error

echo Flash completed successfully.
pause
exit /b 0

:error
echo Flash failed! Check programmer connection and settings.
pause
exit /b 1