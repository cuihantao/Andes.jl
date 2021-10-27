__precompile__()

module Andes

using Conda
using PyCall

import SparseArrays

const py = PyNULL()

function __init__()
    copy!(py, pyimport_conda("andes", "andes", "conda-forge"))
end

include("kvxopt.jl")

# --- export ---
export convert;

end # module
