@echo off
where gradle >nul 2>nul
if %ERRORLEVEL% EQU 0 (
  gradle %*
  exit /b %ERRORLEVEL%
)
set VERSION=9.6
set CACHE=%USERPROFILE%\.gradle\wrapper\distsappel-fanafody-gradle-%VERSION%
set DIST=%CACHE%\gradle-%VERSION%
if not exist "%DIST%in\gradle.bat" (
  mkdir "%CACHE%" 2>nul
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-%VERSION%-bin.zip' -OutFile '%CACHE%\gradle.zip'"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Force '%CACHE%\gradle.zip' '%CACHE%'"
)
call "%DIST%in\gradle.bat" %*
