using GenLinAlgProblems
using Test

@testset "GenLinAlgProblems.jl" begin
    matrices = [[ [1 2; 2 1], :none]]
    res = GenLinAlgProblems.apply_function( x->x, matrices )
    @test res == matrices

    @test GenLinAlgProblems.to_latex_str( -1//2 ) == "-\\frac{1}{2}"
    @test GenLinAlgProblems.to_latex_str(2+1//2im) == "2 - \\frac{1}{2}\\mathit{i}"
    @test GenLinAlgProblems.factor_out_denominator( [1//2 1//3; 2//1 1//(-3) ]) == (6, [3 2; 12 -2])
    rounded = GenLinAlgProblems.round_value( 2.3, 0),
              GenLinAlgProblems.round_value(1//3, 3), 
              GenLinAlgProblems.round_value( Complex(1//3, -1//5),0),
              GenLinAlgProblems.round_value( Complex(1//3, -1//5), 1),
              GenLinAlgProblems.round_value( Complex(0, -1//5), 1)
    @test rounded == (2, 0.333, 0 + 0im, 0.3 - 0.2im, 0.0 - 0.2im)
end
