## 01_ScalarsVectorsMatrices.ipynb

### 1. Introduction
### 1.1 Scalars
### 1.2 Vectors and Matrices
### 2. Special Cases
### 2.1 Matrices With a Single Row or a Single Column
### 2.2 Zero Matrix, Identity Matrix
### 3. Geometrical Representation of Vectors
### 3.1 Arrows
### 3.2 Functions
### 4. Take Away

## 02_AddScalarMultDotprod.ipynb

### 1. Notation and Remarks
### 2. Equality, Addition and Scalar Multiplication
### 2.1 Equality
### 2.2 Addition
### 2.3 Scalar Multiplication
### 2.4 Subtraction
### 2.5 System of Equations Example
#### 2.5.1 Important Example
#### 2.5.2 Two <strong>Very Important</strong> Definitions
### 3. Properties
### 3.1 Algebraic Properties
### 3.2 Geometric Representation
#### 3.2.1 Vector Addition and Subtraction
#### 3.2.2 Linear Combinations of Vectors
### 4 Take Away

## 03_MatrixMultiplication.ipynb

### 1. The Operations
### 1.1 The Transpose
### 1.2 The Vector Dot Product
### 1.3 The Matrix Product
### 2. Special Cases
### 2.1 Inner and Outer Products
#### 2.1.1 Inner Product: Row Vector Times Column Vector
#### 2.1.2 Outer Product: Column Vector Times Row Vector
### 2.2 Matrix Times Column Vector, Row Vector Times Matrix
#### 2.2.1 Matrix Times Column Vector
#### 2.2.2 Row Vector Times Matrix
### 3. Submatrices
### 3.1 We can partition the $A$ and $C$ matrices horizontally
### 3.2 We can partition the $B$ and $C$ matrices vertically
### 3.3 We can partition the $A$ matrix vertically, and the $B$ matrix horizontally
### 3.4 We can partition further, horizontally and vertically...
### 3.5 Test Your Understanding
### 3.6 Notation Convention
### 4. Take Away

## 04_MatrixAlgebra.ipynb

### 1. Algebra
### 1.1 Preliminary Remarks: Addition and Scalar Multiplication
### 1.2 The Product $\mathbf{ A B }$
### 1.3 Properties of Matrix Multiplication
### 1.4 The Dot Product Compared to Matrix Multiplication
### 2. Examples
### 2.1 Products of More than 2 Matrices
### 2.2 Substitution is Matrix Multiplication
### 3. Take Away

## MatrixMultApplication_GraphTheory.ipynb

### 1. Graphs and Adjacency Matrices
### 1.1 Definitions
### 1.2 Multiplication by a Row Vector from the Left
#### 1.2.1 Pick a Row of A
#### 1.2.2 Sum two Rows of A
#### 1.2.3 Pick a Row and Multiply by $A$ Twice
### 1.3 Powers of A
### 2. Counting Triangles
### 3. Take Away

## 05_RowEchelonForm_Systems.ipynb

### 1. Systems of Linear Equations
### 1.1 Definition
### 1.2 Solutions of a System of Linear Equations
### 2. Solutions of Row Echelon Form Systems
### 2.1 Two Simple Examples
### 2.2 Systems that do NOT have an Equation for Each of the Variables
### 3. The Backsubstitution Algorithm
### 3.1 Definition
### 3.2 The Algorithm
### 4. Take Away

## 06_GE_Systems.ipynb

### 1. The Basic Idea
### 1.1 Examples
### 1.2 Elementary Operations
### 2. Intermediate Stage: Gaussian Elimination when Writing Equations
### 3. Gaussian Elimination in Matrix Form
### 3.1 Key Insight
### 3.2 The Elimination Matrix
### 3.3 A Complete Example
### 4. Take Away

## 07_GE_Systems.ipynb

### 1. Corner Cases for Gaussian Elimination
### 1.1 The Approach to Solving $A x = b$
### 1.2  Missing Pivots
#### 1.2.1 Subcase: There is an Equation with Current Leading Variable
#### 1.2.2 Subcase: There is No Equation with Current Leading Variable
#### 1.2.3 Special Case: Rows of Zeros
### 2. Example Computations
### 2.1 The GE Algorithm
### 2.2 Example: Redundant Equations
### 2.3 Example: Contradiction
### 2.4 Number of Equations, Unknowns and Solutions
### 3. Algorithm Variations
### 3.1 Partial Pivoting, Full Pivoting
### 3.2 Gauss-Jordan Elimination
### 4. Take Away

## PDE_example.ipynb

### 1. Numerical Approximation of Derivatives
### 1.1 First Derivative
### 1.2 Second Derivative
### 2. Example: Discretize the Poisson Equation
### 2.1 Discretize the Problem
### 2.2 Python Implementation
### 2.3 Solve the Resulting Problem

## 11_Inverses.ipynb

### 1. The Inverse of a Square Matrix
### 2. Left and Right Inverses
### 3. Take Away

## 12_LU_decomposition.ipynb

### 1. Basic Idea
### 1.1 Multiple Right-hand Sides
### 1.2 The LU Decomposition
#### 1.2.1 Computation of the LU Decomposition
#### 1.2.2 Use the LU Decomposition to Solve $\ $ A x = b
### 2. The PLU Decomposition
### 2.1 Required Row Exchange(s)
#### 2.1.1 Example
#### 2.1.2 Solving $\;$ P L U x = b
### 2.2 Variations
#### 2.2.1 The PLDU Decomposition
#### 2.2.2 Symmetric Matrices
### 3. Take Away

## LU.ipynb

### 1. Theory
#### 1.1 $\ $  A simple Example
#### 1.2 $\ $ An example with a larger matrix
### 2. PLU decomposition

## HillsCypher.ipynb

### 1. Hill's Cipher
### 1.1 Overview
### 1.2 Transform a Message into a Matrix
### 1.3 Encode the Message
### 1.4 Decode the Message
### 2. Avoiding the Computation of a Matrix Inverse

## CR_Decomposition.ipynb

### 1. Example
### 1.1 Reduction of a Matrix to Row Echelon Form: $\mathbf{ E A = R}$
### 1.2 The first rank(A) Columns of $\mathbf{E^{-1}}$ are the Pivot Columns of $\mathbf{A}$
### 1.3 An $\ \mathbf{ A = C R}\ $ Decomposition
### 2. Some Observations
### 2.1 A CR Decomposition Reveals Bases for the Column and Row Spaces of a Matrix
### 2.2 A CR Decomposition is Not Unique
### 2.3 A CMR Decomposition

## CholeskyDecomposition.ipynb

### 1. The Decomposition of Symmetric Matrices
### 1.1 The PLDU Decomposition
### 1.2 The $L D L^t$ Decomposition
### 2. The Cholesky Decomposition
### 2.1. The Decomposition
### 2.2 Computation of the Cholesky Decomposition

## CholeskyDecompositionExample.ipynb


## UpdateOfMatrixInverse.ipynb

