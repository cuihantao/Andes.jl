__precompile__()

module andes

# use system python
using PyCall

# export APIs to `andes.py``
const py = PyNULL()

function __init__()
    copy!(py, pyimport("andes"))
end

end # module
