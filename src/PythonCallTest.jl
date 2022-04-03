# It appears that PythonCall and PyCall cannot co-exist in a module.
# see https://github.com/cjdoris/PythonCall.jl/issues/140

using SparseArrays

import PythonCall: Py, PyList
import PythonCall: pyimport, pyconvert, pyconvert_return, pyconvert_add_rule

"""
Convert KVXOPT.spmatrix to SparseMatrixCSC using PythonCall.
"""
function convert_spmatrix(S, x::Py)
    if pyconvert(String, x.typecode) == "d"
        S = SparseMatrixCSC(pyconvert(Int64, x.size[0]), pyconvert(Int64, x.size[1]),
                            pyconvert(Vector{Int64}, PyList(x.CCS[0])) .+ 1,
                            pyconvert(Vector{Int64}, PyList(x.CCS[1])) .+ 1,
                            pyconvert(Vector{Float64}, PyList(x.CCS[2])))::SparseMatrixCSC{Float64,Int64}

    elseif pyconvert(String, x.typecode) == "z"
        S = SparseMatrixCSC(pyconvert(Int64, x.size[0]), pyconvert(Int64, x.size[1]),
                            pyconvert(Vector{Int64}, PyList(x.CCS[0])) .+ 1,
                            pyconvert(Vector{Int64}, PyList(x.CCS[1])) .+ 1,
                            pyconvert(Vector{ComplexF64}, PyList(x.CCS[2])))::SparseMatrixCSC{ComplexF64,ComplexF64}
    end
    return pyconvert_return(S)
end

pc = pyimport("andes")
ss = pc.run(pc.get_case("kundur/kundur_full.xlsx"), no_output=true)

convert_spmatrix(Any, ss.dae.gy)

pyconvert_add_rule("kvxopt.base:spmatrix", SparseMatrixCSC, convert_spmatrix)

@time pyconvert(SparseMatrixCSC, ss.dae.gy)