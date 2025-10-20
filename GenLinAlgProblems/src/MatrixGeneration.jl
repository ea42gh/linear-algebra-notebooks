#using LinearAlgebra, Latexify, Random

# ------------------------------------------------------------------------------
# ----------- Integer Square Roots:  Pythagorean Number Triplets and Quadruplets
# ------------------------------------------------------------------------------
PythagoreanNumberTriplets =
[   3    4    5
    5   12   13
    7   24   25
    8   15   17
    9   40   41
   11   60   61
   12   35   37
   13   84   85
   15  112  113 ]

PythagoreanNumberQuadruplets =
[   1   2   2   3
    2  10  11  15
    4  13  16  21
    2  10  25  27
    2   3   6   7
    1  12  12  17
    8  11  16  21
    2  14  23  27
    1   4   8   9
    8  9   12  17
    3  6   22  23
    7  14  22  27
    4   4   7   9
    1   6  18  19
    3  14  18  23
   10  10  23  27
    2   6   9  11
    6   6  17  19
    6  13  18  23
    3  16  24  29
    6   6   7  11
    6  10  15  19
    9  12  20  25
   11  12  24  29
    3   4  12  13
    4   5  20  21
   12  15  16  25
   12  16  21  29
    2   5  14  15
    4   8  19  21
    2   7  26  27 ];
# ------------------------------------------------------------------------------
# ---------------------------------------------- matrices and vectors of symbols
# ------------------------------------------------------------------------------
raw""" symbol_vec = symbol_vector( s="x", indices )"""
function symbol_vector( s, indices )
    [Symbol(s*"_$i") for i in collect(indices)]
end
# ------------------------------------------------------------------------------
raw"""
Create a matrix of symbolic variables with names based on given indices.

    symbols_matrix(s, row_indices, col_indices)

    # Arguments
    - `s::String`: Base string for the symbols (e.g., "a").
    - `row_indices`: Iterable of row indices.
    - `col_indices`: Iterable of column indices.

    # Returns
    - `Matrix{Sym}`: A matrix of symbolic variables.
"""
function symbols_matrix(s::String, row_indices, col_indices)
    rows = collect(row_indices)
    cols = collect(col_indices)
    matrix = [symbols("$(s)_{$(i),$(j)}", real=true) for i in rows, j in cols]
    return matrix
end
# ------------------------------------------------------------------------------
# ------------------------------------- matrices for use in GE and GJ algorithms
# ------------------------------------------------------------------------------
function _int_range( maxint, has_zeros)
    if has_zeros
        rng = -maxint:maxint
    else
        rng = [-maxint:-1; 1:maxint]
    end
    rng
end
# ------------------------------------------------------------------------------
raw""" L = unit_lower(m,n; maxint=3)
"""
function unit_lower(m,n; maxint=3)
    # create a unit lower triangular matrix
    [ x>y ? rand(-maxint:maxint) : (x == y ? 1 : 0) for x in 1:m, y in 1:n]
end
# ------------------------------------------------------------------------------
raw""" L = unit_lower(m; maxint=3)
"""
function unit_lower(m; maxint=3)
   unit_lower(m,m,maxint=maxint)
end
# ------------------------------------------------------------------------------
""" L = lower(m,n; maxint=3)
"""
function lower(m,n; maxint=3)
    L = unit_lower(m,n; maxint=maxint)
    for i in 1:min(m,n)
        L[i,i] = rand( [-maxint:-1; 1:maxint])
    end
    L
end
# ------------------------------------------------------------------------------
""" L = lower(m; maxint=3)
"""
function lower(m; maxint=3)
    lower(m,m,maxint=maxint)
end
# ------------------------------------------------------------------------------
raw""" R,pivot_cols = rref_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false)
"""
function rref_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false)
    # create a reduced row echelon form matrix of size m x n and rank r
    if pivot_in_first_col || r==n
        pivot_cols = sort!([1; (2:n)[randperm(n-1)]][1:r])
    else
        pivot_cols = sort!((2:n)[randperm(n-1)][1:r])
    end

    rng = _int_range(maxint,has_zeros)

    if m > r
        M = [ rand(rng, (r,n))
              zeros(Int64, (m-r,n))
        ]
    else
        M = rand( rng, (m,n) )
    end
    for i in 1:r
        for j in 1:(pivot_cols[i]-1)
            M[i,j] = 0
        end
        M[i,pivot_cols[i]]         = 1
        M[1:(i-1), pivot_cols[i]] .= 0
    end
    M, pivot_cols
