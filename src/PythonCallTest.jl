# It appears that PythonCall and PyCall cannot co-exist in a module.
# see https://github.com/cjdoris/PythonCall.jl/issues/140

using PythonCall
using SparseArrays

import PythonCall: Py, PyList, pyconvert, pyconvert_return

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
    return PythonCall.pyconvert_return(S)
end

pc = PythonCall.pyimport("andes")
ss = pc.run(pc.get_case("kundur/kundur_full.xlsx"))

aa = 1

convert_spmatrix(1, ss.dae.gy)

PythonCall.pyconvert_add_rule("kvxopt:spmatrix", SparseMatrixCSC, convert_spmatrix)

pyconvert(SparseMatrixCSC, ss.dae.gy)