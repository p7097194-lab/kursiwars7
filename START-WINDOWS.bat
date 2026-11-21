@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js was not found. Install Node.js 20 LTS from https://nodejs.org/ and reopen this file.
  pause
  exit /b 1
)
if not exist node_modules (
  echo Installing game dependencies...
  call npm install
  if errorlevel 1 goto failed
)
start "Kursi Wars multiplayer" cmd /k "cd /d "%~dp0" && npm run server"
timeout /t 2 /nobreak >nul
start "Kursi Wars web game" cmd /k "cd /d "%~dp0" && npm run dev"
timeout /t 3 /nobreak >nul
start "" http://localhost:5173
exit /b 0
:failed
echo Dependency installation failed. Check your internet connection and try again.
pause
exit /b 1