### 1. The Sherman-Morrison-Woodbury Formula
### 1.1. Derivation
### 1.2. Application: Rank 1 Update of a Matrix Inverse
### 1.3. Application: Rank k Update of a Matrix Inverse
### 1.4. Application: Solve $B x = b$ by Solving a Simpler System
### 1.5 Application: Updating a Regression Solution
### 2. Other Useful Formulae

## GivensRotations.ipynb

### 1. Givens Rotation Algorithm
### 1.1 Small Example with Rationals
### 1.2 Floating Point Example
### 1.3 Remark: this is a QR Decomposition

## HouseholderReflections.ipynb

### 1. Reflection Onto an Elementary Basis Vector
### 1.1 The Line of Reflection
### 1.2 Householder Matrices
### 2. Householder Reflection Algorithm
### 2.1 Small Example with Rationals
### 2.2 Floating Point Example
### 2.3 Remark: this is a QR Decomposition

## 08_LinearIndependence.ipynb

### 1. Right Hand Sides $b$
### 2. Solutions of $A x\ =\ b$
### 2.1 The Number of Solutions
### 2.2 Particular and Homogeneous Solutions
### 2.3 Non-trivial Homogeneous Solutions
### 3. Linear Independence of Vectors
### 3.1 Definition and Theorem
### 3.2 Examples
#### 3.2.1 General Case
#### 3.2.2 Special Cases
### 4. Take Away

## LinearIndependence.ipynb

### 1. Linear Independence
### 1.1 Model $A x = b$ Problem
### 2. Checking Linear Independence of a set of vectors in $\mathbb{F}^{\small{N}}$
### 2.1 Easy case 1: The set of vectors contains the zero vector
### 2.2 Easy case 2: One of the vectors is recognized as a linear combination of the other vectors.
### 2.3 Easy case 3: More vectors than entries in a vector
### 2.4 Easy case 4: The vectors contain a triangular matrix
### 3: Linear Independence of Functions
### 3.1 Polynomials

## 15_VectorSpaces.ipynb

### 1. Linear Combinations of Vectors, Vector Spaces
### 1.1 Motivation
### 1.2 Definition
#### 1.2.1 Definition of a Vector Space
#### 1.2.2 Example of a Computation
### 1.3 Examples and Further Definitions and Theorems
#### 1.3.1 Vectors in $\mathbb{R}^N$
#### 1.3.1.1 The Vector Space $V = \{ 0 \}$
#### 1.3.1.2 Vectors in a Span of Vectors in $\mathbb{R}^3$ 
#### 1.3.2 Closed under Addition, Closed under Scalar Multiplication, Spans
#### 1.3.3 Vector Spaces of Matrices
#### 1.3.3.1 The Set of Matrices of the Same Size
#### 1.3.3.2 A Subset of a Set of Matrices of the Same Size 
#### 1.3.4 Vector Spaces of Functions
#### 1.3.4.1 The Vector Space of Functions $\mathscr{F}(-\infty,\infty)$
#### 1.3.4.2 The set of Polynomials $\mathscr{P}_2[-1,1]$
#### 1.3.5 Set Notation
### 2. Subspaces of a Vector Space
### 2.1. Definition, Subspace Test
### 2.2 Examples
#### 2.2.1 Vectors in $\mathbb{R}^N$
#### 2.2.1.1 A Span of Vectors
#### 2.2.1.2 A Set of Vectors that Do Not Contain the Zero Vector 
#### 2.2.1.3 A Set of Vectors that is Not a Span (i.e., k-plane)
#### 2.2.1.4 Another Set of Vectors that is Not a k-plane
#### 2.2.2 Matrices
#### 2.2.2.1 Invertible Matrices
#### 2.2.2.2 Projections
#### 2.2.3 Functions
#### 2.2.3.1 The subspace $\mathscr{C}^2(-1,1)$
#### 2.2.3.2 A Set of Functions that is Not a Subspace
### 3. Take Away

## 16_Basis.ipynb

### 1. Basis for a Vector Space
### 1.1 Motivating Example
#### 1.1.1 Row Echelon Form of $A$
#### 1.1.2 Linearly Independent Columns
#### 1.1.2.1 Removing linearly dependent columns
#### 1.1.2.2 Summary: the reduced system has a unique solution
### 1.2 Basis
#### 1.2.1 Definition of a Basis
#### 1.2.2 Constructing a Basis from a Given Set of Vectors
### 1.3 Basis and Dimension
#### 1.3.1 Definition of the Dimension of a Vector Space
#### 1.3.2 The Dimension of $\mathbb{R}^{N}$
#### 1.3.3 Example: The Dimension of a Subspace of $\mathbb{R}^3$
#### 1.3.4 The Dimension of a Subspace of the Vector Space of Functions
#### 1.3.5 Some Simple but Useful Theorems to Keep in Mind:
### 2. Subspaces Associated with a Matrix
### 2.1 Definitions
### 2.2 A Basis for $\mathscr{C}(A)$
### 2.3 A Basis for $\mathscr{R}(A)$
### 2.4 A Basis for $\mathscr{N}\ (A)$
### 2.5 A Basis for $\mathscr{N}\ (A^t)$
### 3. The Fundamental Theorem of Linear Algebra (Part 1)
### 3.1 The Theorem
### 3.2 Examples
#### 3.2.1 A matrix of size $1 \times 3$ 
#### 3.2.2 A matrix of size $3 \times 3$ 
#### 3.2.3 Dimensions of the Fundamental Spaces for a Matrix of Size $4 \times 9$
### 4. Take Away

## CoordinateSystems.ipynb

### 1. Substituting Linear Expressions: Matrix Multiplication
### 1.1 A Simple Example
### 1.2. The General Case
### 2. The Column View of A x = b
### 2.1 Decompose a Vector
### 2.2 Example Computation
### 2.3 Conclusion
### 3. Changing Coordinate Systems
### 3.1 Just another Coordinate System
### 3.2 Relation between Coordinate Vectors
### 4. Suggestion

## SimilarityTransform.ipynb

### 1. Change of Coordinates: Decomposition of a Vector
### 2. Similarity Transforms
### 2.1 Linear Transforms and Coordinate Systems
### 2.2 Example: a 3D Rotation
### 3. Generalization of the Similarity Transform
### 3.1 Example
### 4. Take Away

## CxFundamentalTheorem.ipynb

### 1. The Complex Inner Product Requires a Complex Conjugate
### 2. Code
### 3. Example

## ThreeBasesExample.ipynb

### 1. Data
### 2. Columns of the Identity Matrix
### 3. Fourier Basis (Sines and Cosines)
### 4. Haar Wavelet Basis
### 5. Take Away

## FourierMatrix.ipynb

### 1. The Discrete Fourier Basis
### 2. Example: Sines Sampled at N=256 Values
### 2.1 Example 1: A Sine Function
### 2.2 Example 2: Sine and a Cosine, Different Frequencies
### 3. A Function of Time
### 3.1 Sample a Function $x(t)$
### 3.2 Removing Some Fourier Coefficients
### 4. Generalization to Higher Dimensional Spaces
### 5. Take Away

