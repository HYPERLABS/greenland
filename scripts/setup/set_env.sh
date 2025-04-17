#!/bin/bash
#This script will setup the environment for development.
#Use "source ./set_env_development.sh" to source.
#Include in ~/.bashrc for convenience.
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Environment variables.
repo_root=$(realpath $script_dir/../..)
export GREENLAND_ROOT=$repo_root
export GREENLAND_SCRIPTS=$repo_root/scripts

# Custom commands.
pulser-run-grpc-example-pynb() {
    uname_out="$(uname -s)"
    case "${uname_out}" in
        Linux*)     machine=Linux;;
        Darwin*)    machine=Mac;;
        CYGWIN*)    machine=Windows;;
        MINGW*)     machine=Windows;;
        *)          machine="UNKNOWN:${uname_out}"
    esac
    cd $repo_root/build/pulser/grpc/python
    if [[ $machine == "Windows" ]]; then
        .venv/Scripts/activate.bat
    else
        source .venv/bin/activate
    fi
    jupyter notebook --ip='*' --no-browser --port=9999
    deactivate
}

# Allow forward search (i-search)
stty -ixon

# Workaround to enable tab autocomplete with environment variables.
shopt -s direxpand
