using Conda
using PyCall
using Pkg

Conda.add("andes", channel="conda-forge")
Pkg.build("PyCall")

