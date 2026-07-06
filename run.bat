@echo off
cd /d "%~dp0"
echo ===================================================
echo [AWS Worklog] dang khoi dong Hugo Local Server...
echo link truy cap: http://localhost:1313/
echo ===================================================
"C:\Users\Thien cube\AppData\Local\Microsoft\WinGet\Links\hugo.exe" server --bind 0.0.0.0 --port 1313 --baseURL http://localhost:1313/
pause