end
# ------------------------------------------------------------------------------
raw""" U, pivot_cols = ref_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false)
"""
function ref_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false)
    M,pivot_cols = rref_matrix(m,n,r; maxint=maxint, pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros)
    rng = _int_range( maxint, false)
    M   = Diagonal(rand(rng,m)) * M * unit_lower(n,n,maxint=1)'
    M, pivot_cols
end
# ------------------------------------------------------------------------------
raw""" A = gen_full_col_rank_matrix(mc,nc; maxint=3)
"""
function gen_full_col_rank_matrix(mc,nc; maxint=3)
    # produce a reasonable A'A matrix; need m ≥ n
    m = sum(mc)
    n = sum(nc)

    Q = sparse_Q_matrix(mc)
    M = zeros(Int64, (m,n))
    rng = _int_range(maxint, false)
    for i = 1:min(m,n)
        M[i,i] = rand( rng )
    end
    Q[:,1:m]*unit_lower(m,maxint=maxint)*M
end
# ------------------------------------------------------------------------------
raw""" S = symmetric_matrix(m;maxint=3, with_zeros=false )
"""
function symmetric_matrix(m;maxint=3, with_zeros=false )
    rng = _int_range(maxint,with_zeros)
    A = [ x>y ? rand(rng) : 0 for x in 1:m, y in 1:m]
    A = A+A'
    for i in 1:m
        A[i,i] = rand([-maxint:-1; 1:maxint])
    end
    A
end
# ------------------------------------------------------------------------------
raw""" A = skew_symmetric_matrix(m;maxint=3, with_zeros=false )
"""
function skew_symmetric_matrix(m;maxint=3, with_zeros=false )
    rng = _int_range(maxint,with_zeros)
    A = [ i>j ? rand(rng) : 0 for i in 1:m, j in 1:m]
    A - A'
end
# ------------------------------------------------------------------------------
raw""" e_i = e_i(i,n)
"""
function e_i(i,n)
    v = zeros( Int, n )
    v[i] = 1
    v
end
# ------------------------------------------------------------------------------
raw""" E = i_with_onecol(m,c; maxint=3, with_zeros=false, lower=true, upper=true)
"""
function i_with_onecol(m,c; maxint=3, with_zeros=false, lower=true, upper=true)
    rng = _int_range(maxint,with_zeros)
    # take I and set column c to random entries
    E        = collect(1I(m))           # Int64  eye(m)
    if lower && c < m
        E[c+1:m,c] = rand(rng, m-c)  # set column c to non-zero entries
    end
    if upper && c > 1
        E[1:c-1,c] = rand(rng, c-1)  # set column c to non-zero entries
    end
    E[c,c]   = 1
    E
end
# ------------------------------------------------------------------------------
raw""" P = gen_permutation_matrix(row_order::Vector{Int})
"""
function gen_permutation_matrix(row_order::Vector{Int})
    n = length(row_order)
    P = zeros(Int, (n,n))
    for i in 1:n
        P[row_order[i],i] = 1
    end
    P
end
# ------------------------------------------------------------------------------
raw""" P = gen_permutation_matrix(n)
"""
function gen_permutation_matrix(n)
    locs = randperm(n)
    P    = zeros(Int, (n,n))
    for i in 1:n
        P[i,locs[i]] = 1
    end
    P
end
# ------------------------------------------------------------------------------
# -------------------------------------------------------------- GE, GJ problems
# ------------------------------------------------------------------------------
raw""" pivot_cols, A = gen_gj_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false )
"""
function gen_gj_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false )
    M,pivot_cols=rref_matrix(m,n,r,maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )

    s = ones( Int, n )
    s[pivot_cols] = rand( [-maxint:-1;1:maxint], r )

    A = unit_lower(m,maxint=maxint) * unit_lower(m,maxint=maxint)' * M * Diagonal(s)
    pivot_cols, A
