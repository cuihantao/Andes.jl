__precompile__()

module andes
using PyCall

const py = PyNULL()

function __init__()
    copy!(py, pyimport_conda("andes", "andes", "conda-forge"))
end

end # module
