#!/bin/bash
#This script will resolve the C++ externals drogon and trantor.
#Operating systems supported:
# * Ubuntu/Debian/Mint
# * Windows
# * OSx (not tested)
set -e

while getopts h flag
do
    case "${flag}" in
        h) echo "Usage: ${0##*/}" && exit;;
    esac
done

echo Compiling examples...
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
repo_root=$(realpath $script_dir/../../..)
proto_dir=$repo_root/src/pulser/grpc/proto
dst_dir=$repo_root/build

# Get the system name.
uname_out="$(uname -s)"
case "${uname_out}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Windows;;
    MINGW*)     machine=Windows;;
    *)          machine="UNKNOWN:${uname_out}"
esac

# Compile for python.
if ! command -v python3 >/dev/null 2>&1; then  # needed for running grpc from cli.
    echo Please install Python
    exit 1
elif python3 -c "import sys; exit(sys.version_info >= (3, 10))"; then
    echo "Python version installed is $(python3 -V | awk -F' ' '{print $2}'). Version 3.10 or newer is required!"
    exit 1
fi
python_dst_dir=$dst_dir/pulser/grpc/python
mkdir -p $python_dst_dir
cd $python_dst_dir
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install grpcio
python3 -m pip install grpcio-tools
python3 -m pip install notebook
python3 -m pip install ipykernel
mkdir -p $python_dst_dir/generated
for proto_file in "$proto_dir"/*.proto; do
  python3 -m grpc_tools.protoc -Igenerated=$proto_dir -I"$proto_dir" --python_out="$python_dst_dir" --pyi_out="$python_dst_dir" --grpc_python_out="$python_dst_dir" "$proto_file"
done
ln -f "$repo_root"/src/pulser/grpc/python/pulser_grpc.ipynb pulser_grpc.ipynb

echo Completed compiling examples
echo "** To see the python examples run: source $repo_root/scripts/setup/set_env.sh ; pulser-run-grpc-example-pynb **"
