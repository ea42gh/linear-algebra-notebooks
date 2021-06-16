### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 810894a0-3632-11eb-2b9f-5d64d1c81815
begin
	using Pkg
	Pkg.activate(".")
	#include("src/LAcode.jl")

	Pkg.add("LinearAlgebra"); using LinearAlgebra

	Pkg.add("Plots");         using Plots
	Pkg.add("PlutoUI");       using PlutoUI
	Pkg.add("PlotThemes");    using PlotThemes
	#Pkg.add("Latexify");     using Latexify
	Pkg.add("LaTeXStrings"); using LaTeXStrings

	plotly()
	theme(:dark)
	md"# Quadrics in 2D"
end

# ╔═╡ ccdd6c20-3632-11eb-2ef5-1fd494bd1c59
begin
md"``\qquad\qquad\qquad f(x,y) = a x^2 + b x y + c y^2``

a $( @bind a Slider(-1.0 : 0.1 : 1.0, default=1, show_value=true ))
b $( @bind b Slider(-4.0 : 0.5 : 4.0, default=0, show_value=true ))
c $( @bind c Slider(-1.0 : 0.1 : 1.0, default=1, show_value=true ))

ϕ $( @bind ϕ Slider(0: 5 : 360, default=30) )
"
end

# ╔═╡ d6b653ae-3632-11eb-2d1c-c1cb49d24062
begin
	e = eigen([ a    b/2;
                b/2   c  ])
	θ = round( atand( e.vectors[2,1], e.vectors[1,1] ),digits=1 )
	
	#l ="f(x,y)= $(a) x^2 + $(b) x y + $(c) y^2"
	#l ="F(x,y) =  a x^2  + b x y + c y^2"
	
	l ="Eigenvalues $(round.(e.values,digits=2)),   θ ≈ $(θ)"

	x = -10:10
	y = x
	f(x,y) = a .* x.^2 .+ b .* x .* y + c .* y.^2

	plot(x,y,f,linetype=:surface, opacity=0.9, camera=(ϕ,30), title=l)

	plot!( [0; 10*e.vectors[1,1]], [0; 10*e.vectors[2,1]], [0; 0],
		   label=:none, color=:blue, lw=10)
	h =
	plot!( [0; 10*e.vectors[1,2]], [0; 10*e.vectors[2,2]], [0; 0],
		   label=:none,  color=:lightblue,  lw=10)
	#@animate for θ ∈ 30:1:390
	#	plot!( camera = (θ,30) )
	#end
end

# ╔═╡ c415a670-3632-11eb-0db8-4b27e43a4821
with_terminal() do
	θ = round( atand( e.vectors[2,1], e.vectors[1,1] ),digits=1 )
	print(L"            f(x,y)= %$(a) x^2 + %$(b) x y + %$(c) y^2           λ = ",round.(e.values,digits=3), ",    θ( q1 ) = $(θ)" )
end

# ╔═╡ ac1c69d0-3657-11eb-212f-1555807c8bfb
function lookangle(θ)
	plot!(h, camera=(39,30))
end

# ╔═╡ f66f7d50-3699-11eb-0616-a55f4678dab9
import LAcode

# ╔═╡ 749f2840-3660-11eb-3a33-edc1337bcd9b
begin
	S = [2. 2; 0 1]; S=S'S
	D = diagm([2,-1])
	Q = LAcode.gram_schmidt(S)
	AA = Q*D*Q'
end

# ╔═╡ a37036e0-3661-11eb-0abb-79849cbf99d1
10(D[1,1]+D[2,2]), det(10AA), eigvals(10AA)

# ╔═╡ 2e4078a0-369b-11eb-3235-3177330f2740
begin
	SS = [1. 1 0; 0 2 1; -1 1 0]; SS=SS'SS
	DD = diagm([3,1, 2])
	QQ = LAcode.gram_schmidt(SS)
	AAA = QQ*DD*QQ'
end

# ╔═╡ Cell order:
# ╟─810894a0-3632-11eb-2b9f-5d64d1c81815
# ╟─d6b653ae-3632-11eb-2d1c-c1cb49d24062
# ╟─c415a670-3632-11eb-0db8-4b27e43a4821
# ╟─ccdd6c20-3632-11eb-2ef5-1fd494bd1c59
# ╟─ac1c69d0-3657-11eb-212f-1555807c8bfb
# ╠═f66f7d50-3699-11eb-0616-a55f4678dab9
# ╠═749f2840-3660-11eb-3a33-edc1337bcd9b
# ╠═a37036e0-3661-11eb-0abb-79849cbf99d1
# ╠═2e4078a0-369b-11eb-3235-3177330f2740
