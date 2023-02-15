#using LinearAlgebrai

# ------------------------------------------------------------------------------
# --------------------------------------------------------- GE and GJ algorithms
# ------------------------------------------------------------------------------
abstract type AbstractDescription end
Base.@kwdef struct FoundPivot <: AbstractDescription
    level      :: Int
    row        :: Int
    pivot_row  :: Int
    pivot_col  :: Int
    cur_rank   :: Int
    pivot_cols
end
Base.@kwdef struct RequireRowExchange <: AbstractDescription
    level    :: Int
    row_1    :: Int
    row_2    :: Int
    col      :: Int
    cur_rank :: Int
    pivot_cols
end
Base.@kwdef struct RequireElimination <: AbstractDescription
    level    :: Int
    gj       :: Bool
    yes      :: Bool
    row      :: Int
    col      :: Int
    cur_rank :: Int
    pivot_cols
end
Base.@kwdef struct RequireScaling <: AbstractDescription
    level    :: Int
    pivot_cols
end
# ------------------------------------------------------------------------------
Base.@kwdef struct DoElimination <: AbstractDescription
    level     :: Int
    pivot_row :: Int
    pivot_col :: Int
    gj        :: Bool
end
Base.@kwdef struct DoRowExchange <: AbstractDescription
    level    :: Int
    row_1    :: Int
    row_2    :: Int
    col      :: Int
    cur_rank :: Int
end
Base.@kwdef struct DoScaling <: AbstractDescription
    level    :: Int
end
Base.@kwdef struct Finished <: AbstractDescription
    level    :: Int
    pivot_cols
end
# ==============================================================================
"""
Compute the particular solution from a system in **Reduced Row Echelon Form**
"""
function particular_solution( R, RHS::Array, pivot_cols)
    RHS = Matrix( RHS )  # make sure RHS has two indices
    M,N = size(R,2), size(RHS,2)
    r   = length(pivot_cols)
    X   = zeros(eltype(R), (M,N))
    X[pivot_cols,:] = RHS[1:r,:]
    X
end
# ------------------------------------------------------------------------------
function split_R_RHS( R_RHS, num_rhs )
    N = size(R_RHS,2) - num_rhs
    R_RHS[:,1:N], R_RHS[:, N+1:end]
end
# ------------------------------------------------------------------------------
"""
Compute the particular solution from a system in **Augmented Reduced Row Echelon Form**
"""
function particular_solution( R_RHS, num_rhs::Int, pivot_cols)
    R,RHS = split_R_RHS(R_RHS, num_rhs )
    particular_solution( R, RHS, pivot_cols)
end
# ------------------------------------------------------------------------------
"""
Compute the homogeneous solution from a system in **Reduced Row Echelon Form**
"""
function homogeneous_solutions( R, pivot_cols)
    # homogeneous solution from a reduced row echelon form R
    r = length(pivot_cols)                                                 # rank
    c = findall( j->j==1, [i in pivot_cols ? 0 : 1 for i in 1:size(R,2)] ) # free variable columns
    H = zeros(Int64, (size(R,2),length(c)))                                   # matrix of homogeneous solutions
    for j in eachindex( c )                                                   # homogeneous solution vector x_j
        H[c[j],j] = 1                                                         # set the current free variable entry to 1
        H[pivot_cols,j] = -R[1:r, c[j]]                                    # set the pivot variable values
    end
    H
end
# ------------------------------------------------------------------------------
function find_pivot(A, row, col)
    for i in row:size(A,1)
        if A[i,col] != 0  return i end
    end
    -1
end
# ------------------------------------------------------------------------------
function non_zero_entry( A, row, col, gj )
    set = (row+1):size(A,1)
    if gj && row > 1
        set = [1:row-1; set]
    end
    for i in set
        if  A[i,col] != 0 return true end
    end
    false
