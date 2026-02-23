@echo off
title HappyChina Mining Pool - Stop
color 0C

echo ============================================
echo   Stopping HappyChina Mining Pool...
echo ============================================
echo.

cd /d "%~dp0"
docker compose down

echo.
echo Pool stopped.
echo.
pause
