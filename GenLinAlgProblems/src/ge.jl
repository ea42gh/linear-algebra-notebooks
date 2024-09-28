#using PyCall
#itikz = pyimport("itikz")
#nM    = pyimport("itikz.nicematrix")
# ==============================================================================================================
mutable struct ShowGe{T<:Number}
    tmp_dir
    keep_file
    A
    B
    num_rhs

    matrices
    cascade
    pivot_cols
    free_cols
    desc
    pivot_list
    bg_for_entries
    ref_path_list
    basic_var
    rank
    h
    m

  function ShowGe{T}(A::Matrix{T}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, A)
  end
  function ShowGe{T}(A::Matrix{T}, B::Vector{T}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, A,B,size(B,2))
  end
  function ShowGe{T}(A::Matrix{T}, B::Matrix{T}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, A,B,size(B,2))
  end

  function ShowGe{Rational{T}}(A::Matrix{T}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, Rational{T}.(A) )
  end
  function ShowGe{Rational{T}}(A::Matrix{T}, B::Vector{T}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, Rational{T}.(A),Rational{T}.(B),size(B,2))
  end
  function ShowGe{Rational{T}}(A::Matrix{T}, B::Matrix{T}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, Rational{T}.(A),Rational{T}.(B),size(B,2))
  end

  function ShowGe{Complex{Rational{T}}}(A::Matrix{Complex{T}}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
    new(tmp_dir, keep_file, Complex{Rational{T}}.(A) )
  end
  function ShowGe{Complex{Rational{T}}}(A::Matrix{Complex{T}}, B::Vector{Complex{T}}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
    new(tmp_dir, keep_file, Complex{Rational{T}}.(A),Complex{Rational{T}}.(B),size(B,2))
  end
  function ShowGe{Complex{Rational{T}}}(A::Matrix{Complex{T}}, B::Matrix{Complex{T}}; tmp_dir="tmp", keep_file="tmp/show_layout") where T <: Number
      new(tmp_dir, keep_file, Complex{Rational{T}}.(A),Complex{Rational{T}}.(B),size(B,2))
  end
end
# --------------------------------------------------------------------------------------------------------------
function ref!( pb::ShowGe{T}; gj::Bool=false, normal_eq::Bool=false )  where T <: Number
    M,N = size(pb.A)
    if isdefined( pb, :B)
       A = [pb.A pb.B]
    else
       A = pb.A
       pb.num_rhs = 0
    end
    if normal_eq
      pb.matrices, pb.pivot_cols, pb.desc = normal_eq_reduce_to_ref( A, n=N, gj=gj );
      sz = (N,N)
    else
      pb.matrices, pb.pivot_cols, pb.desc = reduce_to_ref( A, n=N, gj=gj );
      sz = (M,N)
    end
    pb.free_cols = filter(x -> !(x in pb.pivot_cols), 1:N)

    pb.pivot_list, pb.bg_for_entries, pb.ref_path_list, pb.basic_var = decorate_ge(pb.desc,pb.pivot_cols,sz; pivot_color="yellow!40");
    pb.rank = length( pb.pivot_cols )
    nothing
end
# --------------------------------------------------------------------------------------------------------------
function show_layout!(  pb::ShowGe{T}; array_names=:None )   where T <: Number
    if isdefined( pb, :B)
       num_rhs = pb.num_rhs
    else
       num_rhs = 0
    end
    pb.h,pb.m=nM.ge( to_latex(pb.matrices), formater=x->x, Nrhs=num_rhs,
                   fig_scale=0.9,
                   pivot_list       = pb.pivot_list, pivot_text_color="red", variable_colors=["red", "black"],
                   bg_for_entries   = pb.bg_for_entries,
                   ref_path_list    = pb.ref_path_list,
                   variable_summary = pb.basic_var,
                   array_names      = array_names,
                   tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
    pb.h
end
# --------------------------------------------------------------------------------------------------------------
function show_system(  pb::ShowGe{T}; b_col=1, var_name::String="x")   where T <: Number
    if isdefined( pb, :B)
       b = pb.N[:,b_col]
    else
       b = zeros( eltype(pb.A), size(pb.A,1), 1)
    end

    cascade = nM.BacksubstitutionCascade( pb.A, b, var_name=var_name )
    cascade.show( pb.A, b, show_system=true, show_cascade=false, tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
end
function show_system(  pb::ShowGe{Rational{T}}; b_col=1, var_name::String="x" )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    A = cnv.(pb.A)
    if isdefined( pb, :B)
       b = cnv.(pb.B[:,b_col])
    else
       b = cnv.(zeros( eltype(pb.A), size(A,1), 1))
    end

    cascade = nM.BacksubstitutionCascade( A, b, var_name=var_name )
    cascade.show( A, b, show_system=true, show_cascade=false, tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
end
function show_system(  pb::ShowGe{Complex{Rational{T}}}; b_col=1, var_name::String="x" )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    A = cnv.(pb.A)
    if isdefined( pb, :B)
       b = cnv.(pb.B[:,b_col])
    else
       b = cnv.(zeros( eltype(A), size(A,1), 1))
    end
    cascade = nM.BacksubstitutionCascade( A, b, var_name=var_name )
    cascade.show( A, b, show_system=true, show_cascade=false, tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
end
# --------------------------------------------------------------------------------------------------------------
function create_cascade!(  pb::ShowGe{Complex{Rational{T}}}; b_col=1, var_name::String="x" )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    Ab     = cnv.(pb.matrices[end][end])
    A      = Ab[:, 1:size(pb.A,2)]
    if isdefined( pb, :B)
       b = Ab[:, size(pb.A,2)+b_col]
    else
       b = zeros( eltype(A), size(A,1), 1)
    end
    pb.cascade = nM.BacksubstitutionCascade(A,b, var_name=var_name)
end
# --------------------------------------------------------------------------------------------------------------
function create_cascade!(  pb::ShowGe{Rational{T}}; b_col=1, var_name::String="x" )   where T <: Number
    cnv(x) = (numerator(x),denominator(x))
    Ab     = cnv.(pb.matrices[end][end])
    A      = Ab[:, 1:size(pb.A,2)]
    if isdefined( pb, :B)
       b = Ab[:, size(pb.A,2)+b_col]
    else
       b = cnv.(zeros( eltype(pb.A), size(A,1), 1))
    end
    pb.cascade = nM.BacksubstitutionCascade(A,b,var_name=var_name)
end
# --------------------------------------------------------------------------------------------------------------
function create_cascade!(  pb::ShowGe{T}; b_col=1, var_name::String="x" )   where T <: Integer
    Ab = pb.matrices[end][end]
    A      = Ab[:, 1:size(pb.A,2)]
    if isdefined( pb, :B)
       b = Ab[:, size(pb.A,2)+b_col]
    else
       b = zeros( eltype(A), size(A,1), 1)
    end

    pb.cascade = nM.BacksubstitutionCascade(A,b,var_name=var_name)
end
# --------------------------------------------------------------------------------------------------------------
function show_backsubstitution!(  pb::ShowGe{Complex{Rational{T}}}; b_col=1, var_name::String="x" )   where T <: Number
    create_cascade!( pb; b_col=b_col, var_name=var_name )
    pb.cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
end
# --------------------------------------------------------------------------------------------------------------
function show_backsubstitution!(  pb::ShowGe{Rational{T}}; b_col=1, var_name::String="x" )   where T <: Number
    create_cascade!( pb; b_col=b_col, var_name=var_name )
    pb.cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
end
function show_backsubstitution!(  pb::ShowGe{T}; b_col=1, var_name::String="x" )   where T <: Integer
    create_cascade!( pb; b_col=b_col, var_name=var_name )
    pb.cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=pb.tmp_dir, keep_file=pb.keep_file)
end
# ==============================================================================================================
function solutions(pb::ShowGe{Complex{Rational{T}}} )   where T <: Number
    M,N                        = size(pb.A)
    matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][1:pb.rank,1:end], n = N, gj = true )

    if pb.num_rhs > 0
        Xp                         = zeros(Complex{Rational{T}}, N, pb.num_rhs)
        F                          = matrices[end][end][1:pb.rank,N+1:end]
        Xp[pivot_cols,:]           = F
    else
        Xp                         = zeros(Complex{Rational{T}}, N, 1)
    end

    Xh = zeros(Complex{Rational{T}}, N, N-pb.rank)
    F  = matrices[end][end][1:pb.rank,pb.free_cols]

    for (col,row) in enumerate(pb.free_cols)  Xh[row,col] = 1  end
    Xh[pivot_cols,:] = -F
    Xp, Xh
end
function solutions(pb::ShowGe{Rational{T}} )   where T <: Number
    M,N                        = size(pb.A)
    matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][1:pb.rank,1:end], n = N, gj = true )

    if pb.num_rhs > 0
        Xp                         = zeros(Rational{T}, N, pb.num_rhs)
        F                          = matrices[end][end][1:pb.rank,N+1:end]
        Xp[pivot_cols,:]           = F
    else
        Xp                         = zeros(Rational{T}, N, 1)
    end

    Xh = zeros(Rational{T}, N, N-pb.rank)
    F  = matrices[end][end][1:pb.rank,pb.free_cols]

    for (col,row) in enumerate(pb.free_cols)  Xh[row,col] = 1  end
    Xh[pivot_cols,:] = -F
    Xp, Xh
end
function solutions(pb::ShowGe{T} )   where T <: Number
    M,N                        = size(pb.A)
    matrices, pivot_cols, desc = reduce_to_ref( pb.matrices[end][end][1:pb.rank,1:end], n = N, gj = true )

    if pb.num_rhs > 0
        Xp                         = zeros(T, N, pb.num_rhs)
        F                          = matrices[end][end][1:pb.rank,N+1:end]
        Xp[pivot_cols,:]           = F
    else
        Xp                         = zeros(T, N, 1)
    end

    Xh = zeros(T, N, N-pb.rank)
    F  = matrices[end][end][1:pb.rank,pb.free_cols]

    for (col,row) in enumerate(pb.free_cols)  Xh[row,col] = 1  end
    Xh[pivot_cols,:] = -F
    Xp, Xh
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
function show_solution( matrices; var_name::String="x", tmp_dir=nothing )
    cascade = nM.BacksubstitutionCascade.from_ref_Ab( Int.(matrices[end][end] ), var_name=var_name)
    cascade.show( show_system=true, show_cascade=true, show_solution=true, tmp_dir=tmp_dir)
end
