# GREENLAND
The repository is structured as follows:
```
├── src
│   ├── pulser
│   │   ├── grpc
│   │   ├── http
│   │   ├── ...
├── ext
├── docs
│   ├── ...
├── scripts
```
* `src` - code examples organized by instruments and programming scheme
* `ext` - external libraries & tools
* `docs` - documentation
* `scripts` - setup and build scripts

## Pulser Getting Started
The examples are supported on most Linux distributions, Windows (using [`cygwin`](https://www.cygwin.com/), [`mingw`](https://www.mingw-w64.org/) or [`WSL`](https://learn.microsoft.com/en-us/windows/wsl/install)) and OSx (not tested).

### Python & [grpc](https://grpc.io/)
The following steps compile the pulser grpc examples and demonstrate control using a jupyer notebook.\
Note that python 3.10 or above is required.
1. Run the script `compile_pulser_examples.sh` from `scripts/build/` to create a virtual environment under `build/pulser/grpc/python`
2. Source the `set_env.sh` script from `scripts/setup/` and run `pulser-run-grpc-example-pynb`

### Python & [SCPI](https://www.ivifoundation.org/About-IVI/scpi.html) over TCP/IP using raw sockets
`PLACEHOLDER`
