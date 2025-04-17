@echo off

REM Run notebook.
set "script_dir=%~dp0"
if "%script_dir:~-1%"=="\" set "script_dir=%script_dir:~0,-1%"
for %%i in ("%script_dir%\..\..\..") do set "repo_root=%%~fi"
cd %repo_root%\build\pulser\grpc\python
call .venv\Scripts\activate.bat
jupyter notebook --ip='*' --no-browser --port=9999
