@echo off
title HappyChina Mining Pool
color 0A

echo ============================================
echo   HappyChina Mining Pool - Windows Launcher
echo ============================================
echo.

:: Check if Docker Desktop is installed
where docker >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Docker Desktop is not installed!
    echo.
    echo Please install Docker Desktop for Windows:
    echo   https://www.docker.com/products/docker-desktop/
    echo.
    echo After installing, run this file again.
    echo.
    pause
    start https://www.docker.com/products/docker-desktop/
    exit /b 1
)

:: Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Docker Desktop is not running. Starting it...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    echo Waiting for Docker to start...
    :waitloop
    timeout /t 3 /nobreak >nul
    docker info >nul 2>&1
    if %errorlevel% neq 0 goto waitloop
    echo Docker is ready!
)

echo [OK] Docker is running
echo.

:: Create data directories
echo Creating data directories...
if not exist "%~dp0data\bitcoin" mkdir "%~dp0data\bitcoin"
if not exist "%~dp0data\litecoin" mkdir "%~dp0data\litecoin"
if not exist "%~dp0data\dogecoin" mkdir "%~dp0data\dogecoin"
if not exist "%~dp0data\namecoin" mkdir "%~dp0data\namecoin"
if not exist "%~dp0data\pepecoin" mkdir "%~dp0data\pepecoin"
if not exist "%~dp0data\bells" mkdir "%~dp0data\bells"
if not exist "%~dp0data\luckycoin" mkdir "%~dp0data\luckycoin"
if not exist "%~dp0data\junkcoin" mkdir "%~dp0data\junkcoin"
if not exist "%~dp0data\dingocoin" mkdir "%~dp0data\dingocoin"
if not exist "%~dp0data\shibacoin" mkdir "%~dp0data\shibacoin"
if not exist "%~dp0data\trumpow" mkdir "%~dp0data\trumpow"
if not exist "%~dp0data\pool" mkdir "%~dp0data\pool"

:: Start the pool
echo.
echo Starting HappyChina Pool...
echo This may take a few minutes on first run (downloading images)...
echo.
cd /d "%~dp0"
docker compose up -d

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to start. Make sure Docker Desktop is running.
    pause
    exit /b 1
)

echo.
echo ============================================
echo   HappyChina Pool is running!
echo ============================================
echo.
echo   Web Dashboard: http://localhost:8080
echo   SHA-256 Stratum: stratum+tcp://localhost:3342
echo   Scrypt Stratum:  stratum+tcp://localhost:3333
echo.
echo   First Steps:
echo   1. Open http://localhost:8080 in your browser
echo   2. Register an account (first user becomes admin)
echo   3. Set your wallet addresses in profile settings
echo   4. Connect your miners!
echo.
echo   Blockchain sync will take time (~1.75TB total).
echo.

:: Open browser
start http://localhost:8080

echo Press any key to view logs (Ctrl+C to exit)...
pause >nul
docker compose logs -f backend
