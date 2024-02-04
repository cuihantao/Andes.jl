using PythonCall
using CondaPkg

try
    pyimport("andes")
    pyimport("kvxopt")
catch
    @warn "PyCall is not configured to an existing Python env."
    @warn "Andes.jl will use Conda for PyCall and install andes."
    ENV["PYTHON"] = Conda.PYTHONDIR
    Pkg.build("PyCall")

    Conda.add("andes", channel="conda-forge")
end

