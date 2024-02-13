#using PyCall
#itikz = pyimport("itikz")
#nM    = pyimport("itikz.nicematrix")
# ==============================================================================================================
mutable struct ShowGe{T<:Number}
    A
    B
    num_rhs
    tmp_dir

    matrices
    cascade
    pivot_cols
    desc
    pivot_list
    bg_for_entries
    ref_path_list
    basic_var
    rank
    h
    m

    function ShowGe{T}(A::Matrix{T}, B::Matrix{T}, tmp_dir="tmp") where T <: Number
        new(A,B,size(B,2), tmp_dir)
    end
  function ShowGe{Rational{T}}(A::Matrix{T}, B::Matrix{T}, tmp_dir="tmp") where T <: Number
        new(Rational{T}.(A),Rational{T}.(B),size(B,2), tmp_dir)
  end
end
# --------------------------------------------------------------------------------------------------------------
function ref!( pb::ShowGe{T}; gj::Bool=false )  where T <: Number
        pb.matrices, pb.pivot_cols, pb.desc = reduce_to_ref( [pb.A pb.B], n=size(pb.A,2), gj=gj );
        pb.pivot_list, pb.bg_for_entries, pb.ref_path_list, pb.basic_var = decorate_ge(pb.desc,pb.pivot_cols,size(pb.A); pivot_color="yellow!40");
        pb.rank = length( pb.pivot_cols )
        nothing
end
# --------------------------------------------------------------------------------------------------------------
function show_layout!(  pb::ShowGe{T} )   where T <: Number
        pb.h,pb.m=nM.ge( to_latex(pb.matrices), formater=x->x, Nrhs=pb.num_rhs,
                       fig_scale=0.9,
                       pivot_list       = pb.pivot_list, pivot_text_color="red", variable_colors=["red", "black"],
                       bg_for_entries   = pb.bg_for_entries,
                       ref_path_list    = pb.ref_path_list,
                       variable_summary = pb.basic_var,
                       tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/show_layout")
        pb.h
end
# --------------------------------------------------------------------------------------------------------------
function show_system(  pb::ShowGe{T}; b_col=1 )   where T <: Number
    cascade = nM.BacksubstitutionCascade( pb.A, pb.B[:,b_col] )
    cascade.show( pb.A, pb.B[:,b_col], show_system=true, show_cascade=false, tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/show_system")
end
function show_system(  pb::ShowGe{Rational{T}}; b_col=1 )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    A = cnv.(pb.A)
    b = cnv.(pb.B[:,b_col])
    cascade = nM.BacksubstitutionCascade( A, b )
    cascade.show( A, b, show_system=true, show_cascade=false, tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/show_system")
end
function show_system(  pb::ShowGe{Complex{Rational{T}}}; b_col=1 )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    A = cnv.(pb.A)
    b = cnv.(pb.B[:,b_col])
    cascade = nM.BacksubstitutionCascade( A, b )
    cascade.show( A, b, show_system=true, show_cascade=false, tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/show_system")
end
# --------------------------------------------------------------------------------------------------------------
function create_cascade!(  pb::ShowGe{Complex{Rational{T}}}; b_col=1 )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    Ab     = cnv.(pb.matrices[end][end])
    A      = Ab[:, 1:size(pb.A,2)]
    b      = Ab[:, size(pb.A,2)+b_col]
    pb.cascade = nM.BacksubstitutionCascade(A,b)
end
# --------------------------------------------------------------------------------------------------------------
function create_cascade!(  pb::ShowGe{Rational{T}}; b_col=1 )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    Ab     = cnv.(pb.matrices[end][end])
    A      = Ab[:, 1:size(pb.A,2)]
    b      = Ab[:, size(pb.A,2)+b_col]
    pb.cascade = nM.BacksubstitutionCascade(A,b)
end
# --------------------------------------------------------------------------------------------------------------
function create_cascade!(  pb::ShowGe{T}; b_col=1 )   where T <: Integer
    Ab = pb.matrices[end][end]
    A      = Ab[:, 1:size(pb.A,2)]
    b      = Ab[:, size(pb.A,2)+b_col]

    pb.cascade = nM.BacksubstitutionCascade(A,b)
end
# --------------------------------------------------------------------------------------------------------------
function show_backsubstitution!(  pb::ShowGe{Complex{Rational{T}}}; b_col=1 )   where T <: Number
    create_cascade!( pb; b_col=b_col )
    pb.cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/backsubstitution")
end
# --------------------------------------------------------------------------------------------------------------
function show_backsubstitution!(  pb::ShowGe{Rational{T}}; b_col=1 )   where T <: Number
    create_cascade!( pb; b_col=b_col )
    pb.cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/backsubstitution")
end
function show_backsubstitution!(  pb::ShowGe{T}; b_col=1 )   where T <: Integer
    create_cascade!( pb; b_col=b_col )
    pb.cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=pb.tmp_dir, keep_file=pb.tmp_dir*"/backsubstitution")
end
# ==============================================================================================================
function homogeneous_solutions(pb::ShowGe{Complex{Rational{T}}} )   where T <: Number
    M,N = size(pb.A)
    if pb.rank == N return zeros( eltype(pb.A), N) end

    matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][1:pb.rank,1:N], n=N, gj=true )
    free_cols = filter(x -> !(x in pivot_cols), 1:N)
    
    Xh = zeros(Complex{Rational{T}}, N, N-pb.rank)
    F  = matrices[end][end][1:pb.rank,free_cols]

    for (col,row) in enumerate(free_cols)  Xh[row,col] = 1  end
    Xh[1:pb.rank,:] = -F
    Xh
end
function homogeneous_solutions(pb::ShowGe{Rational{T}} )   where T <: Number
    M,N = size(pb.A)
    if pb.rank == N return zeros( eltype(pb.A), M) end

    matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][1:pb.rank,1:N], n=N, gj=true )
    free_cols = filter(x -> !(x in pivot_cols), 1:N)
    
    Xh = zeros(Rational{T}, N, N-pb.rank)
    F  = matrices[end][end][1:pb.rank,free_cols]

    for (col,row) in enumerate(free_cols)  Xh[row,col] = 1  end
    Xh[1:pb.rank,:] = -F
    Xh
