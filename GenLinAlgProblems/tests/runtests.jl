using GenLinAlgProblems, LaTeXStrings, BlockArrays
using Test

@testset "GenLinAlgProblems.jl" begin
    matrices = [[ [1 2; 2 1], :none]]
    res = GenLinAlgProblems.apply_function( x->x, matrices )
    @test res == matrices

    @test GenLinAlgProblems.to_latex( -1//2 ) == "-\\frac{1}{2}"
    @test GenLinAlgProblems.to_latex(2+1//2im) == "2 - \\frac{1}{2}\\mathit{i}"
    @test GenLinAlgProblems.factor_out_denominator( [1//2 1//3; 2//1 1//(-3) ]) == (6, [3 2; 12 -2])
    rounded = GenLinAlgProblems.round_value( 2.3, 0),
              GenLinAlgProblems.round_value(1//3, 3), 
              GenLinAlgProblems.round_value( Complex(1//3, -1//5),0),
              GenLinAlgProblems.round_value( Complex(1//3, -1//5), 1),
              GenLinAlgProblems.round_value( Complex(0, -1//5), 1)
    @test rounded == (2, 0.333, 0 + 0im, 0.3 - 0.2im, 0.0 - 0.2im)
end

# Test Suite for form_linear_combination
@testset "Linear Combination" begin
    s = [1, 2, 3]
    Xh = [1 2 3; 4 5 6]
    result = form_linear_combination(s, Xh)
    @test length(result) == 8  # 3 coefficients + 3 vectors + 2 "+" signs
end

# Test Suite for L_interp
@testset "LaTeX Interpolation" begin
    template = L"\mathbb{R}^{$(n)}"
    substitutions = Dict("n" => 6)
    result = L_interp(template, substitutions)
    @test string(result) == "\\mathbb{R}^{6}"
end

# Test Suite for apply_function
@testset "Apply Function" begin
    f(x) = x^2
    matrices = [[1, 2], [3, 4]]
    result = apply_function(f, matrices)
    @test result == [[1, 4], [9, 16]]
end

# Test Suite for factor_out_denominator
#@testset "Factor Out Denominator" begin
#    # Vector of Rationals
#    v = [1//2, 1//3, 1//4]
#    d, v_factored = factor_out_denominator(v)
#    @test d == 12
#    @test v_factored == [6, 4, 3]
#
#    # Matrix of Rationals
#    m = [1//2 1//3; 1//4 1//5]
#    d, m_factored = factor_out_denominator(m)
#    @test d == 60
#    @test m_factored == [30 20; 15 12]
#
#    # Vector of Complex Rationals
#    cv = [1//2 + 1//3im, 1//4 - 1//5im]
#    d, cv_factored = factor_out_denominator(cv)
#    @test d == 60
#    @test cv_factored == [30 + 20im, 15 - 12im]
#
#    # Matrix of Complex Rationals
#    cm = [1//2 + 1//3im 1//4 - 1//5im; 1//6 + 1//7im 1//8 - 1//9im]
#    d, cm_factored = factor_out_denominator(cm)
#    @test d == 2520
#    @test cm_factored == [1260 + 840im, 630 - 504im; 420 + 360im, 315 - 280im]
#
#    # Transpose
#    mt = transpose(m)
#    d, mt_factored = factor_out_denominator(mt)
#    @test d == 60
#    @test mt_factored == transpose(m_factored)
#
#    # Adjoint
#    ca = [1//2 + 1//3im, 1//4 - 1//5im]'
#    d, ca_factored = factor_out_denominator(ca)
#    @test d == 60
#    @test ca_factored == [30 + 20im, 15 - 12im]'
#
#    # BlockArray
#    ba = BlockArray(m, [1, 1], [1, 1])
#    d, ba_factored = factor_out_denominator(ba)
#    @test d == 60
#    @test ba_factored == BlockArray(m_factored, [1, 1], [1, 1])
#end

# Test Suite for print_np_array_def
@testset "Print NumPy Array" begin
    A = [1 2; 3 4]
    result = print_np_array_def(A;nm="B")
    @test result == "B = np.array([\n[1, 2],\n[3, 4]\n])"
end

# Test Suite for to_latex
@testset "To LaTeX" begin
    # Real number
    @test to_latex(5) == "5"

    # Rational
    @test to_latex(1//2) == "\\frac{1}{2}"

    # Complex number
    @test to_latex(1 + 2im) == "1 + 2\\mathit{i}"

    # Symbol
    @test to_latex(:x) == "x"

    # SymPy Symbol
    using SymPy
    @test to_latex(Sym("x")) == "x"
end

# Test Suite for round_value and round_matrices
@testset "Rounding" begin
    # Real number
    @test round_value(5.123, 2) == 5.12

    # Complex number
    @test round_value(5.123 + 6.456im, 2) == Complex(5.12, 6.46)

    # Matrix
    A = [5.123 6.456; 7.789 8.901]
    @test round_matrices([A], 2) == [[5.12 6.46; 7.79 8.90]]
end

# Test Suite for style_wrapper
@testset "Style Wrapper" begin
    @test L_show("text",color="red") == "\$\\textcolor{red}{\\text{text}}\$\n"
end

# Test Suite for parse_arraystyle
@testset "Parse Array Style" begin
    arraystyle = :bmatrix
    A=[1,2]
    result = L_show(A, arraystyle=arraystyle)
    @test result == "\$\\begin{bmatrix}\n1 \\\\\n2 \\\\\n\\end{bmatrix}\$\n"
end

# Test Suite for construct_col_format
@testset "Construct Column Format" begin
    A = BlockArray( [1 2 3; 1 2 3], [1,1], [1,2] )
    @test L_show(A) == "\$\\left(\\begin{array}{r|rr}\n1 & 2 & 3 \\\\ \\hline\n1 & 2 & 3 \\\\\n\\end{array}\\right)\$\n"
end
