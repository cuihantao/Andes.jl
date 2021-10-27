import Base:convert
import SparseArrays: AbstractSparseMatrixCSC, SparseMatrixCSC

using PyCall

pytype_mapping(pyimport("kvxopt").spmatrix, SparseArrays.SparseMatrixCSC)


"""
Convert Julia array to KVXOPT matrix or spmatrix
"""
function julia_to_kvxopt(A)
    if issparse(A)
        J = zeros(Int64, length(A.rowval));
        for i = 1:size(A, 2)
            J[A.colptr[i]:A.colptr[i + 1] - 1] .= i - 1;
        end
        I = A.rowval .- 1
        V = A.nzval
        Ap = @pycall  kvxopt.spmatrix(PyCall.array2py(vec(V)), PyCall.array2py(vec(I)), PyCall.array2py(vec(J)), (size(A, 1), size(A, 2)))::PyObject;
    elseif isempty(A)
    Ap = pybuiltin("None");
  else
    sA = size(A)
    if length(sA) == 1
      sA = (sA[1], 1)
    end
    Ap = @pycall kvxopt.matrix(PyCall.array2py(vec(A)), sA)::PyObject;
    end
    return Ap;
end

"""
Convert KVXOPT spmatrix to SparseMatrixCSC
"""
function convert(::Type{T}, A::PyObject) where T <: AbstractSparseMatrixCSC
    if A.typecode == "d"
        r = SparseMatrixCSC(A.size[1], A.size[2],
                            vec(A.CCS[1])::Vector{Int64} .+ 1,
                            vec(A.CCS[2])::Vector{Int64} .+ 1,
                            vec(A.CCS[3])::Vector{Float64})::SparseMatrixCSC{Float64,Int64}
    elseif A.typecode == "z"
        r = SparseMatrixCSC(A.size[1], A.size[2],
                            vec(A.CCS[1])::Vector{Int64} .+ 1,
                            vec(A.CCS[2])::Vector{Int64} .+ 1,
                            vec(A.CCS[3])::Vector{ComplexF64})::SparseMatrixCSC{ComplexF64,Int64}
    end
    return r
end
