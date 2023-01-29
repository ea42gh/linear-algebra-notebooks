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
function unit_lower(m,n; maxint=3)
    # create a unit lower triangular matrix
    [ x>y ? rand(-maxint:maxint) : (x == y ? 1 : 0) for x in 1:m, y in 1:n]
end
# ------------------------------------------------------------------------------
function unit_lower(m; maxint=3)
   unit_lower(m,m,maxint=maxint)
end
# ------------------------------------------------------------------------------
function lower(m,n; maxint=3)
    L = unit_lower(m,n; maxint=maxint)
    for i in 1:min(m,n)
        L[i,i] = rand( [-maxint:-1; 1:maxint])
    end
    L
end
# ------------------------------------------------------------------------------
function lower(m; maxint=3)
    lower(m,m,maxint=maxint)
end
# ------------------------------------------------------------------------------
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
function ref_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false)
    M,pivot_cols = rref_matrix(m,n,r; maxint=maxint, pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros)
    rng = _int_range( maxint, false)
    M   = Diagonal(rand(rng,m)) * M * unit_lower(n,n,maxint=1)'
    M, pivot_cols
end
# ------------------------------------------------------------------------------
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
function skew_symmetric_matrix(m;maxint=3, with_zeros=false )
    rng = _int_range(maxint,with_zeros)
    A = [ i>j ? rand(rng) : 0 for i in 1:m, j in 1:m]
    A - A'
end
# ------------------------------------------------------------------------------
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
function gen_permutation_matrix(n)
    locs = randperm(n)
    P    = 1I(n)
    for i in 1:n
        P[i,locs[i]] = 1
    end
    P
end
# ------------------------------------------------------------------------------
# -------------------------------------------------------------- GE, GJ problems
# ------------------------------------------------------------------------------
function gen_gj_matrix(m,n,r; maxint=3, pivot_in_first_col=true, has_zeros=false )
    M,pivot_cols=rref_matrix(m,n,r,maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )
    i = 1
    for j in pivot_cols
        M[i,j] = rand([-maxint:-1; 1:maxint])
        M[i,j+1:end] *= M[i,j]
        i += 1
    end

    A = unit_lower(m,maxint=maxint) * unit_lower(m,maxint=maxint)' * M
    pivot_cols, A
end
# ------------------------------------------------------------------------------
function gen_rhs( A, pivot_cols; maxint=3,num_rhs=1,has_zeros=false)
    rng = _int_range(maxint,has_zeros)
    X   = zeros(Int64, (size(A,2),num_rhs))

    X[pivot_cols,:] = rand( rng, (length(pivot_cols),num_rhs) )
    B = A*X
    X,B
end
# ------------------------------------------------------------------------------
# given the pivot locations, generate a particular solution of N integer entries, free variables set to zero
function gen_particular_solution( pivot_cols, n; maxint=3, num_rhs=1 )
    X               = zeros(Int64, (n,num_rhs))
    X[pivot_cols,:] = rand( [-maxint:-1; 1:maxint], (length(pivot_cols),num_rhs) )
    X
end
# ------------------------------------------------------------------------------
function gen_gj_pb(m,n,r;
        maxint=3, pivot_in_first_col=true, has_zeros=false, num_rhs=1 )
    pivot_cols,A = gen_gj_matrix(m,n,r;
                                 maxint=maxint, pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )
    X,B=gen_rhs(A, pivot_cols; maxint=maxint,num_rhs=num_rhs,has_zeros=has_zeros)
    A,X,B
end
# ------------------------------------------------------------------------------
function gen_gj_pb(m,n; maxint=3)
    gen_gj_pb( m,n,min(m,n); maxint=maxint )
end
# ------------------------------------------------------------------------------
function gen_inv_pb(n; maxint=3)
    # create an invertible matix problem of size n x n
    e1 = unit_lower( n,n, maxint=maxint )
    e2 = unit_lower( n,n, maxint=maxint )
    A  = e1*e2'

    A_inv = inv(A)
    A, Int64.(round.(A_inv))
end
# ------------------------------------------------------------------------------
function gen_lu_pb(m,n,r;maxint=3,pivot_in_first_col=true, has_zeros=false)
    U,pivot_cols = ref_matrix(m,n,r,maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros )
    rng = _int_range( maxint, false)
    L   = unit_lower(m,maxint=maxint) 

    A = L * U
    pivot_cols, L, U, A
