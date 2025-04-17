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
The examples are supported on most Linux distributions, Windows and OSx (not tested).

### Python & [grpc](https://grpc.io/)
The following steps compile the pulser grpc examples and demonstrate control using a jupyer notebook.\
Note that python 3.10 or above is required.

#### Linux
1. Run the script `compile_pulser_examples.sh` from `scripts/build/grpc` to create a virtual environment under `build/pulser/grpc/python`
2. Source the `set_env.sh` script from `scripts/setup/` and run `pulser-run-grpc-example-pynb`

#### Windows
`PLACEHOLDER`

### Python & [SCPI](https://www.ivifoundation.org/About-IVI/scpi.html) over TCP/IP using raw sockets
`PLACEHOLDER`
