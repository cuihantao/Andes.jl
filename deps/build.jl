using PyCall
using Conda
import Pkg

try
    pyimport("andes")
catch
    @warn "PyCall is not configured to an existing Python env."
    @warn "andes.jl will use Conda for PyCall and install andes."
    ENV["PYTHON"] = Conda.PYTHONDIR
    Pkg.build("PyCall")

    Conda.add("andes", channel="conda-forge")
end