end
# ------------------------------------------------------------------------------
raw""" X,B = gen_rhs( A, pivot_cols; maxint=3,num_rhs=1,has_zeros=false) """
function gen_rhs( A, pivot_cols; maxint=3,num_rhs=1,has_zeros=false)
    rng = _int_range(maxint,has_zeros)
    X   = zeros(Int64, (size(A,2),num_rhs))

    X[pivot_cols,:] = rand( rng, (length(pivot_cols),num_rhs) )
    B = A*X
    X,B
end
# ------------------------------------------------------------------------------
# given the pivot locations, generate a particular solution of N integer entries, free variables set to zero
raw""" X = gen_particular_solution( pivot_cols, n; maxint=3, num_rhs=1 )
"""
function gen_particular_solution( pivot_cols, n; maxint=3, num_rhs=1 )
    X               = zeros(Int64, (n,num_rhs))
    X[pivot_cols,:] = rand( [-maxint:-1; 1:maxint], (length(pivot_cols),num_rhs) )
    X
end
# ------------------------------------------------------------------------------
raw""" A,X,B = gen_gj_pb(m,n,r;
"""
function gen_gj_pb(m,n,r;
        maxint=3, pivot_in_first_col=true, has_zeros=false, num_rhs=1 )
    pivot_cols,A = gen_gj_matrix(m,n,r;
                                 maxint=maxint, pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )
    X,B=gen_rhs(A, pivot_cols; maxint=maxint,num_rhs=num_rhs,has_zeros=has_zeros)
    A,X,B
end
# ------------------------------------------------------------------------------
raw""" A,X,B = gen_gj_pb(m,n; maxint=3)
"""
function gen_gj_pb(m,n; maxint=3)
    gen_gj_pb( m,n,min(m,n); maxint=maxint )
end
# ------------------------------------------------------------------------------
#HERE function ref_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false)
#function gen_inconsistent_gj_problem(m,n,r;
#        maxint=3, pivot_in_first_col=true, has_zeros=false, num_rhs=1 )
#    M,pivot_cols=rref_matrix(m,n,r,maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )
#
#    s = ones( Int, n )
#    s[pivot_cols] = rand( [-maxint:-1;1:maxint], r )
#
#    E = unit_lower(m,maxint=maxint) * unit_lower(m,maxint=maxint)'
#
#    A = E * M * Diagonal(s)
#
#    X,B=gen_rhs(A, pivot_cols; maxint=maxint,num_rhs=num_rhs,has_zeros=has_zeros)
#
#    A,X,B
#end
# ------------------------------------------------------------------------------
raw""" L_inv = invert_unit_lower(L::Matrix{Int})
"""
function invert_unit_lower(L)
    n = size(L, 1)
    L_inv = Matrix{eltype(L)}(I, n, n)

    for j in n-1:-1:1 # current column of L_inv to update
        for k in j+1:n   # Use these columns of L_inv
            for i in k:n # each affected row
                L_inv[i, j] -= L[k, j] * L_inv[i, k]
            end
        end
    end
    return L_inv
end
# ------------------------------------------------------------------------------
raw""" A, A_inv = gen_inv_pb(n; maxint=3)
"""
function gen_inv_pb(n; maxint=3)
    # create an invertible matix problem of size n x n
    # with maxint=2, this works for n <= 15 or so
    e1 = unit_lower( n,n, maxint=maxint )
    e2 = unit_lower( n,n, maxint=maxint )
    A  = e1*e2'

    #A_inv = invert_unit_lower(e2)'*invert_unit_lower(e1)
    A_inv = Int.(inv(Rational{Int}.(A)))
    A, A_inv
end
# ------------------------------------------------------------------------------
raw""" L,D,A = gen_ldlt_pb(m;maxint=3,rank=:none, squares = false)
"""
function gen_ldlt_pb(m;maxint=3,rank=:none, squares = false)
    L   = unit_lower(m,maxint=maxint) 
    p   =  squares ? (1:maxint).^2 : 1:maxint
    if rank != :none
        pivots = [rand( p, rank); zeros(Int, m-rank)]
        D   = Diagonal( pivots )
    else
        D   = Diagonal( rand( p, m))
    end

    A = L * D * L'
    L, D, A