end
# ------------------------------------------------------------------------------
function interchange(A, row_1, row_2)
    for j in 1:size(A,2)
        A[row_1,j],A[row_2,j] = A[row_2,j],A[row_1,j]
    end
end
# ------------------------------------------------------------------------------
function eliminate( A, pivot_row, row, alpha)
    for j in 1:size(A,2)
        A[row,j] += alpha * A[pivot_row,j]
    end
end
# ------------------------------------------------------------------------------
"""
function reduce_to_ref(A; n=:none, gj=false)
reduce A if gj = false, to RREF if gj=true
if n is given, only the first n columns of A are reduced.
"""
function reduce_to_ref(A; n=:none, gj=false)
    if eltype(A) == Complex{Int64}
        A = Complex{Rational{Int64}}.(copy(A))
    elseif eltype(A) == Int64
        A = Rational{Int64}.(copy(A))
    else
        A = copy(A)  # caller took care of the type
    end

    matrices        = [[ :none, copy(A) ]]
    pivot_cols      = Int[]
    description = []

    M,N = size(A)
    if n != :none N = min(n,N) end
    row = 1; col = 1; cur_rank = 0; level=0;
    while true
        p = find_pivot(A, row, col)
        if p < 0
            col += 1
        else
            cur_rank += 1
            push!(pivot_cols, col)
            if p != row
                push!(description, RequireRowExchange( level=level, row_1=row, row_2=p, col=col, cur_rank=cur_rank, pivot_cols=copy(pivot_cols) ))
                level += 1
                interchange( A, p, row )
                E = Matrix{eltype(A)}( I, M, M)
                interchange( E, p, row )
                push!(matrices, [E, copy(A)])
                push!(description, DoRowExchange( level=level, row_1=row,row_2=p, col=col, cur_rank=cur_rank ))
            end
            push!(description,
                  FoundPivot( level=level, row=row, pivot_row=p, pivot_col=col,
                              cur_rank=cur_rank, pivot_cols=copy(pivot_cols)))

            if non_zero_entry( A, row, col, gj )
                push!(description, RequireElimination( level=level, gj=gj, yes=true, row=row, col=col, cur_rank=cur_rank, pivot_cols=copy(pivot_cols) ))
                level += 1

                E = Matrix{eltype(A)}(I, M, M)

                for r in (row+1):M
                    alpha = -A[r,col] / A[row,col]
                    eliminate(A, row, r, alpha )
                    eliminate(E, row, r, alpha )
                end

                if gj
                    for r in 1:(row-1)
                        alpha = -A[r,col] / A[row,col]
                        eliminate(A, row, r, alpha )
                        eliminate(E, row, r, alpha )
                    end
                end
                push!(matrices, [E, copy(A)])
                push!(description, DoElimination( level=level, pivot_row=cur_rank, pivot_col=col, gj=gj))
            else
                push!(description, RequireElimination( level=level, gj=gj, yes=false, row=row, col=col, cur_rank=cur_rank, pivot_cols=copy(pivot_cols)  ))
            end
            col += 1; row += 1
        end

        if (row > M) || (col > N)
            if gj && M > 0                            # Scaling Matrix; only needed if there is a pivot != 1
                require_scaling = false
                scaling_list    = Int[]

                E = Matrix{eltype(A)}(I, M, M)
                for i in eachindex( pivot_cols )
                    pivot_col = pivot_cols[i]
                    if isone( A[i,pivot_col] ) == false
                        require_scaling = true
                        push!( scaling_list,i )
                    end

                    E[i,i] = 1 // A[i,pivot_col] 
                end
                if require_scaling
                    push!(matrices, [E, E*A])
                    push!(description, RequireScaling(level=level, pivot_cols=copy(pivot_cols)))
                    level += 1
                    push!(description, DoScaling(level=level))
                end
            end
            push!(description, Finished(level=level, pivot_cols=copy(pivot_cols)))
            break
        end
    end

    matrices, pivot_cols, description