end
# ------------------------------------------------------------------------------
function gen_plu_pb(m,n,r;maxint=3,pivot_in_first_col=true, has_zeros=false)   # TODO: generate P
    pivot_cols, L, U, A = gen_lu_pb(m,n,r;maxint=maxint,pivot_in_first_col=pivot_in_first_col, has_zeros=has_zeros)

    P   = Matrix{eltype(U)}(I, m,m )

    if m > r
        num_rows_to_exchange  = min(m-r,rand(1:r))
        rows_to_exchange      = randperm(r)[1:num_rows_to_exchange]
        for i in eachindex(rows_to_exchange)
            j = rows_to_exchange[i]
            P[j,  j] = zero(eltype(P)); P[r+i,r+i] = zero(eltype(P))
            P[r+i,j] = one(eltype(P));  P[j,  r+i] = one(eltype(P))
        end
    end

    L = unit_lower(m,maxint=maxint)
    A = L * P * U
    pivot_cols, P, P'L*P, U, A
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------- orthogonal matrices
# ------------------------------------------------------------------------------
function W_2_matrix()
    a,b,c = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]
    c,[ a -b; b a]
end
# ------------------------------------------------------------------------------
function Q_2_matrix()
    c,W = W_2_matrix()
    W // c
end
# ------------------------------------------------------------------------------
function W_3_matrix(; maxint=3)
    a,b,c = PythagoreanNumberTriplets[ rand(1:size(PythagoreanNumberTriplets,1)), : ]
    A = [ a -b 0
          b  a 0
          0  0 rand( [-maxint:-1; 1:maxint]) ]
    A = A[shuffle(1:3),:]
    c,A[ :, shuffle(1:3)]
end
# ------------------------------------------------------------------------------
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
function Q_4_matrix()
    d,W = W_4_matrix()
    W//d
end
# ------------------------------------------------------------------------------
function W_matrix(n)
    if     n == 2 return W_2_matrix()
    elseif n == 3 return W_3_matrix()
    elseif n == 4 return W_4_matrix()
    end
    A = Q_matrix(n)
    _,Aint = factor_out_denominator( A )
    Aint
end
# ------------------------------------------------------------------------------
function Q_matrix(n; maxint=3, with_zeros=false )
    if     n == 2 return Q_2_matrix()
    elseif n == 3 return Q_3_matrix()
    end
    S=skew_symmetric_matrix(n,maxint=maxint, with_zeros=with_zeros)
    inv(S-(1//1)I(size(S,1))) * (S+1I(size(S,1)))
end
# ------------------------------------------------------------------------------
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
function sparse_W_matrix(n)
    A = sparse_Q_matrix(n)
    factor_out_denominator(A)
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------------- Orthogonality
# ------------------------------------------------------------------------------
function ca_projection_matrix(A)
    A*inv(A'A)*A'
end
# ------------------------------------------------------------------------------
function gen_qr_problem(even_n;maxint=3)
    hadamard(even_n)[:,shuffle(1:even_n)]*lower(even_n,maxint=maxint)'
end

function gen_qr_problem_3(;maxint=3)
    _,W = W_3_matrix(maxint=maxint)
    W*unit_lower(3, maxint=maxint)'
end

function gen_qr_problem_4(;maxint=3)
    _,W = W_4_matrix()
    W*unit_lower(4,maxint=maxint)'
end
# ------------------------------------------------------------------------------
# ---------------------------------------------------------------- Eigenproblems
# ------------------------------------------------------------------------------
function gen_eigenproblem( e_vals; maxint=3 )
    Λ = Diagonal( e_vals )
    S,S_inv = gen_inv_pb( size(e_vals,1), maxint=maxint )
    S,Λ,S_inv, S*Λ*S_inv
end
# ------------------------------------------------------------------------------
function gen_symmetric_eigenproblem( e_vals; maxint=3, with_zeros=false )
    S = Q_matrix( size(e_vals,1); maxint=maxint, with_zeros=with_zeros )
    Λ = Diagonal( e_vals )
    S, Λ, S * Λ * S'
end
# ------------------------------------------------------------------------------
function gen_non_diagonalizable_eigenproblem( e_dup, e; maxint=4 )
    # size 3x3 problem
    S,S_inv = gen_inv_pb(3, maxint=maxint )
    Λ = [e_dup 1 0; 0 e_dup 0; 0 0 e]
    S * Λ * S_inv
end
# ------------------------------------------------------------------------------
function gen_svd_problem(m,n,σ; maxint = 3)
    U  = sparse_Q_matrix( m, maxint=maxint)
    Vt = sparse_Q_matrix( n, maxint=maxint)
    m = sum(m); n=sum(n)
    Σ  = zeros(eltype(σ[1]), m,n)
    for i in 1:min( m, size(σ,1) )
        Σ[i,i] = σ[i]
    end
    U, Σ, Vt, U * Σ * Vt
end# ==============================================================================
