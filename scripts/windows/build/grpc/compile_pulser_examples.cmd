@echo off
REM This script will compile the pulser examples for Windows.
REM Operating systems supported:
REM Windows

echo Compiling examples...
set "script_dir=%~dp0"
if "%script_dir:~-1%"=="\" set "script_dir=%script_dir:~0,-1%"
for %%i in ("%script_dir%\..\..\..\..") do set "repo_root=%%~fi"
set "proto_dir=%repo_root%\src\pulser\grpc\proto"
set "dst_dir=%repo_root%\build"

REM Compile for python.
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Please install Python
    exit /b 1
)
python -c "import sys; exit(0 if sys.version_info >= (3,10) else 1)"
if %errorlevel% neq 0 (
    for /f "tokens=2 delims= " %%v in ('python --version') do set PY_VER=%%v
    echo Python version installed is %PY_VER%. Version 3.10 or newer is required!
    exit /b 1
)
set "python_dst_dir=%dst_dir%\pulser\grpc\python"
if not exist "%python_dst_dir%" (
    mkdir "%python_dst_dir%"
)
cd /d "%python_dst_dir%"
python -m venv .venv
call .venv\Scripts\activate.bat
python -m pip install --upgrade pip
python -m pip install grpcio
python -m pip install grpcio-tools
python -m pip install notebook
python -m pip install ipykernel
mkdir "%python_dst_dir%\generated"
for %%f in ("%proto_dir%\*.proto") do (
    python -m grpc_tools.protoc -Igenerated="%proto_dir%" -I"%proto_dir%" --python_out="%python_dst_dir%" --pyi_out="%python_dst_dir%" --grpc_python_out="%python_dst_dir%" "%%f"
)
copy /Y "%repo_root%\src\pulser\grpc\python\pulser_grpc.ipynb" pulser_grpc.ipynb
echo Completed compiling examples
echo ** To see the python examples run: %repo_root%\scripts\windows\run\pulser-run-grpc-example-pynb.cmd **
echo ** Edit the notebook in %repo_root%\build\pulser\grpc\python for real-time updates **