## LightsOut.ipynb

### 1. Modeling the Puzzle
### 1.1 Use Modulo Two Arithmetic
### 1.2 List of Possible Activations
### 1.3 Implementing the Activation
### 2. Puzzle Solution
### 2.1 Formulate the Solution
### 2.2 Implement a GE Solver for Modulo 2 Aritmetic
### 2.3 Solve the Puzzle
### 3. Solvability an Uniqueness of Solutions
### 3.1 Fundamental Subspaces of $\mathbf{\mathbb{Z}_2^{m \times n}}$
#### 3.1.1 Example
### 3.2 Solvability and Uniqueness
### 4. Enhancement Ideas

## 09_LinearTransformations.ipynb

### 1. Introduction
### 1.1 Functions Transforming Vectors to Vectors
### 1.2 Geometric Representations
### 1.3 Basic Concepts
### 1.4 Special Case: Linear Transformations
### 2. Useful Theorems
### 2.1 A Linear Transformation Distributes over a Linear Combination
### 2.2 A Linear Transformation from $\mathbb{F}^N \rightarrow \mathbb{F}^M$ Can be Represented by a Matrix
### 2.3 The Composition of Linear Transformations is a Linear Transformation
### 2.4 One-to-one Transformations and Onto Transformations
### 2.5 The Mapping of the 0 Vector
### 3. Checking Whether a Transformation is Linear
### 3.1 The Test
### 3.2 Examples ( Scalars in $\mathbb{R}$ )
#### 3.2.1 A Linear Transformation
#### 3.2.2 A Non-linear Transformation
#### 3.2.3 The Equation for a Line
### 4. Take Away

## 10a_LinearTx_Examples.ipynb

### 1. Review: Basic Definitions and Theorems
### 1.1 Definition
### 1.2 One-to-One and ONTO Transformations
### 1.3 Composition of Linear Transformations
### 2. Matrix Representation of a Linear Transformation
### 2.1 Tools: Polar Coordinates and Congruent Triangles
### 2.2 Dilation
### 2.3 A rotation in 2D
### 2.4 Reflection With Respect To a Line
### 2.5 Orthogonal Projection Onto a Line
### 2.6 Combine Linear Transformations
### 2.7 Implementation with Geogebra
### 3. Combining Translations and Linear Transformations
### 3.1 Direct Computation
### 3.2 Homogeneous Coordinates
### 4. Take Away

## 10b_LinearTx_SpaceOfFunctions_Examples.ipynb

### 1. Application: A Matrix Representation for a Linear Transformation $T: U \rightarrow V$
### 2. Finite Dimensional Vector Spaces Can be Represented by $\mathbb{F}^N$
### 3. A Linear Transformation $T:U\rightarrow V$ Represented by $y = A x$
### 3.1 The Method
### 3.2 Example
#### 3.2.1 Verify $T$ is a linear Transformation From a Vector Space to a Vector Space
#### 3.2.2 Choose Bases and Coordinate Vector Transforms
#### 3.2.3 Obtain the Matrix Representation
#### 3.2.4 Using the Matrix for Computations
#### 3.2.5 Implementation Using SymPy
### 4. Take Away

## 10c_GeoGebra.ipynb

### 1. General Information
### 2. Explore: Run the Next Three Cells
### 3. Specify a Matrix Directly

## 10d_LinearTx_Examples.ipynb

### 1. Coordinate Vector, Change of Coordinates
### 1.1 $\mathbb{R}^2 \longrightarrow \mathbb{R}^2$ Example
### 1.2 $\mathscr{P}_2\left[ -1,1\right] \longrightarrow \mathbb{R}^3$ Example
### 2. Linear Transformations Can be Combined, Resulting in Linear Transformations
### 2.1 Let's Combine Two Linear Transformations
#### 2.1.1 Two Linear Transformations from $\mathbf{\mathbb{R}^n}$ to $\mathbf{\mathbb{R}^m}$
#### 2.1.2 Polynomials, Coordinate Vectors and Linear Transforms
### 2.2 Combine these Ideas
### 2.3 Conclusion

## NonLinearTransformations.ipynb

### 1. Effect of Linear and NonLinear Transformations
### 1.1 Random Linear Transform
### 1.2 Non-linear Transform of the Data
### 2. Suggestion

## Projections.ipynb

### 1. Dual Basis
### 2. Oblique Projections
### 3. Orthogonal Projections
### 4. Diagonalizable Matrices
### 5. Application Examples
### 5.2 A Projection Problem (Spring 14)

## 20_LengthOrthogonality.ipynb

### 1. Adding Vector Length to Vector Spaces
### 1.1 Basic Definitions
### 1.2 Inequalities, Angle, Orthogonal Vectors
### 2. Fundamental Theorem of Linear Algebra (Part 2)
### 2.1 Main Definitions and Theorem
#### 2.1.1 Linear Independence of Orthogonal Vectors
#### 2.1.2 Mutually Orthogonal Vectors
#### 2.1.3 Orthogonal Spaces
### 2.2 Use the Fundamental Theorem to Decompose a Vector (Naive Method)
### 2.3 Use the Fundamental Theorem to Decompose a Vector (Refinement)
#### 2.3.1 Key Observation 1: Decomposing a Vector into Orthogonal Components
#### 2.3.2 Key Observation 2: No Need to Identify the Column Space of $A$ and the Null Space of $A^t$
#### 2.3.3 The Final Touch: Rewrite the Equations in Matrix Form
### 3. The Normal Equation
### 3.1 Basic Properties of the Normal Equation
#### 3.1.1 The Normal Equation
#### 3.1.2 The Equivalent Minimization Problem
#### 3.1.3 Example: Projection Onto a k-plane
### 3.2 Special Case: Projection onto a Line
### 3.3 Special Case: the Columns of $A$ are Mutually Orthogonal
### 4. Take Away
### 4.1 The Fundamental Theorem of Linear Algebra 
### 4.2 The Normal Equation

## 21_ProjectionsGramSchmidt.ipynb

### 1. The Normal Equation (Reminder)
### 2. Orthogonal Projection Matrices
### 2.1 Theory
### 2.2 Example: Orthogonal Projection onto a Span of 3 Vectors
### 2.3 Example: Orthogonal Projection onto a Line
### 2.4 Projection onto an Orthogonal Basis
### 3. Orthonormal Bases
### 3.1 Example
### 3.2 Orthogonal Matrices
### 3.3 (Extra Material) A Naive Construction Method for Orthogonal Matrices
#### 3.1.3 Two Important Examples
### 3.4 Gramm-Schmidt Orthogonalization
### 4. Take Away
### 4.1 Projection Matrices
### 4.2 The Gram Schmidt Procedure

## 21a_LinearTx_NormalEquations.ipynb

