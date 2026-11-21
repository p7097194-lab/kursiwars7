@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul || (echo Install Node.js 20 LTS from https://nodejs.org/ first.& pause & exit /b 1)
if not exist node_modules call npm install
if errorlevel 1 (echo Dependency installation failed.& pause & exit /b 1)
call npm run build
if errorlevel 1 (echo Build failed. Review the output above.& pause & exit /b 1)
echo Production web build is in the dist folder.
pause