end
# ------------------------------------------------------------------------------
raw""" pivot_cols,L,U,A = gen_lu_pb(m,n,r;maxint=3,pivot_in_first_col=true, has_zeros=false)
"""
function gen_lu_pb(m,n,r;maxint=3,pivot_in_first_col=true, has_zeros=false)
    U,pivot_cols = ref_matrix(m,n,r,maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )
    L   = unit_lower(m,maxint=maxint)

    A = L * U
    pivot_cols, L, U, A
end
# ------------------------------------------------------------------------------
raw"""pivot_cols,P,L,U,A =  gen_plu_pb(m,n,r;maxint=3,pivot_in_first_col=true, has_zeros=false)
"""
function gen_plu_pb(m,n,r;maxint=3,pivot_in_first_col=true, has_zeros=false)
    pivot_cols, L, U, A = gen_lu_pb(m,n,r;maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros)

    P  = gen_permutation_matrix(m)
    A            = L * P * U

    matrices,_,_ = reduce_to_ref(P'A)
    if length(matrices) > 1
        L̃            = 1I-sum([tril(l[1],-1) for l in matrices[2:end]])
    else
        L̃            = 1I(m)
    end
    Ũ            = inv(Rational{Int}.(L̃))*P'*A
    pivot_cols, P, L̃, Ũ, A
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------- orthogonal matrices
# ------------------------------------------------------------------------------
raw""" c,W = W_2_matrix()
"""
function W_2_matrix()
    a,b,c = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]
    c,[ a -b; b a]
end
# ------------------------------------------------------------------------------
raw""" Q = Q_2_matrix()
"""
function Q_2_matrix()
    c,W = W_2_matrix()
    W // c
end
# ------------------------------------------------------------------------------
raw""" c,W =  W_3_matrix(; maxint=3)
"""
function W_3_matrix(; maxint=3)
    a,b,c = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]
    A = [ a -b 0
          b  a 0
          0  0 rand( [-maxint:-1; 1:maxint]) ]
    A = A[shuffle(1:3),:]
    c,A[ :, shuffle(1:3)]
end
# ------------------------------------------------------------------------------
raw""" Q = Q_3_matrix()
"""
function Q_3_matrix()
    a,b,c = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]
    A = [ a//c -b//c  0
          b//c  a//c  0
             0     0  1 ]
    A = A[shuffle(1:3),:]
    A[ :, shuffle(1:3)]