### 1. A Plane through the Origin
### 1.1 Orthogonal Projection Onto a Plane $n \cdot x = 0$ and Onto a Normal to the Plane
### 1.2 The Mirror Image of a Point With Respect to the Plane $n \cdot x = 0$
### 2. A Plane Not Containing the Origin
### 2.1 Orthogonal Projection and Reflection Through a Plane $n \cdot x = b$

## MeanAndStdProjections.ipynb

### 1. Mean and Deviation from the Mean
### 1.1 The Mean of a Set of Samples
### 1.2 The Deviation from the Mean
### 2 Sandard Deviation, Covariance and Correlation
### 2.1 Standard Deviation
### 2.2 Covariance and Correlation
### 2.3 Covariance and Correlation Matrices

## LeastMeanSquares.ipynb

### 1. Perform an experiment
### 2. Conjecture a linear model
### 2.1 Solve the resulting Normal Equations
#### 2.1.1 Compute and solve the normal equation:
#### 2.1.2 Compute the projections
### 3. Conjecture a cubic model
### 4. Overfitting and Ringing
### 5. Exercises

## Regression.ipynb

### 1. Create some data
### 1.1 Pandas DataFrame
### 1.2 Take a look at the data
### 2. Let's fit some model
### 2.1 Let's try a line:  y = a + b x
#### 2.1.1 Solve the normal equation for $x$
### 2.2 Model y =a + b x + c x^2 + d sin(.1x)
### 2.3 Model y =a + b x + c x^2 + d x^3 +e x^4 + f x^5

## Orthogonal_Decomposition_Example.ipynb

### 1. Drawing Routines
### 2. The Normal Equation and the Decomposition of Vectors (3D Example)
### 2.1  Plane Defined from Basis Vectors together with a Third Vector
### 2.2 A x = b with More than One Solution
##### 2.2.1 Implementation
##### 2.2.2 Display
### 2.3 Reduced Problem

## 22_QR_Decomposition.ipynb

### 1. Gram-Schmidt and the QR Decomposition
### 1.1 Reformulate Gram-Schmidt: $\mathbf{A = Q R}$
### 1.2 Computation of $A = Q R$
#### 1.2.1 Naive Method
#### 1.2.2 Refinement of the Method
#### 1.2.3 Alternate Methods
### 2. QR and the Normal Equation
### 2.1 Multiplication by $W^t$ rather than $A^t$
### 2.1 Example
### 3. Take Away

## 23_MetricSpaces.ipynb

### 1. Inner Products
### 1.1 Inner Products and Metrics in $\mathbb{R}^n$
### 1.2  Inner Products in Function Spaces
### 2. Orthogonality
### 3. Gram Schmidt

## Orthogonality.ipynb

### 1. Inner Product Spaces and Metrics
### 1.1 Basic Definitions
### 1.2 Inequalities, Angle, Orthogonal Vectors
### 1.3 Fundamental Theorem of Linear Algebra (Part 2)
#### 1.3.1 Main Definitions and Theorem
#### 1.3.1.1 Linear Independence of Orthogonal Vectors
#### 1.3.1.2 Orthogonal Spaces
#### 1.3.2 Use the Fundamental Theorem to Decompose a Vector (Naive Method)
#### 1.3.3 Use the Normal Equation to Decompose a Vector
### 2. The Normal Equation
### 2.1 Basic Properties of the Normal Equation
### 2.2 Examples
#### 2.2.1 Split a Vector
#### 2.2.2 Distance of a vector from a k-plane
#### 2.2.3 Special Case: the columns of $A$ are mutually orthogonal
### 3. Projection Matrices, Orthogonal Matrices and Unitary Matrices
### 3.1 Orthogonal Projection Matrices
#### 3.1.1 Theory
#### 3.1.2 Examples
### 3.2 Orthogonal Matrices and Unitary Matrices
#### 3.2.1 Definition and Example
#### 3.2.2 Important Examples
#### 3.2.3 Important Properties of Orthogonal and Unitary Matrice

## QR_orthogonal_polynomials.ipynb

### 1. Gram Schmidt Procedure
### 2. Convert Power Series to Legendre Polynomials Expansion
### 3. Fit a Function

## 13_WedgeProduct.ipynb

### 1. The Wedge Product
### 1.1 Changing the Length of a Vector
### 1.2 Anticommutativity
### 1.3 Distributivity over Vector Addition
### 1.4 Generalization to More Vectors
#### 1.4.1 Blades
#### 1.4.2 Interchanging Vectors, Repeated Vectors
### 1.5 Example Computations
#### 1.5.1 Examples with 2 Vectors
#### 1.5.2 Example with 3 Vectors
#### 1.5.3 General Case with 3 Vectors
### 1.6 Hyper-volumes: the Determinant
### 2. The Determinant Via Laplace Expansion
### 2.1 Using the first Row
### 2.2 Using Different Rows or Columns
### 2.3 Some Easy Determinants
### 2.5 Bad News: Computation is Not Feasible
### 3. Take Away

## 14_Determinants.ipynb

### 1. Some Formulae
### 1.1 Laplace Expansion, Leibniz Formula
#### 1.1.1 Minors and Cofactors
#### 1.1.2 Leibniz Formula
### 1.2 Bilinearity
### 1.3 Scalar and Matrix Products
#### 1.3.1 Products of Matrices
#### 1.3.2 Theorems and Examples
### 2. The Determinant by Gaussian Elimination
### 2.1 A Practical Algorithm
### 2.2 Existence of the Inverse
### 3. Cramer's Rule, Formula for the Inverse of a Matrix
### 3.1 Solving $\textbf{A x = b}$ with the Wedge Product
#### 3.1.1 The Idea
#### 3.1.2 A $2 \times 2$ Example
#### 3.1.3 General Case
### 3.2 A Formula for the Inverse
### 4. Take Away

## 17_EigenAnalysis.ipynb

### 1.Special Directions for  $\;y\ =\ A\ x$ 
### 1.1 Introduction
#### 1.1.1 Examples
### 1.2 The Eigenvector Eigenvalue Problem
#### 1.2.1 Definition
#### 1.2.2 Checking Potential Eigenvectors
### 2. Solution of $A\ x\ =\ \lambda\ x$
### 2.1 The Characteristic Polynomial
#### 2.1.1 Rewrite the Equation into a Familiar Form
#### 2.1.2 The Solution of the Eigenproblem
#### 2.1.3 Properties of Polynomials
#### 2.1.4 Trace and Determinant
### 2.2 Eigenvector/Eigenvalue Computation Examples
#### 2.2.1 A Simple $2\times 2$ Example
#### 2.2.2 A $3 \times 3$ Example
### 3. Take Away

## 18_EigenComputations.ipynb

### 1. Stochastic Matrices
### 2. Null Space Computations
### 3. Matrices of Size $2 \times 2$
### 4. Matrices of Size $3 \times 3$ with a Known Non-zero Eigenvalue
### 5. Determinants that Can be Factored

## 19_Diagonalization.ipynb

