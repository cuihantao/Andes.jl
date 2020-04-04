__precompile__()

module andes
using Pkg
using Conda
using PyCall

try
    pyimport("andes")
catch
    @warn "PyCall is not configured to an existing Python env."
    @warn "andes.jl will use Conda for PyCall and install andes."
    ENV["PYTHON"] = Conda.PYTHONDIR
    Pkg.build("PyCall")
    Conda.add("andes", channel="conda-forge")
end

const py = PyNULL()

function __init__()
    copy!(py, pyimport_conda("andes", "andes", "conda-forge"))
end

end # module