end
# ------------------------------------------------------------------------------
# the following matrix has a block structure
raw""" Q = Q_4_blocks()
"""
function Q_4_blocks()
    a1,b1,c1 = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]
    a2,b2,c2 = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]

    A = [ a1//c1 -b1//c1             0            0
          b1//c1  a1//c1             0            0
          0                          0   a2//c2  b2//c2 
          0                          0  -b2//c2  a2//c2 ]

    A = A[shuffle(1:4), :]
    A[ :, shuffle(1:4)]
end
# ------------------------------------------------------------------------------
raw""" d,W = W_4_matrix()
"""
function W_4_matrix()
    a,b,c,d = PythagoreanNumberQuadruplets[ rand(1:size(PythagoreanNumberQuadruplets,1)), : ]
    p  = (a*a + b*b) * d*d
    a2 = -a*c* p
    a3 =  a*b* p
    a4 =  a*a* p

    den = gcd(gcd( a2, a3), a4 )
    a2 = Int( a2 // den)
    a3 = Int( a3 // den)
    a4 = Int( a4 // den)

    A = [ a -b -c   0
          b  a  0  a2
          c  0  a  a3 
          0  c -b  a4 ]
    A = A[shuffle(1:4), :]
    d,A[ :, shuffle(1:4)] ,(a,-b,-c, a2,a3,a4)
end
# ------------------------------------------------------------------------------
raw""" Q = Q_4_matrix()
"""
function Q_4_matrix()
    d,W = W_4_matrix()
    W//d
end
# ------------------------------------------------------------------------------
raw""" W = W_matrix(n; general=false)
"""
function W_matrix(n; general=false)
  if general == false
    if     n == 2 return W_2_matrix()
    elseif n == 3 return W_3_matrix()
    elseif n == 4 return W_4_matrix()
    end
  end
  A = Q_matrix(n; general=general)
  _,Aint = factor_out_denominator( A )
  Aint
end
# ------------------------------------------------------------------------------
raw""" Q = Q_matrix(n; maxint=3, with_zeros=false, general=false )
"""
function Q_matrix(n; maxint=3, with_zeros=false, general=false )
  if general == false
    if     n == 2 return Q_2_matrix()
    elseif n == 3 return Q_3_matrix()
    end
  end
  S=skew_symmetric_matrix(n,maxint=maxint, with_zeros=with_zeros)
  inv(S-(1//1)I(size(S,1))) * (S+1I(size(S,1)))
end
# ------------------------------------------------------------------------------
raw""" Q = sparse_Q_matrix(n; maxint=3, with_zeros=false )
"""
function sparse_Q_matrix(n; maxint=3, with_zeros=false )
    sz = sum(n)
    A  = zeros(Rational{Int64},(sz,sz))
    i  = 1
    for m in n
        S = Rational{Int64}.( skew_symmetric_matrix(m; maxint=maxint, with_zeros=with_zeros ) )
        E = (1//1)I(m)
        F = inv( S - E ) * ( S + E )
        rng = i:i+m-1 |> collect
        A[rng,rng] = F
        i += m
    end

    A = A[shuffle(1:sz), :]
    A[ :, shuffle(1:sz)]
end
# ------------------------------------------------------------------------------
raw""" d,W = sparse_W_matrix(n)
"""
function sparse_W_matrix(n)
    A = sparse_Q_matrix(n)
    factor_out_denominator(A)
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------------- Orthogonality
# ------------------------------------------------------------------------------
raw""" P = ca_projection_matrix(A)
"""
function ca_projection_matrix(A)
    A*inv(A'A)*A'
end
# ------------------------------------------------------------------------------
raw""" A = gen_qr_problem(even_n;maxint=3)
"""
function gen_qr_problem(even_n;maxint=3)
    hadamard(even_n)[:,shuffle(1:even_n)]*lower(even_n,maxint=maxint)'
end

raw""" A = gen_qr_problem_3(;maxint=3)
"""
function gen_qr_problem_3(;maxint=3)
    _,W = W_3_matrix(maxint=maxint)
    W*unit_lower(3, maxint=maxint)'
end

raw""" A = gen_qr_problem_4(;maxint=3)
"""
function gen_qr_problem_4(;maxint=3)
    _,W = W_4_matrix()
    W*unit_lower(4,maxint=maxint)'
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------------- Eigenproblems
# ------------------------------------------------------------------------------
raw""" S,Λ,S_inv,A = function gen_eigenproblem( e_vals; maxint=3 ) """
function gen_eigenproblem( e_vals; maxint=3 )
    Λ = Diagonal( e_vals )
    S,S_inv = gen_inv_pb( size(e_vals,1), maxint=maxint )
    S,Λ,S_inv, S*Λ*S_inv
end
# ------------------------------------------------------------------------------
raw""" S,Λ,S_inv,A = gen_cx_eigenproblem( evals_no_conj; maxint=1 ) """
function gen_cx_eigenproblem( evals_no_conj; maxint=1 )
    function construct_diagonal_blocks()
        t = typeof( real( evals_no_conj[1] ))
        function f(x)
            if imag(x) == zero( t )
                [x]
            else
                [real(x) -imag(x); imag(x) real(x)]
            end
        end
        blocks  = [f(x) for x in evals_no_conj ]
        sz = sum( (x->size(x,1)).(blocks))
        A = zeros( t, sz, sz)
        k = 1
        for b in blocks
            l = size(b,1)-1
            A[k:k+l, k:k+l] = b
            k += l+1
        end
        A
    end

    Λ       = construct_diagonal_blocks()
    S,S_inv = gen_inv_pb( size(Λ,1), maxint=maxint )
    S,Λ,S_inv, S*Λ*S_inv
end
# ------------------------------------------------------------------------------
raw""" S, Λ, A = gen_symmetric_eigenproblem( e_vals; maxint=3, with_zeros=false, general=false ) """
function gen_symmetric_eigenproblem( e_vals; maxint=3, with_zeros=false, general=false )
    S = Q_matrix( size(e_vals,1); maxint=maxint, with_zeros=with_zeros, general=general )
    Λ = Diagonal( e_vals )
    S, Λ, S * Λ * S'
end
# ------------------------------------------------------------------------------
raw""" A = gen_non_diagonalizable_eigenproblem( e_dup, e; maxint=4 )
"""
function gen_non_diagonalizable_eigenproblem( e_dup, e; maxint=4 )
    # size 3x3 problem
    S,S_inv = gen_inv_pb(3, maxint=maxint )
    Λ = [e_dup 1 0; 0 e_dup 0; 0 0 e]
    S * Λ * S_inv
end
# ------------------------------------------------------------------------------
raw""" J = jordan_block(lambda,k)
"""
function jordan_block(lambda,k)
    J = Bidiagonal( fill(lambda,k), ones(typeof(lambda),k-1),:U)
end
# ------------------------------------------------------------------------------
raw""" A = jordan_form( j_blocks )
"""
function jordan_form( j_blocks )
    sz = sum([ size(b,1) for b in j_blocks ])
    A  = zeros( eltype( j_blocks[1]), sz, sz )
    i = 1
    for b in j_blocks
        sz_b = size(b,1)
        A[i:i+sz_b-1, i:i+sz_b-1] = b
        i += sz_b
    end
    A
end
# ------------------------------------------------------------------------------
raw""" A = gen_from_jordan_form( j_blocks; maxint=3 )
"""
function gen_from_jordan_form( j_blocks; maxint=3 )
    A = jordan_form( j_blocks )
    S,S_inv = gen_inv_pb( size(A,1), maxint=maxint )
    S*A*S_inv
end
# ------------------------------------------------------------------------------
# Generate a degenerate matrix based on block sizes or (eigenvalue, size) pairs
raw""" P,J,P_inv,A = gen_degenerate_matrix(block_descriptions::Vararg{Any}; maxint=3)
"""
function gen_degenerate_matrix(block_descriptions::Vararg{Any}; maxint=3)
    total_size = 0
    for desc in block_descriptions
        if isa(desc, Int)
            total_size += desc  # Integer block size (nilpotent case)
        elseif isa(desc, Tuple) && length(desc) == 2
            total_size += desc[2]  # Tuple (block eigenvalue, size)
        else
            throw(ArgumentError("Each block description must be an integer or a tuple (λ, n)."))
        end
    end

    J = zeros(eltype(block_descriptions[1]), total_size, total_size)
    current_row = 1

    for desc in block_descriptions
        if isa(desc, Int)                                 # Nilpotent Jordan block
            n = desc
            J[current_row:(current_row+n-1), current_row:(current_row+n-1)] .= jordan_block(0, n)
        elseif isa(desc, Tuple) && length(desc) == 2      # Degenerate Jordan block with eigenvalue
            λ,n = desc
            J[current_row:(current_row+n-1), current_row:(current_row+n-1)] .= jordan_block(λ, n)
        end
        current_row += desc isa Int ? desc : desc[1]
    end

    P, P_inv = gen_inv_pb(total_size, maxint=maxint)
    P, J, P_inv, P * J * P_inv
end
# ------------------------------------------------------------------------------
raw""" U, Σ, Vt, U * Σ * Vt = gen_svd_problem(m,n,σ; maxint = 3) """
function gen_svd_problem(m,n,σ; maxint = 3)
    U  = sparse_Q_matrix( m, maxint=maxint)
    Vt = sparse_Q_matrix( n, maxint=maxint)
    m = sum(m); n=sum(n)
    Σ  = zeros(eltype(σ[1]), m,n)
    for i in 1:min( m, size(σ,1) )
        Σ[i,i] = σ[i]
    end
    U, Σ, Vt, U * Σ * Vt
end
# ==============================================================================
