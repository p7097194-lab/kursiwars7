@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul || (echo Install Node.js 20 LTS from https://nodejs.org/ first.& pause & exit /b 1)
call npm install
if errorlevel 1 (echo Installation failed.& pause & exit /b 1)
echo Dependencies installed. Use START-WINDOWS.bat to play locally.
pause