### 1. The Similarity Transform
### 1.1 Change of Basis
### 1.2 Similarity Transform
#### 1.2.1 Definition
#### 1.2.2 Similar Matrices and Eigenpairs
### 1.3 Special Case: A Basis of Eigenvectors
#### 1.3.1 A $2 \times 2$ Example
#### 1.3.2 **Should we have predicted this?**
#### 1.3.2.1 **Linearly Independent Basis of Eigenvectors**
#### 1.3.2.2 **The Matrix $A$ Expressed in the Eigenvector Basis is Diagonal**
### 2. Diagonalization
### 2.1 Basic Theory
#### 2.1.1 Diagonalizable Matrices
#### 2.1.2 Non-Diagonalizable Matrices
### 2.2 Special Cases
#### 2.2.1 Complex Eigenvalues
#### 2.2.2 When is a Matrix Diagonalizable?
#### 2.2.2.1 Existence: No Repeated Eigenvalues
#### 2.2.2.2 Existence: Symmetric Matrices
#### 2.2.2.3 Existence: Normal Matrices
### 3. Applications
### 3.1 Powers of a Diagonalizable Matrix
### 3.2 Functions of a Matrix
### 4. Take Away

## DifferenceEquations.ipynb

### 1. Code: Display Trajectories
### 1.1 Output Formating
### 1.2 Create Random 2x2 Matrix with Given Eigenvectors
### 1.3 Iteration Scheme
### 1.4 Examples
#### 1.4.1 Simple Trajectory Plot
#### 1.4.2 Graphics Monitor Class
### 2. Difference Equations: Iterations of a Linear Map
### 2.1 Definition
### 2.2 Solution
### 2.3 Behavior of the Solution as $n \rightarrow \infty$
#### 2.3.1 Real Eigenvalues
#### 2.3.2 Complex Eigenvalues

## MarkovChains.ipynb

### 1. CODE
### 1.1 Create Random 2x2 Matrices with Given Eigenvalues
### 1.2 PhasePortrait
### 1.3 Pretty Print A Matrix
### 2. Stochastic Matrix
### 2.1 Definitions
### 2.2 The Evolution of the Probability Vector
### 2.3 Phase Curves and Phase Portraits
### 2.4 Eigenvalues and Eigenvectors of Positive Stochastic Matrices
### 3. Take Away

## ComplexEigenProblems.ipynb

### 1. Complex Numbers
### 1.1 Definition and Basic Operations
#### 1.1.1 **Examples:**
#### 1.1.2 **Operations** using complex numbers are defined as follows
#### 1.1.3 **First Geometric Interpretation**
### 1.2 Polar Representation, Euler's Formula
#### 1.2.1 **Polar Representation**
#### 1.2.2 **Euler's Formula and Complex Multiplication**
#### 1.2.3 Geometric Interpretation of Multiplication by $e^{i \phi}$
#### 1.2.4 **Composition of Rotation and Scaling Matrices**
### 1.3 Vectors With Complex Entries
### 1.4 Takeaway
### 2 Complex Eigendecompositions
### 2.2 A Larger Example

## CirculantMatrices.ipynb

### 1. Non-cyclic (Linear) and Cyclic Convolution
### 1.1 Linear (non-cyclic) Convolution
#### 1.1.1 Definition
#### 1.1.2 Examples
#### 1.1.3 Matrix representation
### 1.2 Cyclic or Circular Convolution
#### 1.2.1 Definition
#### 1.2.2 Examples
#### 1.2.3 Matrix Representation
### 2. Circulant Matrices
### 2.1 Definition and Basic Properties
#### 2.1.1 Definition
#### 2.1.2 The Subspace of Circulant Matrices of Fixed Size
#### 2.1.3 Eigenvalues and Eigenvectors
### 3. Example: A System of Masses Connected by Strings
### 3.1 Masses Confined to a Circle
### 3.2 Physical Interpretation: Natural Modes of Oscillation
### 3.3 Animation of the 2nd Vibration Mode

## GreshgorinCircles.ipynb

### 1. Basic Definitions and Theorems
### 1.1 Greshgorin Disks
### 1.2 Greshgorin Circle Theorem
### 1.3 Strengthening the Theorem

## HamiltonCayley.ipynb

### 1. The Hamilton Cayley Theorem and the Inverse of a Matrix
### 1.1 Preliminary: Matrix Polynomials
### 1.2 Example
### 1.3 The Cayley Hamilton Theorem
### 1.4 Application: a Formula for the Inverse
#### 1.4.1 General 2x2 matrix
#### 1.4.2 Continuation of the 3x3 Example

## RayleighQuotients.ipynb

### 1. The Normalized Quadratic Form
### 1.1 Power Iteration
### 1.2. The Reduced SVD $\mathbf{A = U_r \Sigma_r V_r^t}$
### 2. Rayleigh Quotient Definition and Theorem
### 2.1 Definition
### 2.2. A 2x2 Example, Symmetric Matrix
### 2.3. A 2x2 Example, Non-Symmetric Matrix
### 2.4 A 3x3 Example
### 3. Minimax Theorem

## 24_SpectralTheorem.ipynb

### 1. The Spectral Theorem
### 1.1 Introduction
### 1.2 Normal Matrices
### 1.3 A New Level in the Summary Table
### 2 Example Computations
### 2.1 Example 1
### 2.2 Example 2
### 3. Take Away

## 25_PositiveDefiniteMatrices.ipynb

### 1. Quadratic Forms
### 1.1 Definition
### 1.2 Two Problems: Cross Sections and Extrema
#### 1.2.1 **The Extremum Problem**
#### 1.2.2 **The Cross Section Problem**
### 1.3. Matrix Formulation
#### 1.3.1 Example With 2 Variables
#### 1.3.2 General Case
### 2. Orthogonal Decomposition of a Quadratic Form 
### 2.1 Theory
### 2.2 Examples
#### 2.2.1. **Example**
#### 2.2.2 Example
#### 2.2.3 Example
#### 2.2.4 Example
### 2.3 Signs of the Eigenvalues are Important
### 2.4 Sylvesters Law of Inertia
### 3. Tests for Positive Definite Matrices
### 3.1 Principal Minors of a Matrix
### 3.2 Positive Definite Matrix Tests
#### 3.2.1 Example 1
#### 3.2.2 Example 2
#### 3.2.3 Example 3
### 4. Take Away

## 25a_QuadricSurfaceDisplay.ipynb


## PositiveDefiniteTests.ipynb

### 1. Sylvester's Law of Inertia
### 2. GE for Symmetric Matrices
### 2.1. Case: No Row Exchange Required
### 2.2 Case: Row Exchanges Required
#### 2.2.1  Subcase: Require Row Exchange, Pivot Exists
### 2.3 Case: Row Exchange Required, Missing Pivots 
### 3. Take Away

## FunctionsOfAMatrix.ipynb

