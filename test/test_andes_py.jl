using Andes

@testset "Andes.jl run power flow" begin
    kundur = Andes.py.utils.paths.get_case("kundur/kundur_full.xlsx")
    system = Andes.py.run(kundur, no_output=true)

    @test system.PFlow.converged == true

    # test sparse matrix conversion
    @test size(system.PFlow.A) == (25, 25)

end
