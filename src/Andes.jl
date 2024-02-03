__precompile__()

module Andes

using PythonCall

const py = PythonCall.pynew()

include("kvxopt_pythoncall.jl")

function __init__()
    PythonCall.pycopy!(py, pyimport("andes"))

    PythonCall.pyconvert_add_rule("kvxopt.base:spmatrix",
        AbstractSparseMatrixCSC,
        spmatrix_to_julia,
    )
end

end