### 1 Eigendecomposition
### 2. Powers of $A$
### 2.1 Integer Power of $A$
### 2.2 Non-negative Power of $A$
### 3. Functions of $A$
### 4. Application: Difference Equations
### 5. Application: Linear System of ODEs

## FunctionsOfAMatrixExamples.ipynb

### 1. Functions of a Matrix
### 1.1 Compute $\sin(A t)$ (6pt)
### 1.2 Compute $e^{A t}$ and multipy out all matrices. (2pts)
### 1.3 What is $\lim_{t\rightarrow \infty}{e^{A t}}$ (2pts)
### 2. Difference Equation
### 2.1 How are the eigendecompositions of $A$ and $B$ related? Justify your answer (2pts)
### 2.1 Solution of a Difference Equation (6pts)
### 2.2 What is $\lim_{n\rightarrow \infty}{y_n}$ (2pts)

## JordanForm.ipynb

### 1. Jordan Form of a Matrix
### 1.1 Definitions and Theorem
### 1.2 Example
### 2. Naive Computation of a Jordan Form
### 2.1 Jordan Chains
### 2.2 Naive Computation Example
### 3. Computation of a Jordan Form
### 3.1 Point Diagram and its Properties
#### 3.1.1 The Diagram
#### 3.1.2 Nested Null Spaces
#### 3.1.3 The Algorithm
### 3.2 Computation of a Jordan Form Example
#### 3.2.1  Step 1: Compute the Eigenvalues of A and their Algebraic Multiplicities
#### 3.2.2 Step 2: Compute the Row Echelon Forms $\mathbf{(A-\lambda I)^k}$
#### 3.2.3 Step 3: Compute the Nested Set of Basis Vectors
#### 3.2.4 Step 4: Assemble the matrices
### 4. Take Away

## FunctionsOfADegenerateMatrix.ipynb

### 1. Introduction
### 2. Jordan Blocks, Matrix Powers and Functions of Matrices
### 2.1 Definition
### 2.2 Integer Powers of Degenerate Matrices
#### 2.2.1 Powers of $N_n$
#### 2.2.2 Powers of $J_n(\lambda)$
#### 2.2.3 General Case
### 2.3 Arbitrary Powers of Degenerate Matrices
### 2.4 Functions of Degenerate Matrices
#### 2.4.1 Definition Via  Series Expansions
#### 2.4.2 Example: Exponential of a Degenerate Matrix
#### 2.4.3 Example: Logarithm of a Degenerate Matrix
### 3. Special Case: Projection Matrices
### 3.1 Definition
### 3.2 Powers of Projection Matrices
### 3.3 Functions of Projection Matrices
### 4. Special Case: Nilpotent Matrices
### 4.1 Definition and Examples
### 4.2 Eigenvalues and Eigenvectors
#### 4.2.1 Eigenvalues
#### 4.2.2 Eigenvectors of Nilpotent Matrices, Jordan Form
### 4.3 Powers of a Nilpotent Matrix
#### 4.3.1 Integer Powers of a Nilpotent Matrix
#### 4.3.2 Generalization to Fractional Powers
### 5. Take Away

## Schur_Decomposition.ipynb

### 1. Introduction
### 1.1 Schur's Lemma
### 1.2 A Constructive Proof
#### 1.2.1 Use an Eigenvector to Introduce Zeros in the First Column
#### 1.2.2 Repeat with $\tilde{A}$
### 1.3 Eigenvalues and Eigenvectors
### 2. The QR Algorithm
### 2.1 Simplest Form of the Algorithm
### 2.2 Improvement: Begin by Reducing the Matrix to Hessenberg Form <a id=\qr-hessenberg-form\></a>
#### 2.2.1 The Hessenberg Form
#### 2.2.2 Numerical Experiment
### 2.3 Improvement: The QR Algorithm with Shifts
### 3. Take Away
### 3.1 Key Insights
### 3.2 Why Schur Decomposition?
### 3.3 Applications

## 26_GramMatrix.ipynb

### 1. The Gram Matrix $A^t A$
### 1.1 Rank and the Dimension of the Null Spaces
### 1.2 Dimension of the Eigenspaces for $\lambda = 0$
### 1.3 Relationship of Eigenpairs for $A^t A$ and $A A^t$ for Non-zero Eigenvalues
### 1.4 Orthogonality of Eigenvectors
### 1.5 Eigenvalues Cannot be Negative
### 1.6 Eigenvector Lengths
### 2. Symmetric Eigendecomposition of $A^t A$ and $A A^t$
### 3. Take Away

## 27_SVD.ipynb

### 1. Motivation
### 1.1 Generalize the Idea of an Eigendecomposition
### 1.2 Is this Feasible?
### 1.3 The Reduced Singular Value Decomposition
### 2. The Singular Value Decomposition  (SVD)
### 2.1 SVD Existence Theorem
### 2.2 SVD Computation
### 3. Interpretation: the Action of $y = A x$
### 3.1 Change of Coordinate Systems and Scaling
### 3.2 Stretching a Sphere
### 4. Take Away

## 28_PseudoInverse.ipynb

### 1. The Pseudoinverse
### 1.1. A Preimage of $y = A x$
### 1.2 The Pseudoinverse and the Reduced Pseudoinverse
### 1.3 **Projection Matrices**
### 2. Application to the Normal Equation
### 3. Take Away

## 29_SVDapplications.ipynb

### 1. The Eckart-Young Theorem
### 2. Low Rank Approximation of an Image
### 3. Principal Component Analysis
### 4. Some Web Resources

## 30_VectorAndMatrixNorms.ipynb

### 1. Introduction
### 2. Vector Norms
### 3. Matrix Norms
### 3.1 Entrywise Vector Norm: $\lVert vec(A) \rVert_{_{_p}}$
### 3.2 Schatten Norm: Vector Norm of the Singular Value $\Sigma$ matrix
### 3.3 Induced Vector Norms
#### 3.3.1 Norms induced by $l^{^p}$
### 3.4 Submultiplicative Norms and the Spectral Radius
### 3.4. Example
### 4. Takeaway

## PCA_and_SVD.ipynb

### 1. Introduction
### 1.1 Summary
### 1.2 Problem Statement
### 2. A Small 2D Example
### 3. Singular Vectors $V_r$ and Singular Values  $\Sigma$
### 4. Error Concentration Ellipses
### 5. Least Squares versus Total Least Squares
### 6. Dimensionality Reduction
### 7. A Larger Example

## SVD_RemoveForeground.ipynb

### 1. Utility Functions and Data Sets
### 1.1 Display Images, Convert to and from Matrix of Vectorized Images
### 1.2 Load a Sequence of Image Frames
### 2. Process the Data
### 2.1 A sequence of Images
### 2.2 The SVD of the Data Matrix
### 2.3 Reconstruction of the Frames

## Eigenfaces.ipynb

### 1. A Database of Faces
### 1.1 Useful Functions
### 2 PCA of the Face Features
### 2.1 The Mean Face: an Average of All the Faces
### 2.2 The PCA Features
### 2.3 Dimensionality Reduction
### 3. Facial Recognition

