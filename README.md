
# Andes.jl

The Julia API for [ANDES](https://github.com/cuihantao/andes).

[![Build Status](https://img.shields.io/travis/com/cuihantao/Andes.jl/master.svg)](https://travis-ci.com/cuihantao/Andes.jl)

## Introduction

`Andes.jl` is the Julia API for ANDES, a power system simulation tool for symbolic modeling and numerical simulation.

`Andes.jl` provides APIs through `PyCall` and `Conda` for calling ANDES from Julia.

## Installation

Install `Andes.jl` with

```julia
using Pkg
Pkg.add("Andes")
```

### Customize Python Environment

If you have installed andes in an existing Python environment and do not want to reinstall it from conda, you can configure it in Pycall.

You can manually set the Python path with the following commands in Julia:

```
ENV["PYTHON"] = "... path of the python executable ..."
# ENV["PYTHON"] = "C:\\Python37-x64\\python.exe"        # example for Windows
# ENV["PYTHON"] = "/usr/bin/python3.7"                  # example for *nix
# ENV["PYTHON"] = "/home/name/miniconda3/envs/andes"    # example for conda
Pkg.build("PyCall")
```

Check out the [documentation](https://github.com/JuliaPy/PyCall.jl#specifying-the-python-version) of `PyCall.jl` for more details.

## Usage

`Andes.jl` exposes all Python APIs under `andes.py`. Use the package with

```julia
using Andes
[ Info: Precompiling andes [93a26e3f-343a-4ab9-b467-a68c67574964]
```
All subsequent usages can be made to `andes.py` in the same way as in Python.

For example, to run power flow for `kundur_full.xlsx` (assume exists in the current directory), run

```julia
julia> system = Andes.py.run("kundur_full.xlsx")
Parsing input file <kundur_full.xlsx>
Input file kundur_full.xlsx parsed in 0.0768 second.
-> Power flow calculation with Newton Raphson method:
Power flow initialized.
0: |F(x)| = 14.9283
1: |F(x)| = 3.60859
2: |F(x)| = 0.170093
3: |F(x)| = 0.00203827
4: |F(x)| = 3.76414e-07
Converged in 5 iterations in 0.0063 second.
Report saved to <kundur_full_out.txt> in 0.0007 second.
-> Single process finished in 0.1666 second.
PyObject <andes.system.System object at 0x1522910b8>
```

Visit [ANDES Documentation](https://andes.readthedocs.io) for tutorial and API details

## Development

Contributions to Andes.jl are welcome. Please see [CONTRIBUTING.md](https://github.com/cuihantao/Andes.jl/blob/master/CONTRIBUTING.md) for code contribution guidelines.

## License

`Andes.jl` (the ANDES Julia interface only) is released under [MIT license](https://github.com/cuihantao/Andes.jl/blob/master/LICENSE). 

Andes.jl has been developed as part of the Large Scale Testbed (LTB)
project at the Center for Ultra-Wide-Area Resilient Electric Energy Transmission Networks ([CURENT](https://curent.utk.edu/)), a National Science Foundation Engineering Research Center that is jointly supported by NSF (National Science Foundation) and the DoE (Department of Energy) of the United States. 
