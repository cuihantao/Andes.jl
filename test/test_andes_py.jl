using andes

@testset "andes.jl run power flow" begin
    kundur = andes.py.utils.paths.get_case("kundur/kundur_full.xlsx")
    system = andes.py.run(kundur, no_output=true)

    @test system.PFlow.converged == true
end
