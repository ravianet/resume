@echo off
setlocal

cd /d "%~dp0"

echo.
echo ==============================
echo   GitHub Push Helper Script
echo ==============================
echo.

for /f "delims=" %%i in ('git branch --show-current 2^>nul') do set BRANCH=%%i
if not defined BRANCH set BRANCH=main

set /p COMMIT_MSG=Enter commit message: 
if "%COMMIT_MSG%"=="" set COMMIT_MSG=Update website

echo.
echo Adding files...
git add .
if errorlevel 1 goto :error

echo.
echo Committing changes...
git commit -m "%COMMIT_MSG%"

echo.
echo Pushing to origin/%BRANCH% ...
git push origin %BRANCH%
if errorlevel 1 goto :error

echo.
echo Push completed successfully.
pause
exit /b 0

:error
echo.
echo Something went wrong. Please check the Git output above.
pause
exit /b 1
