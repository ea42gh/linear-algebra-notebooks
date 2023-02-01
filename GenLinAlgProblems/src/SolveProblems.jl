#using LinearAlgebra

# ------------------------------------------------------------------------------
# --------------------------------------------------------- GE and GJ algorithms
# ------------------------------------------------------------------------------
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
function reduce_to_ref(A; gj=false)
    matrices       = [[ :none, A ]]
    pivot_indices  = Int[]
    description    = []
    if eltype(A) == Complex{Int64}
        A = Complex{Rational{Int64}}.(copy(A))
    elseif eltype(A) == Int64
        A = Rational{Int64}.(copy(A))
    else
        A = copy(A)  # caller took care of the type
    end

    M,N = size(A)
    row = 1; col = 1
    while true
        if (row > M) || (col > N)
            if gj && M > 0                            # Scaling Matrix; only needed if there is a pivot != 1
                require_scaling = false
                scaling_list    = Int[]

                E = Matrix{eltype(A)}(I, M, M)
                for i in eachindex( pivot_indices )
                    pivot_col = pivot_indices[i]
                    if isone( A[i,pivot_col] ) == false
                        require_scaling = true
                        push!( scaling_list,i )
                    end

                    E[i,i] = 1 // A[i,pivot_col] 
                end
                if require_scaling
                    push!(matrices, [E, E*A])
                    push!(description, ["scaling", row, scaling_list])
                end
            end
            return matrices, pivot_indices, description
        end

        p = find_pivot(A, row, col)
        if p < 0
            col += 1
        else
            push!(pivot_indices, col)
            if p != row
                interchange( A, p, row )
                E = Matrix{eltype(A)}( I, M, M)
                interchange( E, p, row )
                push!(matrices, [E, copy(A)])
                push!(description, ["exchange", row, p, col])
            end

            if non_zero_entry( A, row, col, gj )
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
                push!(description, ["elim", row, col, gj])
            end
            col += 1; row += 1
        end
    end
    matrices, pivot_indices, description
end 
# ------------------------------------------------------------------------------
# run down the description
#      elim:      add a pivot to all current and subsequent levels (box and color)
#                 show pivot in next E matrix
#      exchange:  add two gray boxes at current level,  pivot to all subsequent levels
#                 show exhange in next E matrix
#      scaling:   no pivot action
#                 show scaling in next E matrix
# ------------------------------------------------------------------------------
function ge_variable_type( pivot_cols, n)
    l = Vector{Any}([ false for _ in 1:n])
    l[pivot_cols] .= true
    l
end
# ------------------------------------------------------------------------------
function decorate_ge( description, m;
                      pivot_color="yellow!15", missing_pivot_color="gray!20",
                      path_color="blue,line width=0.5mm" )
    pivot_locs = Dict{Int, Any}(0 => [])
    pivot_list = []
    bg_list    = []
    path_list  = []

    for i in 1:length( description)+1
        pivot_locs[i] = []
    end
    level    = 0
    add      = true
    cur_rank = 0

    for desc in description
        if desc[1] == "elim"   # type, row, col, gj
            loc = (desc[2]-1,desc[3]-1)
            if add
                for l in level:length(description)+1
                    push!( pivot_locs[l], loc )
                end
            end
            push!( pivot_list, [(level+1,  0), [(cur_rank,cur_rank)] ])
            push!( bg_list,    [ level+1,  0,  [(cur_rank,cur_rank)], pivot_color ])
            push!( path_list,  [ level,    1,  pivot_locs[level],     "vv", path_color ])

            # Fix elim display in E
            row = desc[4] ? 0 : cur_rank
            push!( path_list,  [ level+1,  0,  [(row, cur_rank+1)],  "vv", path_color ])

            cur_rank += 1
            add = true

        elseif desc[1] == "exchange"   # type, row, pivot_row, col
            desired_pivot_loc = (desc[2]-1,desc[4]-1)
            for l in level+1:length(description)+1
                push!( pivot_locs[l], desired_pivot_loc )
            end
            push!( bg_list, [ level,1, [desired_pivot_loc,(desc[3]-1,desc[4]-1)], missing_pivot_color ])

            #println( "exchange $level: push path $(pivot_locs[level])")
            #push!( path_list,  [ level+1,    1,  pivot_locs[level+1],     "vv", path_color ])

            # add colored box to E at next level
            loc =[ (desc[2]-1,desc[3]-1), (desc[3]-1,desc[2]-1)] 
            push!( pivot_list, [(level+1,  0), loc ])
            push!( bg_list,    [ level+1,  0,  loc, pivot_color ])
            desired_pivot_locs = push!( copy( pivot_locs[level]), desired_pivot_loc )

            push!( path_list,  [ level,    1,  desired_pivot_locs,     "vv", path_color ])

            add = false

        elseif desc[1] == "scaling"   # type, row?, pivot_cols  nonsense?????
            # add colored box to diagonal of E at next level
            push!( path_list,  [ level,    1,  pivot_locs[level],     "vv", path_color ])

            loc = [(k,k) for k in 0:m-1]
            push!( pivot_list, [(level+1,  0), loc ])
            push!( bg_list,    [ level+1,  0,  loc, pivot_color ])
            add = true
        end
        push!( pivot_list, [(level,  1), pivot_locs[level] ])
        push!( bg_list,    [ level,  1,  pivot_locs[level], pivot_color ])

        level += 1
    end

    push!( pivot_list, [(level,  1), pivot_locs[level] ])
    push!( bg_list,    [ level,  1,  pivot_locs[level], pivot_color ])

    push!( path_list,  [ level,  1,  pivot_locs[level], "vh", path_color ])

    pivot_list, bg_list, path_list
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

    convert_to_latex( matrices )
end
# ------------------------------------------------------------------------------
# -------------------------------------------------------------- Normal Equation
# ------------------------------------------------------------------------------
# ==============================================================================
