using Test
using Andes
using PythonCall
using SparseArrays

@testset "Test Andes functionalities" begin
    @testset "SparseMatrixCSC conversion from Andes system example" begin
        ss = Andes.py.system.example()
        converted_matrix = pyconvert(SparseMatrixCSC, ss.dae.gy)
        @test converted_matrix isa SparseMatrixCSC
        @test size(converted_matrix) == (34, 34)
    end

    @testset "Power flow run" begin
        Andes.py.config_logger(40)
        kundur = Andes.py.utils.paths.get_case("kundur/kundur_full.xlsx")
        system = Andes.py.run(kundur, no_output=true)

        @test Bool(system.PFlow.converged == true)
    end
end