end 
# ------------------------------------------------------------------------------
function ge_variable_type( pivot_cols, n)
    l = Vector{Any}([ false for _ in 1:n])
    l[pivot_cols] .= true
    l
end
# ------------------------------------------------------------------------------
function decorate_ge( description, pivot_cols, sizeA;
                      pivot_color="yellow!15", missing_pivot_color="gray!20",
                      path_color="blue,line width=0.5mm" )
    M,N = sizeA
    if description == []
        if pivot_cols == []
            pivot_list     = nothing
            bg_list        = nothing
            path_list      = nothing
            variable_types = nothing
        else
            pivot_locs     = [(i-1,pivot_cols[i]-1) for i in eachindex(pivot_cols)]
            pivot_list     = [[(0, 1), pivot_locs ]]
            bg_list        = [[ 0, 1,  pivot_locs, pivot_color]]
            path_list      = [[ 0, 1,  pivot_locs, "vh", path_color]]
            variable_types = ge_variable_type( pivot_cols, N)
        end
        return pivot_list, bg_list, path_list, variable_types
    end

    plist( pivot_cols ) = [ (row-1,pivot_cols[row]-1) for row in eachindex(pivot_cols)]


    function decorate_A!( pivot_dict, bg_dict, path_dict, description )
        update = true
        for desc in description
            level = desc.level

            if typeof(desc) == RequireElimination
                row   = desc.row-1
                col   = desc.col-1
                first = desc.gj ? 0 : row
                bg_dict[  (level,1)] = [bg_dict[(level,1)], [ level,1,  [(row,col), [(first, col),(M-1,col)]], pivot_color, 1 ]]

                if desc.yes == false
                    path_dict[(level,1)] = [ level,1, plist(desc.pivot_cols), "vh", path_color] 
                else
                    path_dict[(level,1)] = [ level,1, plist(desc.pivot_cols), "vv", path_color] 
                end

            elseif typeof(desc) == FoundPivot
                pl = plist( desc.pivot_cols)
                pivot_dict[(level,1)] = [(level, 1), pl ]
                bg_dict[   (level,1)] = [ level, 1,  pl, pivot_color ]

                update = true

            elseif typeof(desc) == RequireRowExchange
                len = length(desc.pivot_cols)
                if len >= 2
                    bg_dict[   (level, 1)] = [[level,1, [(desc.row_1-1,desc.col-1),(desc.row_2-1,desc.col-1)], missing_pivot_color ],
                                              [level,1, plist(desc.pivot_cols[1:end-1]), pivot_color ]]
                elseif len == 1
                    bg_dict[   (level, 1)] = [level,1, [(desc.row_1-1,desc.col-1),(desc.row_2-1,desc.col-1)], missing_pivot_color ]
                end

                if len != 0
                    pl = plist( desc.pivot_cols )
                    pivot_dict[(level, 1)] = [(level,1), pl ]
                    bg_dict[   (level, 1)] = [ level,1,  pl, pivot_color ]
                if level==1 println("3.DBG $level ReqElim: ", bg_dict[(level,1)]); println(".  ", pivot_dict[(level,1)]) end

                    path_dict[ (level, 1)] = [ level,1, pl, "vv", path_color] 
                end
                update = true

            elseif typeof(desc) == RequireScaling
                if desc.pivot_cols != []
                    pl = plist( desc.pivot_cols )
                    if update
                        pivot_dict[(level, 1)] = [(level,  1), pl ]
                        bg_dict[   (level, 1)] = [ level,  1,  pl, pivot_color ]
                if level==1 println("4.DBG $level ReqElim: ", bg_dict[(level,1)]); println(".  ", pivot_dict[(level,1)]) end
                    end
                    path_dict[(level, 1)] = [ level,  1,  pl, "vh", path_color] 
                end
                update = true

            elseif typeof(desc) == Finished
                if desc.pivot_cols != []
                    pl = plist( desc.pivot_cols )
                    pivot_dict[(level, 1)] = [(level,  1), pl ]
                    bg_dict[   (level, 1)] = [ level,  1,  pl, pivot_color ]
                    path_dict[ (level, 1)] = [ level,  1,  pl, "vh", path_color] 
                if level==1 println("5.DBG $level ReqElim: ", bg_dict[(level,1)]); println(".  ", pivot_dict[(level,1)]) end
                end
                update = true
            end
        end
    end
    function decorate_E!( pivot_dict, bg_dict, path_dict, description, M )
        for desc in description
            level = desc.level
            #if typeof(desc) == RequireElimination
            if typeof(desc) == DoElimination
                c = desc.pivot_row-1
                pivot_dict[(level,  0)] = [(level,  0), [(c, c)] ]

                if desc.gj
                    path_dict[(level,0)] = [ level,0,  [(0,c)], "vv", path_color] 
                    bg_dict[  (level,0)] = [ level,0,  [(c,c), [(0,c),(M-1,c)]], pivot_color, 1 ]
                else
                    path_dict[(level,0)] = [ level,0,  [(c,c)], "vv", path_color] 
                    bg_dict[  (level,0)] = [ level,0,  [(c,c), [(c,c),(M-1,c)]], pivot_color, 1 ]
                end
            elseif typeof(desc) == DoRowExchange
                pl = [(desc.row_1-1,desc.row_2-1),(desc.row_2-1,desc.row_1-1)]
                pivot_dict[(level,  0)] = [(level,  0), pl ]
                bg_dict[   (level,  0)] = [ level,  0,  pl, missing_pivot_color ]

            elseif typeof(desc) == DoScaling
                pl = [(c,c) for c in 0:M-1]
                pivot_dict[(level,  0)] = [(level,  0), pl ]
                bg_dict[   (level,  0)] = [ level,  0,  pl, pivot_color ]
            end
        end
    end
    pivot_dict = Dict{Tuple{Int,Int}, Any}()
    bg_dict    = Dict{Tuple{Int,Int}, Any}()
    path_dict  = Dict{Tuple{Int,Int}, Any}()

    decorate_A!( pivot_dict, bg_dict, path_dict, description )
    decorate_E!( pivot_dict, bg_dict, path_dict, description, M )

    [i for i in values(pivot_dict)],
    [i for i in values(bg_dict)],
    [i for i in values(path_dict)],
    ge_variable_type( pivot_cols, N)
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------------- QR algoorithm
# ------------------------------------------------------------------------------
"""Naive Gram-Schmidt"""
function gram_schmidt_w(A)
    W   = Array{Rational{eltype(A)}}(undef, size(A))
    N = size(A,2)
    for j=1:N
        v_j = Rational.(A[:,j])
        for k=1:j-1
            v_j = v_j - (dot(W[:,k], A[:,j]) / dot(W[:,k], W[:,k]) ) .* W[:,k]
        end
        tmp = reduce( (x,y)-> lcm(x,denominator(y)), v_j, init=1) * v_j
        d   = reduce( gcd, tmp, init=tmp[1] )
        W[:,j] =  tmp / d
    end
    Int64.(W)
end
# ------------------------------------------------------------------------------
function qr_layout(A)
    W = gram_schmidt_w(A)

    WtW  = Diagonal(W'W)
    WtA  = W'A
    S    =  ((x-> Rational{Int64}(round(sqrt(x)))).(WtW))^(-1)

    Qt = S * W'
    R  = S * WtA

    matrices =  [ [ :none,  :none,     A,        W ],
                  [ :none,     W',   WtA,      WtW ],
                  [     S,     Qt,     R,    :none ] ]

    to_latex( matrices )
end
# ------------------------------------------------------------------------------
# -------------------------------------------------------------- Normal Equation
# ------------------------------------------------------------------------------
# ==============================================================================