## ConditionNumber.ipynb

### 1. Some Comments and Definition
### 2 Examples
### 3. Take Away

## rSVDintroduction_python.ipynb

### 1. Images and Display of Images
### 1.1 Routines to display Images
### 1.2 Arrays as Images
### 1.3 Color Images are Arrays
### 2. SVD Compression
### 3. Sampling The Column Space
### 3.1 Random Vectors Tend to be Orthogonal
### 3.2 Sampling Linear Combinations of the Columns
### 3.3 Idea: An approximate SVD of the Image

## rSVDintroduction_julia.ipynb

### 1. Images are Matrices
### 1.1 Display a Matrix
### 1.2 A Color Image
### 2. Approximate the Column Space $\mathscr{C}(A)$
### 2.1 Random Vectors Tend to be Orthogonal
### 2.2 Random Samples of the Column Space
### 3. Matrix Factorizations
### 4. Randomized SVD
### 4.1 Randomized SVD
### 4.2 Randomized SVD with Power

## rSVD.ipynb

### 1. Get Data
### 2. Approximating a Matrix A
### 2. Randomized SVD

## IterativeMethods_julia.ipynb

### 1. Jacobi Method
### 2. Gauss Seidel
### 3. Successive Overrelaxation (SOR)

## IterativeMethods_python.ipynb

### 1. Code: Monitor the Evolution of an Iterative Scheme
### 2. Iterative Solutions of $\mathbf{A x = b}$
### 2.1 Idea: Set up a Fixed Point
### 2.2 Convergence
### 2.3 Jacobi Iteration
#### 2.3.1 2D Example
#### 3D Example
### 2.4 Gauss Seidel Iteration (GS)
### 2.5 Successive Overrelaxation (SOR)
### 3. Iterative Methods for $\mathbf{A x = \lambda x}$
### 3.1 Power Method
### 3.2 Inverse Power Method

## KrylovMethods.ipynb

### 1. GhatGPT Description
### 2. Definition and Basic Properties
### 3. Minimal Polynomial
### 3.1 Different Eigenvalues
### 3.2 Repeated Eigenvalues, Diagonalizable
### 3.3 Repeated Eigenvalues, non-diagonalizable
### 3.4 Other Problems

## MatrixDerivatives.ipynb

### 1. Introduction 
### 1.1 Einstein Summation Convention
### 1.2 Derivatives
#### 1.2.1 Vector by Scalar Derivative
#### 1.2.2  Scalar by Vector Derivative
#### 1.2.3  Vector by Vector Derivative
#### 1.2.3  Matrix by Scalar Derivative
#### 1.2.4  Scalar by Matrix Derivative
#### 1.2.5 The Differential of a Matrix
#### 1.2.6 Example
#### 1.2.7 Vector by Matrix, Matrix by Matrix, etc..
### 2. Basic Formulae
### 2.1 Sums and Products
### 2.2 The Chain Rule
#### 2.2.1 Functions ${g: \mathbb{R}^n \rightarrow \mathbb{R}^m}$
#### 2.2.2 Functions $g: \mathbb{R}^{m \times n} \rightarrow \mathbb{R}^{k \times l}$
### 2.3 Some Common Derivatives
### 2.4 Differentials
### 3. Examples
### 3.1. Neural Network Weight Updates
### 3.2 Least Mean Squares Objective Function
### 3.3 The Rayleigh Quotient

## GradientDescent.ipynb

### 1. Find a Minimum
### 1.1 The Idea of the Gradient Descent Algorithm
### 1.2 Two Scalar Function Examples
### 1.3 What about the Cusp Function?
### 1.4 Convex Functions
### 2. Least Mean Squares Example

## GradientDescentExample.ipynb

### 1. Objective Function
### 2. Gradient Descent
### 3. Improved Algorithm
### 3.1. Exact Line Search
### 3.2. Accelerated Descent: Momentum

## GMRES.ipynb

### 1. Solving $\mathbf{A x = b}$ as an Optimization Problem
### 1.1 Idea
### 1.2 Derivation of the Algorithm
### 2. Basic Implementation and Example

## KplanesPrincipalAngles.ipynb

### 1. Foundations: Orthogonal Projections in Practice
### 2. From Vectors to Vectors and Subspaces: Defining Angles
### 2.1 Angle Between Two Vectors
### 2.2 Angle between a Vector and a Subspace
### 3. Angles Between Subspaces
### 3.1 Principal Angles: Conceptual Introduction
### 3.2 Principal Angles Via Projections
#### 3.2.1 Properties of the Projection Product $P_u P_v$
#### 3.2.2 Example: a Simple 2D Case
#### 3.2.3 Action of the Linear Transformation $P_u P_v$
#### 3.2.4 The Symmetric Operator $P_v P_u P_v$
#### 3.2.5 Principal Angles and the SVD of $U^T V$
#### 3.2.6 Symmetry of Principal Angles
### 3.3 Computation of Principal Angles and Principal Vectors
#### 3.3.1 Example: Subspaces with a Shared and an Orthogonal Direction
#### 3.3.2 Example: Partial Overlap with Zero Singular Values
### 4. Take Away

## KplaneDistances.ipynb

### 1. Measuring Distance Between Subspaces
### 1.1 Introduction
### 1.2 Review: Principal Angles Between Subspaces
### 2. Principal Angles Induce Distance Metrics
### 2.1 Spectral Distance
### 2.2 Chordal Distance
### 2.3 Frobenius Distance
### 2.4 Projection Distance
### 2.5 Geodesic Distance
### 2.6 Summary
### 3. Small Examples and Visual Comparisons
### 3.1 Static Example: Two 2D Subspaces in $\mathbb{R}^3$
### 3.2 Distance Metrics: a 5D Example
### 4. Take Away

## KplaneDistanceComputations.ipynb

### 1. Review: Principal Angles Between Subspaces
### 2. Algorithmic Choices in Computing Principal Angles
### 2.1 Orthonormalization
#### 2.1.1 Option 1: QR Decomposition
#### 2.1.2 Option 2: SVD-Based Orthonormalization
#### 2.1.3 Numerical Rank and QR Pitfalls
### 2.2 Principal Angle Computation
### 2.4 Theoretical Behavior of a 2D Example
### 3. Application
### 4. Take Away

## GrassmannianIntro.ipynb

### 1. Introduction of the Grassmannian
### 1.1 Definition
### 1.2 Subspaces as Points
### 1.3 Dimension of the Grassmannian
### 2. Geometry on the Grassmannian
### 2.1. Geometric Structure of the Grassmannian
#### 2.1.1 Example 1: $\mathrm{Gr}(1, 2)$ — Lines through the origin
#### 2.1.2 Example 2: Measuring Change — Rotated Basis and Projection Deviations
### 2.2 Local Coordinates on the Grassmannian
### 2.3 Distance on the Grassmannian
#### 2.3.1 From Local Variation to Distance
#### 2.3.2 Geodesics: The Shortest Path Between Subspaces
#### 2.3.3 Why This is a Geodesic
#### 2.3.4 Example Subspace Evolution in $Gr(2,4)$
### 3. Takeaways

