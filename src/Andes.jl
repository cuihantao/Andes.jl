__precompile__()

module Andes

using Conda
using PyCall

import SparseArrays

const py = PyNULL()

include("kvxopt.jl")

function __init__()
    copy!(py, pyimport_conda("andes", "andes", "conda-forge"))

    pytype_mapping(pyimport("kvxopt").spmatrix, SparseArrays.SparseMatrixCSC)
end


# --- export ---
export convert;

end # module

