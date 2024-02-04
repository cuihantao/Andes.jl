using CondaPkg
using SparseArrays: AbstractSparseMatrixCSC, SparseMatrixCSC
using PythonCall: pyconvert_add_rule

"""
Convert KVXOPT.spmatrix to SparseMatrixCSC
"""
function spmatrix_to_julia(S::Type{T}, x::Py) where {T<:AbstractSparseMatrixCSC}
    # Ensure x is a KVXOPT spmatrix
    if Bool(pytype(x) != pyimport("kvxopt").spmatrix)
        throw(ArgumentError("x must be a KVXOPT spmatrix"))
    end

    # Extract the size, I, J, and V arrays from the spmatrix and explicitly convert them
    m, n = pyconvert(Tuple{Int64,Int64}, x.size)
    I = pyconvert(Vector{Int64}, x.CCS[0]) .+ 1
    J = pyconvert(Vector{Int64}, x.CCS[1]) .+ 1
    V = pyconvert(Vector{Float64}, x.CCS[2])

    # Create and return the SparseMatrixCSC
    return PythonCall.pyconvert_return(SparseMatrixCSC(m, n, I, J, V))
end