## GrassmannianGeodesicsOptimization.ipynb

### 1. Motivation: Why Optimize on the Grassmannian?
### 2. Riemannian Optimization on $\mathrm{Gr}(k, n)$
### 2.1 Tangents and Gradients
#### 2.1.1 Tangent Space Matrix
#### 2.1.2 Projection onto the Tangent Space
#### 2.1.3  Why Use $n \times k$ Matrices to Represent Tangents and Gradients?
### 2.2 Geodesic Updates and Optimization
#### 2.2.1 Geodesic Updates from a Tangent Vector
#### 2.2.2 Example: Minimizing a Subspace Loss
### 3. Take Away

## GrassmannianApplications.ipynb

### 1. Introduction
### 1.1. Objective
### 1.2 Subspaces as Fundamental Representations
### 2. Subspace Extraction from Data
### 3. MIMO Beamforming: Optimal Subspace via Principal Angles
### 3.1 System Description
### 3.2 Beamforming as Optimization on the Grassmannian
### 3.3 Demo: Grassmannian Beamforming
### 4. Grassmannian Interpolation of Subspaces
### 5. Take Away

## BackPropagation.ipynb


## GEP_intro.ipynb

### 1. Generalized Eigenproblem and Matrix Pencils
### 1.1 Motivation
### 1.2 Definitions
### 1.3 Examples
#### 1.3.1 Regular Pencil Examples
#### 1.3.2 Singular Pencil Examples
#### 1.3.3 Application: Two-Mass Spring System Example
### 1.4 Variants of Matrix Pencils and the Generalized Eigenproblem
### 2. The Generalized Rayleigh Quotient
### 2.1 Definition
### 2.2 Connection to Eigenvalues
#### 2.2.1 Example ($A$ symmetric, $B$ positive definite)
#### 2.2.2 Example ($B$ singular)
### 2.3 Variational Characterization (Symmetric–definite Case)
### 3. Take Away

## GEP_computation.ipynb

### 1. Introduction
### 2. Symmetric-Definite Case
### 3. General Case
### 3.1 Matrices in Generalized Schur Form
### 3.2 The A = RQ and the A = QR Factorizations
#### 3.2.1 Householder Reflections
#### 3.2.2 $A = QR$ one Column at a Time, $A = RZ$ one Row at a Time
### 3.3 Reducing a Pencil to Hessenberg Triangular Form
#### 3.3.1 Hessenberg–Triangular Reduction
#### 3.3.2 QZ Iteration
### 3.4 Eigenvalue and Eigenvector Computation
#### 3.4.1 Eigenvalues
#### 3.4.2 Eigenvectors
### 3.5 Diagonalization
### 4. Detecting $\lambda=\infty$ in practice
### 5. Take Away

## GEP_examples.ipynb

### 1. Introduction
### 2. Case Study: RLC Circuit Analogue
### 2.1 Circuit Description
### 2.2 Visual Exploration
### 3.  Case Study: Canonical Correlation Analysis
### 3.1 Problem Description
### 3.2 Visual Exploration
### 4. Case Study: Lightly Constrained Robot Arm (Ill-Conditioned GEP)
### 4.1 Robot Arm Motion
### 4.2 System Characteristics and Plots
### 4.3 Practical Notes on Ill-Conditioned GEPs
### 5. Take Away

## GEP_RayleighQuotient.ipynb

### 1 Preliminaries and Notation
### 2. Variational Formulation
### 2.1 Normal Equation
### 2.2 Generalized Rayleigh Coefficient
### 3. Take Away

## GSVD_intro.ipynb

### 1. Introduction
### 2. GSVD Matrix Decomposition Examples
### 2.1 Shape and Structure of the Matrices
#### 2.1.1 Block Structure of C and S
#### 2.1.2 Bases of the Subspaces
### 2.2 Example Decompositions
### 2.3 Visualizing the GSVD Basis X
### 3.Take Away

## GSVD_computations.ipynb

### 1. Introduction

## A1_AnalyticGeometry.ipynb

### 1. Vectors
### 2. Formulae from Trigonometry
### 2.1 Euler's Formula
### 2.2 Formulae based on Euler's Formula and Complex Multiplication
### 3. Example
#### 3.1 Reflection With Respect To a Line
### 3.2 Orthogonal Projection Onto a Line
### 4. Take Away

## A2_Matrix_Layout_Displays.ipynb

### 0. Problems with Docker Images
### 1. Gaussian Elimination and Gauss Jordan Elimination Examples
### 1.1 Stack of Matrices
### 1.2 Decorating a Matrix
### 1.3 Gaussian Elimination Example
### 1.4 Lower Code Level
### 2. QR Examples
### 2.1 Sympy Format Example
### 2.2 Floating Point Format Example
### 3. Eigenproblem Tables
### 3.1 Basic Eigenproblem Table
### 3.2 Spectral Theorem Table
### 3.3 SVD Table

## A3_SymbolicVariables.ipynb

### 1. Setup
### 2. Symbolic variables
### 3. Matrix of Symbolic and Numeric Variables and Expressions
### 4. Substitutions and Solutions

## A5_DrawingVectorsAndPlanes.ipynb

### 1. Basic Drawing Routines
### 1.1 Implementation
### 1.2 Example
### 2. Fundamental Theorem Example

## A6_GenerateProblems.ipynb

### 1. GE Problems
### 1.1 GE and GJ Problem with Layout
### 1.2 GE with a Complex Matrix
### 1.3 Inverse Problem with Layout
### 1.4 PLU Problem
### 1.5 Julia Wrapper Class for ge()
### 2 Normal Equation Problems
### 2.1 Solve the Normal Equation
### 3. QR Problems
### 4. Eigenproblems
### 4.1 Eigenproblem for a Square Matrix
### 4.2 Eigenproblem for a Symmetrix Matrix
### 4.3 SVD

## A7_PythonWithJavascript.ipynb

### 1. Javascript Sends Array to Python
### 2. Python Sends Array to Two Javascript Loggers
### 3. Draw Moving Objects with P5.js
### 4. Geometrical Construction with JSXgraph

## A8_Julia_LaTeX_Utilities.ipynb

### 1. HTML Functions
### 2. LaTeX Rendering Function
### 2.1. Scalars
### 2.2. Strings and LaTeXStrings
### 2.3. Tuples and Sets
### 2.4. Vectors and Linear Combinations
### 2.5. Standard Matrices
### 2.6. Complex & Symbolic Matrices
### 2.7. Special Matrices in Julia
### 2.8. BlockArrays
### 2.9. Per Element Formatting
### 2.10. Combining Different Types
### 2.11. Inline vs Block LaTeX
### 2.12. Obtaining Raw LaTeX Representations