end
function homogeneous_solutions(pb::ShowGe{T} )   where T <: Number
    M,N = size(pb.A)
    if pb.rank == N return zeros( eltype(pb.A), M) end

    matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][1:pb.rank,1:N], n=N, gj=true )
    free_cols = filter(x -> !(x in pivot_cols), 1:N)
    
    Xh = zeros(T, N, N-pb.rank)
    F  = matrices[end][end][1:pb.rank,free_cols]

    for (col,row) in enumerate(free_cols)  Xh[row,col] = 1  end
    Xh[1:pb.rank,:] = -F
    Xh
end
# ==============================================================================================================
#function homogeneous_solution(pb::ShowGe{Complex{Rational{T}}}; b_col=1 )   where T <: Number)
#  N = size(pb.A,2)
#  matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][:,1:N], n=N, gj=true );
#  Xh = similar(pb.A, size(pb.A,1), A - pb.rank)
#end
# ==============================================================================================================
# Using the computer to produce a nice layout of the computations
function ge( matrices, desc, pivot_cols; Nrhs=0, formater=to_latex, pivot_list=nothing, bg_for_entries=nothing,
             variable_colors=["blue","black"], pivot_colors=["blue","yellow!40"],
             ref_path_list=nothing, comment_list=[], variable_summary=nothing, array_names=nothing,
             start_index=1, func=nothing, fig_scale=nothing, tmp_dir=nothing, keep_file=nothing )
    M = size(matrices[1][end],1)
    N = size(matrices[1][end],2)-sum(Nrhs)

    pivot_list, bg_for_entries, ref_path_list, variable_summary = decorate_ge(desc, pivot_cols, (M,N); pivot_color=pivot_colors[2]);

    s=nM._to_svg_str( formater(matrices), formater=x->x, Nrhs=Nrhs,
               pivot_list       = pivot_list,
               bg_for_entries   = bg_for_entries,
               variable_colors  = variable_colors,pivot_text_color=pivot_colors[1],
               ref_path_list    = ref_path_list, comment_list=comment_list,
               variable_summary = variable_summary,
               array_names      = array_names,
               start_index      = start_index,
               func             = func,
               fig_scale        = fig_scale,
               tmp_dir          = tmp_dir, keep_file=keep_file    )
    display(MIME("image/svg+xml"), s);
end
# ------------------------------------------------------------------------------------------
function show_solution( matrices; tmp_dir=nothing )
    cascade = nM.BacksubstitutionCascade.from_ref_Ab( Int.(matrices[end][end] ))
    cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=tmp_dir)
end
