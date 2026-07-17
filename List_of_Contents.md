<strong style="height:60px;color:darkred;font-size:40px;">

# 1. Scalars, Vectors, Matrices: Definitions and Operations
<details><summary><a href="01_ScalarsVectorsMatrices.ipynb" style="display:inline-block; width:9cm;">01_ScalarsVectorsMatrices.ipynb
</a>
Scalars, vectors, matrices; notation conventions; basic geometric interpretation
</summary>

### Contents

#### 1. Scalars
- Definition of a **scalar** as an element of a field (examples: real numbers, complex numbers).
- Use of scalars as coefficients in vector and matrix operations.

#### 2. Vectors
- Definition of **row** and **column** vectors.
- Standard coordinate notation.
- Emphasis on vectors as ordered lists with geometric interpretation in low dimensions.
- Examples of 2- and 3-dimensional vectors and coordinate plots.
- Distinction between geometric vectors and their coordinate representations.

#### 3. Matrices
- Definition of an **$m \times n$** matrix.
- Interpretation of matrices as:
  - arrays of scalars,
  - collections of row vectors,
  - collections of column vectors.
- Basic subscript notation $A_{ij}$.
- Examples of common shapes (square, tall, wide matrices).

#### 4. Special Matrices
- Identity matrix $I_n$.
- Zero matrix.
- Diagonal matrices.
- Elementary geometric meaning of diagonal scaling (stretching/compressing axes).

#### 5. Coordinate and Geometric Interpretation
- How vectors represent points in $\mathbb{R}^n$.
- Visualization of simple 2-D shapes defined by sets of vectors.
- Early motivation for seeing matrices as transformations (but *without* multiplying yet — that appears only in later notebooks).

### Examples
- Several explicit numeric examples of vectors and matrices.
- Simple geometric examples visualized through plotted points and segments.

____
</details>

<details><summary><a href="02_AddScalarMultDotprod.ipynb" style="display:inline-block; width:9cm;">02_AddScalarMultDotprod.ipynb</a>
Vector equality, addition, scalar multiplication; algebraic properties and geometric interpretation
</summary>

### Contents

#### 1. Basic Notation
- Vectors written as ordered $n$-tuples over a field $\mathbb{F}$.
- Coordinate indexing conventions $v = (v_1, \dots, v_n)$.
- Relationship between row and column representations.

#### 2. Vector Operations
##### Equality
- Two vectors are equal when all corresponding components coincide.

##### Addition
- Componentwise definition:  
  $(u+v)_i = u_i + v_i$.
- Examples illustrating entrywise addition.

##### Scalar Multiplication
- Definition:
  $(\alpha u)_i = \alpha\,u_i$.
- Interpretation as scaling of magnitude and reversal of direction for negative scalars.

##### Subtraction
- Defined via $u - v = u + (-1)v$.
- Geometric visualization of $u - v$ as a displacement vector.

#### 3. Systems of Linear Equations as Vector Equations
- A system of equations is rewritten as a linear combination of column vectors.
- Key example: recognizing that  
  $\qquad
  x_1 a^{(1)} + x_2 a^{(2)} + \cdots + x_n a^{(n)} = b
  $  
  encodes the same information as the original system.
- Emphasis on interpreting solutions as expressing $b$ as a linear combination of given vectors.

##### Important Example
- Detailed worked example showing how solution structure is revealed through vector form.
- Identification of pivot and free variables in the corresponding system formulation.

##### Two Very Important Definitions
- Explicit introduction of **linear combination**.
- Definition of the **span** of a set of vectors (introduced implicitly through examples, even if not yet formalized as a named theorem).

#### 4. Algebraic Properties of Vector Operations
- Commutativity and associativity of addition.
- Distributive laws involving vector addition and scalar multiplication.
- Existence and uniqueness of additive inverses.
- Zero vector as additive identity.
- Worked example verifying axioms with numerical vectors.

#### 5. Geometric Interpretation
##### Vector Addition and Subtraction
- Interpretation using the parallelogram rule.
- Visualization of direction and magnitude changes.

##### Linear Combinations in $\mathbb{R}^2$
- Examples showing sets of points of the form  
  $p = \alpha(1,2)$ (a line through the origin).
- Examples of two-parameter combinations  
  $p = \alpha(1,0) + \beta(1,4)$, illustrating a plane in parameter space and a line in $\mathbb{R}^2$.
- Introduction of geometric insight into spans and parameterizations, preparing for later formal definitions.

### Examples
- Several numeric examples of addition and scalar multiplication.
- Parametric descriptions of lines in $\mathbb{R}^2$.
- A full system-of-equations example demonstrating the vector-combination viewpoint.

### Applications and Motivation
- Viewing a linear system as a “vector construction problem”: does a combination of given vectors produce a target vector?
- Geometric interpretation of solutions: existence of a solution corresponds to a target vector lying in the span of the given vectors.

____
</details>

<details>
<summary>
<a href="03_MatrixMultiplication.ipynb" style="display:inline-block; width:9cm;">
03_MatrixMultiplication.ipynb
</a>
Transpose, dot product, matrix multiplication; inner/outer products; block multiplication
</summary>

### Contents

#### 1. Fundamental Operations

##### Transpose
- Definition of the transpose $A^T$ via $(A^T)_{ij} = A_{ji}$.
- Examples illustrating how rows become columns.

##### Vector Dot Product
- Dot product of two vectors $u, v \in \mathbb{F}^n$ defined by  
  $\qquad\displaystyle{  u \cdot v = \sum_{i=1}^n u_i v_i}$
- Interpretation as the (row)$\times$(column) multiplication of a $1 \times n$ and $n \times 1$ matrix.
- Computation examples and remarks on cancellation and sign.

##### Matrix Product
- Definition: if $A$ is $m \times n$ and $B$ is $n \times p$, then $C = AB$ is $m \times p$ where  
  $\qquad\displaystyle{ C_{ij} = \sum_{k=1}^n A_{ik}\,B_{kj}}$
- Computational viewpoint: each entry is a dot product of a row of $A$ with a column of $B$.
- Layout diagrams showing alignment of rows and columns.
- Examples illustrating shape rules, structure of intermediate sums, and correctness checks.

#### 2. Special Cases of Matrix Multiplication

##### Inner and Outer Products
- **Inner product**: row vector times column vector yields a scalar.  
  $\qquad (1 \times n)(n \times 1) \to (1 \times 1)$
- **Outer product**: column vector times row vector yields a rank-one matrix.  
  $\qquad (n \times 1)(1 \times n) \to (n \times n)$
- Examples showing how an outer product constructs a full matrix from two vectors.

##### Matrix–Vector Products
- **Matrix times column vector**:  
  $\qquad A x$ is a linear combination of the columns of $A$ with coefficients from $x$.
- **Row vector times matrix**:  
  $\qquad y^T A$ is a linear combination of the rows of $A$.
- Examples demonstrating computational differences and geometric intuition.

#### 3. Block and Submatrix Multiplication

The notebook develops matrix multiplication using **partitioned matrices**:

##### Horizontal and Vertical Partitioning
- Partitioning $A$ and $C$ horizontally, or $B$ and $C$ vertically, and verifying block multiplication identities.
- Examples where  
  $\qquad C = AB$  
  is computed block-by-block, each block being a sum of products of smaller blocks.

##### Mixed Partitioning
- Partitioning $A$ vertically and $B$ horizontally to produce a block form that mirrors the scalar formula.  
- Demonstrates that block multiplication is consistent with the standard entrywise definition.

##### Further Block Refinement
- Iterated horizontal and vertical partitioning to reveal structure in $AB$.
- **Important Example**: assembling a matrix product from several block components to highlight the associativity of grouping row/column blocks.

##### Notation Convention
- Use of submatrix notation $A_{I,J}$ for row- and column-index subsets.
- Clear statement of how block shapes must match for block multiplication to be valid.

#### 4. Examples
- Multiple worked examples of:
  - matrix-by-matrix multiplication,
  - matrix–vector multiplication,
  - row–matrix products,
  - inner and outer products,
  - block multiplication in several configurations.
- Examples include numerical matrices illustrating cancellation, zero entries, and non-square multiplication.

#### 5. Applications and Interpretation
- Recasting matrix multiplication as:
  - a sequence of dot products,
  - construction from outer products,
  - assembly of blocks that reflect structural features of $A$ and $B$.
- Conceptual link between block multiplication and algorithmic efficiency.

____
</details>

<details><summary><a href="04_MatrixAlgebra.ipynb" style="display:inline-block; width:9cm;">04_MatrixAlgebra.ipynb</a>
Matrix addition, scalar multiplication, matrix multiplication; powers; special matrices; algebraic properties
</summary>

### Contents

#### 1. Algebra of Matrices

##### 1.1 Addition and Scalar Multiplication
- Review of matrix addition and scalar multiplication as componentwise operations.
- Verification that these operations satisfy:
  - commutativity and associativity of addition,
  - distributive laws,
  - existence of the additive identity and additive inverse.

##### 1.2 Matrix Product $AB$
- Definition of $AB$ via row-by-column dot products.
- Emphasis that **matrix multiplication is not commutative**:
  $\qquad AB \ne BA$ in general.
- Examples illustrating noncommutativity and the conditions under which shapes are compatible.

###### Powers of a Square Matrix
- Definition of matrix powers:
  $\qquad A^k = \underbrace{A A \cdots A}_{k\text{ factors}}$
  for a square matrix $A$.
- Interpretation of $A^0 = I$.
- Examples demonstrating how powers accumulate structure.

###### Special Matrices
- **Zero matrix**: additive identity for matrices.
- **Identity matrix**: multiplicative identity  
  $\qquad IA = A = AI$
- **Permutation matrices**:
  - Defined by permuting standard basis vectors.
  - Interpretation as row-permutation operators under left multiplication.
  - Examples demonstrating how permutations reorder rows of a matrix.

##### 1.3 Properties of Matrix Multiplication
- Associativity:  
  $\qquad (AB)C = A(BC)$
- Left and right distributive laws:  
  $\qquad A(B+C) = AB + AC$  
  $\qquad (A+B)C = AC + BC$
- Compatibility with scalar multiplication:  
  $\qquad (\alpha A)B = \alpha(AB) = A(\alpha B)$

###### Caveats: Misleading Scalar Patterns
The notebook emphasizes several pitfalls when generalizing scalar algebra to matrices:

- **No division** of matrices in general; there is no universal $A^{-1}$.
- **Cancellation laws fail**:  
  $AB = AC$ does **not** imply $B = C$.
- **Commutative-like patterns fail**:  
  $A^2 - B^2 \ne (A-B)(A+B)$ in general.
- **Multiplication order matters** everywhere.

##### 1.4 Dot Product Compared with Matrix Multiplication
- Dot product is a special case of the $1 \times n$ by $n \times 1$ matrix product.
- Matrix multiplication extends this idea by performing many dot products simultaneously.
- Graphical layout views illustrating how matrix multiplication is assembled from dot products.

---

### 2. Examples

##### 2.1 Products of More Than Two Matrices
- Step-by-step evaluation of expressions such as  
  $\qquad ABCD$
  using associativity to choose computationally convenient groupings.
- Discussion of how choosing the grouping can drastically change computational cost.

##### 2.2 Substitution as Matrix Multiplication
- Demonstration that substituting linear expressions into other expressions corresponds to matrix multiplication.
- Illustrative example highlighting how composition of linear combinations is encoded by products of coefficient matrices.

---

### Examples
- Multiple numerical examples of:
  - noncommuting matrix pairs,
  - permutation matrices acting on data,
  - matrix powers,
  - associativity in multi-factor products.
- Examples showing incorrect scalar analogies and why they fail for matrices.

---

### Applications and Conceptual Insights
- Matrix algebra captures the structure of compositions of linear transformations.
- Powers of matrices model repeated application of a transformation.
- Permutation matrices illustrate how discrete symmetries are expressed algebraically.
- The cautionary section reinforces that matrix algebra forms a **noncommutative ring**, shaping how linear operations must be handled.

____
</details>

<details><summary><a href="MatrixMultApplication_GraphTheory.ipynb" style="display:inline-block; width:9cm;">MatrixMultApplication_GraphTheory.ipynb</a>
Graphs, adjacency matrices; matrix multiplication as walk-counting; powers of $A$; triangle counting
</summary>

### Contents

#### 1. Graphs and Adjacency Matrices

##### 1.1 Definitions
- Introduction to **simple graphs**, vertices, and edges.
- The **adjacency matrix** $A$ of a graph, where  
  $\qquad A_{ij} = 1 \text{ if there is an edge } i\!\to\! j,\; 0 \text{ otherwise}$
- Interpretation of adjacency matrices as encoding the connections of a graph in linear-algebraic form.

##### 1.2 Multiplication by a Row Vector (Left Multiplication)
This section explains how **row–matrix** multiplication extracts combinatorial information from the graph.

- Row selection: a row vector $e_i^T$ selects the $i$-th row of $A$.
- Row sums: summing rows corresponds to union of neighborhoods.
- Multiplying by $A$ once counts length-1 walks; multiplying twice counts length-2 walks.

###### 1.2.1 Pick a Row of $A$
- $e_i^T A$ gives the adjacency information of vertex $i$.
- Example: neighbors of vertex $i$ correspond to the nonzero entries of $e_i^T A$.

###### 1.2.2 Sum Two Rows of $A$
- $(e_i^T + e_j^T) A$ produces the union of neighbors of $i$ and $j$.
- Illustrates linearity: linear combinations of rows correspond to linear combinations of adjacency information.

###### 1.2.3 Pick a Row and Multiply by $A$ Twice
- $e_i^T A^2$ counts the number of **length-2 walks** from $i$ to every vertex.
- Examples show how repeated multiplication builds combinatorial information.

##### 1.3 Powers of $A$
- The $(i,j)$ entry of $A^k$ equals the number of **walks of length $k$** from vertex $i$ to vertex $j$.
- Discussion includes:
  - how powers accumulate connectivity information,
  - how matrix multiplication propagates neighborhood structure,
  - examples illustrating small $k$.

---

#### 2. Counting Triangles
- A **triangle** in a simple graph is a 3-cycle: three vertices each connected to the other two.
- The diagonal entries of $A^3$ count closed walks of length three.
- The trace provides the total number of such closed walks:
  $\qquad \mathrm{trace}(A^3)$
- Each triangle contributes exactly 6 closed walks (three starting vertices, two directions).
- Therefore the number of triangles is  
  $\qquad \dfrac{1}{6}\,\mathrm{trace}(A^3)$
- The notebook presents explicit examples verifying this relationship.

---

### Examples
- Neighbor analysis via $e_i^T A$ and $(e_i^T + e_j^T)A$.
- Counting walks of length 1, 2, and 3 using matrix powers.
- Direct computation of $A^3$ for small graphs and comparison with the triangle-count formula.
- Examples showing how adjacency information propagates through matrix multiplication.

---

### Applications and Conceptual Insights
- Matrix multiplication acts as a **combinatorial operator**, revealing structure in graphs.
- Powers of $A$ uncover higher-order connectivity patterns: reachability, walk counts, and structural motifs.
- The trace identity for triangle counting demonstrates how **global combinatorial statistics** arise naturally from linear algebra.
- The notebook motivates the broader theme that **graph theory and linear algebra are deeply interconnected** through adjacency matrices.

____
</details>

---

# 2. Gaussian Elimination, Gauss-Jordan Elimination, Special Cases
<details><summary><a href="05_RowEchelonForm_Systems.ipynb" style="display:inline-block; width:9cm;">05_RowEchelonForm_Systems.ipynb</a>
Linear systems; solution types; row-echelon form; free variables; back-substitution
</summary>

### Contents

#### 1. Systems of Linear Equations

##### 1.1 Definition
- A system of $m$ linear equations in $n$ unknowns is written in component form or in matrix form.
- Each equation has the form  
  $\qquad a_{1}x_{1} + a_{2}x_{2} + \cdots + a_{n}x_{n} = b$
- Examples illustrate how coefficients and variables assemble into a structured system.

##### 1.2 Solutions of a Linear System
- Discussion of **solution sets**: unique solution, infinitely many solutions, or no solution.
- Worked examples show how the structure of the equations influences solvability.

---

#### 2. Solutions of Row-Echelon-Form Systems

##### 2.1 Two Simple Examples
- Systems already in **row echelon form**, illustrating:
  - identification of leading variables,
  - recognition of free variables,
  - stepwise solution of the system.
- Examples present solutions explicitly and interpret them parametrically.

##### 2.2 Systems Without an Equation for Each Variable
- When some variables do not appear in leading positions, they become **free variables**.
- Two detailed examples show how free variables generate infinitely many solutions:
  $\qquad x = x(t),\; y = y(t),\; z = t$
- Emphasis on describing the solution set using parameters.

###### What Makes This Work?
- Explanation that echelon form isolates leading variables in an upper-triangular pattern.
- Solutions are obtained by expressing leading variables in terms of free variables.

---

#### 3. The Back-Substitution Algorithm

##### Example 1
- A step-by-step illustration of solving an upper-triangular system
- Explicit computation proceeds from the last equation upward.

##### 3.1 Definition
- A formal definition of **back-substitution** for solving triangular systems.

##### Augmented Form
- Introduction of augmented matrices to represent systems concisely:
  $\qquad (A \mid b)$
- Shows how echelon form is applied to the augmented system, not merely to $A$.

##### 3.2 The Back-Substitution Algorithm
- Algorithmic description of solving triangular systems:
  1. Solve the last leading equation for its variable.
  2. Substitute upward, one equation at a time.
  3. Introduce parameters for any free variables.
- Another example fully executed by hand to solidify the procedure.

---

### Examples
- Multiple linear systems solved both directly and in echelon form.
- Examples with:
  - unique solutions,
  - infinitely many solutions (parametric families),
  - inconsistent systems (demonstrating impossibility of solving all equations simultaneously).

---

### Applications and Conceptual Insights
- Row-echelon form exposes the internal structure of a linear system.
- Free variables reveal the degrees of freedom in the solution space.
- Back-substitution gives a systematic method for solving upper-triangular systems, foundational for Gaussian elimination.
- Parametric descriptions connect algebraic solutions to geometric objects such as lines and planes in $\mathbb{R}^n$.

____
</details>


<details><summary><a href="06_GE_Systems.ipynb" style="display:inline-block; width:9cm;">06_GE_Systems.ipynb</a>
Gaussian elimination; elementary row operations; elimination matrices
</summary>

### Contents

#### 1. The Basic Idea of Gaussian Elimination

The notebook introduces Gaussian elimination as a systematic method for removing variables  
from equations to simplify a linear system.

##### 1.1 Examples
Two motivating examples show the idea of using combinations of equations to eliminate a variable:

###### Example 1
- Start with a pair of equations in two variables.
- Replace one equation by a linear combination to eliminate a variable.
- Solve the resulting simplified system by back-substitution.

###### Example 2
- Similar elimination process applied to a different system.
- Highlights that different elimination paths produce equivalent reduced systems.

---

#### 1.2 Elementary Row Operations

The notebook formalizes the three allowed operations:

1. **Replace a row with itself plus a scalar multiple of another row**  
2. **Exchange two rows**  
3. **Scale a row by a nonzero scalar**

Each is illustrated with detailed examples:

###### Example 1: Combine Rows to Eliminate a Variable
- Shows how $R_2 \leftarrow R_2 - c R_1$ eliminates a chosen variable.

###### Example 2: Row Exchange
- Justifies swapping equations to position a convenient pivot.

###### Example 3: Scale a Row
- Scales an equation so that a pivot becomes $1$, preparing for clean elimination.

---

### 2. Intermediate Stage: Gaussian Elimination While Writing Equations

This section demonstrates elimination **directly at the equation level**, without matrices:

- Sequential removal of variables from the first equation downward.
- Produces an upper-triangular chain of equations.
- Example shows careful bookkeeping of new equations created during the elimination.

---

### 3. Gaussian Elimination in Matrix Form

Gaussian elimination is reformulated using **augmented matrices**.

##### 3.1 Key Insight
- Elementary row operations correspond to multiplying on the **left** by special matrices.
- The augmented matrix  
  $\qquad (A \mid b)$  
  encodes the entire system, and row operations preserve the solution set.

###### Previous Example in Augmented-Matrix Form
- The elimination steps from Section 2 are rewritten succinctly using matrix notation.
- Each transformation is displayed as a single row operation on the augmented matrix.

---

#### 3.2 The Elimination Matrix

A central concept of the notebook:

- An **elimination matrix** $E$ performs a specific row operation when left-multiplied with $A$.
- Example:  
  $\qquad E_{21} = I - c\,e_2 e_1^T$  
  eliminates the $(2,1)$ entry of $A$.
- The notebook constructs explicit elimination matrices for each row operation used.
- Demonstration that  
  $\qquad EA$  
  reflects exactly the same equation-level elimination step performed earlier.

###### The Example Revisited
- The elimination matrix is applied step-by-step to the augmented matrix.
- Shows how multiple elimination matrices compose to form the full elimination procedure.

---

#### 3.3 A Complete Example
A larger system is solved fully:

1. Write the augmented matrix.  
2. Apply a sequence of elimination matrices to reach echelon form.  
3. Use back-substitution to find the solution.  

The example emphasizes:

- How pivots are chosen,
- How entries are eliminated in order,
- How elimination matrices accumulate structure.

---

### Examples
- Several elimination sequences on both equation-based and matrix-based representations.
- Construction and use of elimination matrices in concrete numerical examples.
- Full-system example integrating elimination, echelon form, and back-substitution.

---

### Applications and Conceptual Insights
- Gaussian elimination provides a uniform framework for solving linear systems.
- Elementary row operations correspond to invertible transformations that preserve solution sets.
- Elimination matrices clarify the algebraic structure of row operations and prepare for LU decomposition and related factorizations.
- The notebook connects the intuitive, equation-level elimination to the formal matrix-level algorithm used in computational linear algebra.

____
</details>


<details><summary><a href="07_GE_Systems.ipynb" style="display:inline-block; width:9cm;">07_GE_Systems.ipynb</a>
Corner cases in Gaussian elimination; missing pivots; contradictions; pivoting strategies
</summary>

### Contents

#### 1. Corner Cases for Gaussian Elimination

##### 1.1 The Approach to Solving $A x = b$
- Review of the Gaussian elimination framework:
  - Proceed column by column.
  - Seek a pivot in the current column.
  - Use elimination to remove entries below the pivot.
  - Continue until either echelon form or an obstruction (e.g., lack of a pivot) is encountered.

##### 1.2 Missing Pivots
A central theme of this notebook is what happens when a pivot **cannot** be found in the current column.

###### 1.2.1 Subcase: A Suitable Row Exists
- There is an equation whose leading variable matches the current column.
- A row exchange places the appropriate pivot row in position.
- Elimination proceeds normally afterward.

###### 1.2.2 Subcase: No Equation Matches the Current Leading Variable
- No nonzero entry exists in the pivot column below the current row.
- The algorithm skips this column and continues to the next.
- Leads to free variables and underdetermined systems.

###### 1.2.3 Special Case: Rows of Zeros
- Entire row equals zero.
- Two subcases:
  - **Zero right-hand side**: consistent but redundant equation.
  - **Nonzero right-hand side**: produces a **contradiction**.
- The notebook includes explicit examples demonstrating each outcome.

##### Example 1: Zero Right-Hand Side
- A bottom row of the form  
  $\qquad 0x_1 + 0x_2 + \cdots + 0x_n = 0$  
  imposes no constraint; solution set remains unaffected.

##### Example 2: Nonzero Right-Hand Side
- A bottom row of the form  
  $\qquad 0x_1 + \cdots + 0x_n = c$ with $c \ne 0$  
  renders the system **inconsistent**, producing no solution.

---

### 2. Example Computations

##### 2.1 The GE Algorithm
The notebook presents a clear pseudocode version of Gaussian elimination:

- Start in row 1, column 1.
- For each column:
  - Find a pivot (if none exists, move to next column).
  - Exchange rows if needed.
  - Eliminate entries below the pivot.
  - Move down to the next row.
- Continue until either the bottom of the matrix is reached or all columns are processed.

###### Remarks
- The algorithm does not guarantee a pivot in every column.
- Missing pivots lead naturally to free variables.

##### 2.2 Example: Redundant Equations
- A system with repeated or equivalent equations illustrates how missing pivots occur naturally.
- Demonstrates how elimination automatically discards redundant information.

##### 2.3 Example: Contradiction
- A system containing an impossible row after elimination (e.g., $0 = 5$).
- Explicitly shows how the contradiction is detected.

##### 2.4 Number of Equations, Unknowns, and Solutions
- Discussion of how the shape of the echelon form:
  - reveals free variables,
  - identifies contradiction rows,
  - determines whether the system is consistent or inconsistent.

###### Contradictions
- Interpretation of contradictory rows as evidence of geometric emptiness of the solution set.

---

### 3. Algorithm Variations

##### 3.1 Partial Pivoting and Full Pivoting
- Motivation: improve numerical stability and avoid dividing by very small numbers.
- Partial pivoting: swap rows to choose the largest pivot candidate in the column.
- Full pivoting: swap both rows and columns to maximize pivot magnitude.

##### 3.2 Gauss–Jordan Elimination
- Extends elimination to remove entries **above** pivots as well, producing reduced row echelon form (RREF).
- Example illustrates the procedure and contrasts it with standard Gaussian elimination.

###### Reduced Row Echelon Form
- Characteristics of RREF:
  - pivots equal to $1$,
  - each pivot is the only nonzero entry in its column,
  - pivot positions move strictly to the right as you move down the rows.
- Example shows how RREF directly reveals the structure of the solution set.

---

### Examples
- Handling missing pivots in various configurations.  
- Demonstrating redundancy vs. contradiction in real systems.  
- Complete elimination sequences showing decision points in the algorithm.  
- Examples comparing Gaussian elimination, pivoting strategies, and Gauss–Jordan elimination.

---

### Applications and Conceptual Insights
- Missing pivots expose fundamental relationships between equations (dependencies).  
- Contradiction rows represent impossible geometric conditions.  
- Pivoting strategies improve robustness in computational practice.  
- Gauss–Jordan elimination provides a direct route to fully simplified solution descriptions.

____
</details>

---

<details><summary><a href="PDE_example.ipynb" style="display:inline-block; width:9cm;">PDE_example.ipynb</a>
Finite-difference discretization; derivative operators; Poisson equation; linear system formulation
</summary>

### Contents

#### 1. Numerical Approximation of Derivatives
- Finite-difference formulas for first and second derivatives using sampled function values.
- The second-difference formula produces a **tridiagonal matrix** that represents the discrete second-derivative operator.

#### 2. Discretizing the Poisson Equation
- The 1D Poisson equation  
  $\qquad -u''(x) = f(x)$  
  is replaced by a finite-difference model on a grid.
- Boundary conditions incorporate naturally into the resulting linear system.

#### 3. The Resulting Linear System
- Discretization yields a system of the form  
  $\qquad A u = b$  
  where $A$ is the discrete Laplacian matrix.
- Solving this linear system gives an approximate numerical solution to the PDE.

### Conceptual Insights
- Differential equations become algebraic equations after discretization.  
- The structure of the discrete second derivative is inherently linear-algebraic.  
- The example illustrates a widely used workflow in scientific computing.

____
</details>

---
<details><summary><a href="11_Inverses.ipynb" style="display:inline-block; width:9cm;">11_Inverses.ipynb</a>
Matrix inverse; left and right inverses; solving $Ax=b$
</summary>

### Contents

#### 1. Inverse of a Square Matrix
- Definition of an inverse: a square matrix $A$ is invertible if there exists $A^{-1}$ such that  
  $\qquad A A^{-1} = I \quad\text{and}\quad A^{-1} A = I$
- Interpretation: $A^{-1}$ reverses the linear transformation defined by $A$.
- Discussion of matrices that fail to be invertible:
  - determinant zero,
  - rows or columns not linearly independent,
  - systems $A x = b$ not solvable for all $b$.

##### Summary
- Invertibility requires a pivot in every row and every column
- The inverse is unique when it exists.

##### A Matrix That Does Not Have an Inverse
- Example illustrating loss of invertibility through row dependence or failure to map onto the entire codomain.

##### Application
- Use of the inverse to solve linear systems:  
  $\qquad x = A^{-1} b$  
  when $A$ is invertible.

---

### 2. Left and Right Inverses
- Definition of a **left inverse** $L$ such that  
  $\qquad L A = I$
- Definition of a **right inverse** $R$ such that  
  $\qquad A R = I$
- Conceptual meaning:
  - A left inverse guarantees $A$ is **injective**.  
  - A right inverse guarantees $A$ is **surjective**.

##### Summary
- A matrix has a two-sided inverse (a true inverse) exactly when it has both a left and a right inverse.
- This can happen **only** for square matrices with full rank.

---

### Major Insights
- Invertibility is a structural property: it reflects independence of rows/columns and full rank.
- Left and right inverses arise naturally in nonsquare contexts but coincide only when $A$ is invertible.

____
</details>

<details><summary><a href="12_LU_decomposition.ipynb" style="display:inline-block; width:9cm;">12_LU_decomposition.ipynb</a>
LU and PLU factorizations; forward/backward substitution; pivoting; PLDU variant
</summary>

### Contents

#### 1. From Gaussian Elimination to $LU$
- Gaussian elimination rewrites a matrix $A$ through successive elimination steps.
- Each step corresponds to multiplication on the left by an **elimination matrix**.
- Collecting these steps shows that  
  $\qquad E_k \cdots E_2 E_1 A = U$  
  where $U$ is an upper-triangular matrix.

#### 2. Constructing the Factorization
- Because each elimination matrix $E_i$ is invertible,  
  $\qquad A = (E_1^{-1} E_2^{-1} \cdots E_k^{-1})\, U$
- The product of inverse elimination matrices is a **unit lower-triangular** matrix  
  $\qquad L = E_1^{-1} E_2^{-1} \cdots E_k^{-1}$
- Therefore  
  $\qquad A = L U$

#### 3. Structure of $L$ and $U$
- $U$ comes directly from Gaussian elimination (without row swaps).
- $L$ contains the multipliers used in elimination:
  - ones on the diagonal,
  - entries below the diagonal matching the elimination coefficients.

#### 4. Solving Linear Systems with $LU$
- To solve $A x = b$, use  
  $\qquad L U x = b$  
- First solve $L y = b$ (forward substitution).
- Then solve $U x = y$ (back substitution).
- This separates elimination from solving and is efficient when solving many systems with the same $A$.

#### 5. When $LU$ Exists
- An $LU$ factorization without row exchanges exists when Gaussian elimination proceeds without needing to swap rows.
- Pivot positions must be nonzero at each elimination stage.
- If zero pivots occur, **pivoting** or a **permutation matrix** is required, leading to $PA = LU$ factorizations.

### Conceptual Insights
- $LU$ makes Gaussian elimination reusable and modular.
- $L$ records the elimination steps; $U$ records the resulting triangular form.  
- The factorization connects the algorithmic procedure of elimination to a clean algebraic identity.

____
</details>

<details><summary><a href="LU.ipynb" style="display:inline-block; width:9cm;">LU.ipynb</a>
LU factorization; examples; pivoting via PLU
</summary>

### Contents

#### LU Decomposition

##### 1. Theory
- Gaussian elimination expresses $A$ as a product of a **lower-triangular** matrix $L$ and an **row echelon form** matrix $U$.
- $L$ contains the multipliers used during elimination; $U$ is the echelon form produced without row exchanges.  
- The factorization satisfies  
  $\qquad A = L U$

##### 1.1 Simple Example
- Demonstrates how elimination steps translate directly into entries of $L$ and $U$.
- Highlights the roles of pivots, multipliers, and triangular structure.

##### 1.2 Larger Example
- Same principles applied to a higher-dimensional matrix.
- Emphasis on how repeated elimination steps accumulate systematically in $L$.

#### Solving Linear Systems via $LU$
- To solve $A x = b$ using the factorization  
  $\qquad A = L U$  
  proceed in two stages:
  1. Solve $L y = b$ (forward substitution).  
  2. Solve $U x = y$ (back substitution).  
- This separates the cost of elimination from the cost of solving,  
  advantageous when solving multiple systems with the same matrix.

---

### PLU Decomposition

#### Motivation
- If a pivot is zero (or unreliable), Gaussian elimination requires row exchanges.
- This is captured by introducing a **permutation matrix** $P$ such that  
  $\qquad P A = L U$

#### 2. PLU Factorization
- The notebook constructs factorizations of the form $P A = L U$ in cases where standard $LU$ fails without pivoting.
- $P$ encodes row swaps; $L$ and $U$ retain the triangular structure.

### Conceptual Insights
- $LU$ decomposition reflects the algebraic structure of elimination.
- $P$ bridges the gap between ideal pivot behavior and practical numerical needs.
- Factorizations unify algorithmic elimination with algebraic identities that enable efficient computation.

____
</details>

____
<details>
<summary>
<a href="HillsCipher.ipynb" style="display:inline-block; width:9cm;">HillsCipher.ipynb</a>
Hill cipher; matrix–vector encoding; modular linear algebra; decoding without explicit inverse
</summary>

### Contents

#### 1. Hill’s Cipher

##### 1.1 Overview
- Hill’s cipher encodes blocks of letters using matrix multiplication performed **modulo** an integer.
- A message block $x$ is transformed using a square invertible matrix $A$ by  
  $\qquad y = A x \pmod{m}$  
- Successful decryption requires that $A$ be invertible modulo $m$.

##### 1.2 Transforming a Message into a Matrix
- Letters are mapped to integers (e.g., $A \mapsto 0$, $B \mapsto 1$, …).
- Messages are grouped into vectors of fixed length to match the dimensions of the encoding matrix.
- These vectors form the columns of a data matrix used in encryption.

##### 1.3 Encoding the Message
- Encryption is performed by  
  $\qquad Y = A X \pmod{m}$  
  where $X$ is the plaintext block matrix and $Y$ is the ciphertext block matrix.
- Modular arithmetic ensures results remain within the symbol set.

##### 1.4 Decoding the Message
- Decoding uses the modular inverse of the key matrix:  
  $\qquad X = A^{-1} Y \pmod{m}$  
- Existence of $A^{-1}$ modulo $m$ requires $\det(A)$ to be invertible modulo $m$.

---

### 2. Avoiding Explicit Matrix Inversion
- The notebook demonstrates how to decode a message **without computing** an explicit modular inverse of $A$.
- By placing equations in a standard form where the unknown plaintext block appears on the right, one solves a modular linear system instead of forming $A^{-1}$.
- This highlights that decryption is fundamentally a linear-algebraic problem: solving  
  $\qquad A X = Y \pmod{m}$  
  for $X$.

---

### Conceptual Insights
- Hill’s cipher uses linear algebra performed with modular arithmetic,  
where matrix operations are carried out modulo an integer
- Invertibility in modular arithmetic governs both the security and feasibility of the cipher.
- Encoding and decoding are matrix–vector transforms; solving modular systems replaces explicit inversion when convenient.

____
</details>

---
<details><summary><a href="CR_Decomposition.ipynb" style="display:inline-block; width:9cm;">CR_Decomposition.ipynb</a>
CR and CMR decompositions; pivot columns; bases for column/row spaces via elimination
</summary>

### Contents

#### 1. Column–Row Decomposition
- A matrix $A$ of rank $r$ can be written as  
  $\qquad A = C R$  
  where  
  - $C$ consists of selected **pivot columns** of $A$,  
  - $R$ consists of the corresponding **rows** expressing all rows of $A$ as linear combinations of pivot rows.

#### 2. Relation to Gaussian Elimination
- Gaussian elimination identifies pivot columns and pivot rows.  
- These pivots encode a minimal set of independent directions in the column and row spaces.  
- The decomposition captures the structure exposed by elimination.

#### 3. Bases for Column and Row Spaces
- Pivot columns form a basis for the **column space** of $A$.  
- Pivot rows (extracted after elimination) form a basis for the **row space**.

#### 4. Applications
- CR decomposition reduces storage and computation by expressing $A$ through low-rank structure.  
- Useful for understanding rank, independence, and data reduction concepts.

____
</details>

---
<details><summary><a href="CholeskyDecomposition.ipynb" style="display:inline-block; width:9cm;">CholeskyDecomposition.ipynb</a>
PLDU and $LDL^T$ factorizations; symmetric elimination; Cholesky decomposition
</summary>

### Topics

**Decomposition of Symmetric Matrices**  
Symmetric elimination applies paired operations $E_i$ (left) and $E_i^T$ (right), maintaining symmetry throughout the reduction.

**$LDL^T$ Decomposition**  
When no row exchanges are required, symmetric elimination yields  
$\qquad
A = L D L^T,
$  
with $L$ unit lower-triangular and $D$ diagonal.  
This factorization arises directly from recording the symmetric elimination steps.

**$PLDL^T P^T$ Decomposition**  
If row exchanges are needed, permutation matrices are introduced, yielding  
$\qquad
A = P\,L\,D\,L^T P^T.
$
provided that the needed pivots actually exist.

**Cholesky-Type Triangular Factorization**  
In the special $A = L D L^T$ case with all diagonal entries of $D$ are positive, the diagonal matrix splits as  
$\qquad
D = D^{1/2} D^{1/2},
$  
which produces 
$
A = (L D^{1/2})(L D^{1/2})^T = G G^T,
\qquad G = L D^{1/2}.
$

**Computation**  
Writing $A = G G^T$ allows the entries of $G$ to be computed **directly** from $A$ without forming $D$ first.  
This yields the **Cholesky algorithm**, which builds $G$ row by row through square-root and update steps.

____
</details>

<details><summary><a href="CholeskyDecompositionExample.ipynb" style="display:inline-block;width:9cm;">CholeskyDecompositionExample.ipynb</a>
Worked example: $LDL^T$ and Cholesky factorizations; forward/backward substitution; solving $Ax=b$
</summary>

### Topics

**Problem Setup**  
Compute $A = LDL^T$ and the Cholesky factorizations and use them to solve $Ax=b$.

**$LDL^T$ Decomposition using Gaussian Elimination**  
Construction of  
$\qquad
A = L D L^T,
$  
using Gaussian Elimination. Illustrates how symmetric elimination determines $L$ and $D$.

**Solving $Ax=b$ Using the Cholesky Decomposition**  
Two-stage solution:
1. **Forward substitution** to solve $Gy = b$,  
2. **Backward substitution** to solve $G^T x = y$.

Discussion of a reduced Cholesky variant that avoids a free variable in the intermediate system.

**Streamlined Computation**  
Presentation of the more direct, entry-by-entry procedure to compute both $A = G G^T$ without explicitly forming $D$ first,  
i.e., the **Cholesky algorithm.**

____
</details>


<details>
<summary>
<a href="UpdateOfMatrixInverse.ipynb" style="display:inline-block; width:9cm;">UpdateOfMatrixInverse.ipynb</a>
Sherman–Morrison–Woodbury formula; rank-1 and rank-$k$ inverse updates; regression updates example
</summary>

### Topics

**Sherman–Morrison–Woodbury Formula**  
Derivation of the inverse-update identity  
$\qquad
(A + U V^T)^{-1}
= A^{-1} - A^{-1} U (I + V^T A^{-1} U)^{-1} V^T A^{-1},
$  
motivated by extending the Gauss–Jordan algorithm to block matrices.

**Special Case: Rank-1 Update of a Matrix Inverse**  
Specialization to $
(A + u v^T)^{-1},
$
with a complete worked numerical example.

**Special Case Rank-$k$ Update of a Matrix Inverse**  
Specialization to $
\displaystyle{(A + \sum_{i=1}^k {u v^T} )^{-1}$

**Solving $Bx=b$ via a Simpler System**  
Using $B = A + U V^T$
and $A^{-1}$ to solve systems with $B$ efficiently; formulation of the solution through intermediate low-dimensional systems.

**Updating a Regression Solution**  
Application to linear regression when new observations augment the design matrix; reuse of previous inverse or pseudo-inverse via a rank-update formula.

____
</details>

---
# 3. Row Echelon Forms using Givens or Householder
<details><summary><a href="GivensRotations.ipynb" style="display:inline-block; width:9cm;">GivensRotations.ipynb</a>
Givens rotations; zeroing subdiagonal entries; QR decomposition by plane rotations
</summary>

### Contents

#### 1. Givens Rotations
- A **Givens rotation** is an orthogonal matrix that acts on two coordinates at a time.
- Designed to introduce zeros into specific positions of a matrix while preserving norms.

#### 2. Eliminating Subdiagonal Entries
- Left multiplication by a Givens rotation can zero a chosen subdiagonal entry.
- Each rotation affects only two rows, leaving the rest unchanged.

#### 3. Orthogonality
- Givens matrices satisfy  
  $\qquad G^T G = I$
- Orthogonality preserves lengths and inner products.

#### 4. QR Decomposition
- Repeated Givens rotations factor a matrix as  
  $\qquad A = Q R$  
  where $Q$ is orthogonal and $R$ is upper triangular.
- Particularly effective for sparse matrices.

### Conceptual Insights
- Givens rotations provide fine-grained control over elimination.
- They form a numerically stable alternative to elimination-based factorizations.

____
</details>


<details><summary><a href="HouseholderReflections.ipynb" style="display:inline-block; width:9cm;">HouseholderReflections.ipynb</a>
Householder reflections; construction of $H$; zeroing subdiagonal blocks; QR decomposition
</summary>

### Contents

#### 1. Householder Reflections
- A **Householder reflection** is an orthogonal transformation that reflects vectors across a hyperplane.
- Defined by a unit vector $v$ through the matrix  
  $\qquad H = I - 2 v v^T$
- Satisfies  
  $\qquad H^T = H \quad \text{and} \quad H^T H = I$

---

#### 2. Reflecting Vectors
- A Householder matrix can map a given vector to a multiple of a coordinate vector.
- Used to eliminate all but one component of a vector in a single operation.
- Examples illustrate reflection across a hyperplane orthogonal to $v$.

---

#### 3. Applying Householder Reflections to Matrices
- Left multiplication by a Householder matrix introduces zeros below a chosen entry in a column.
- Each reflector acts on an entire column at once, unlike Givens rotations which act on pairs of rows.
- Successive reflections reduce a matrix to upper-triangular form.

---

#### 4. QR Decomposition via Householder Reflections
- Repeated Householder reflections factor a matrix as  
  $\qquad A = Q R$  
  where:
  - $Q$ is orthogonal (product of reflections),
  - $R$ is upper triangular.
- This method is efficient and numerically stable for dense matrices.

---

### Conceptual Insights
- Householder reflections provide a geometric approach to orthogonalization.  
- They eliminate entire subcolumns in one step.  
- Together with Givens rotations, they form the foundation of practical QR algorithms.

____
</details>

---
# 4. Bases, Spaces, Fundamental Theorem
<details><summary><a href="08_LinearIndependence.ipynb" style="display:inline-block; width:9cm;">08_LinearIndependence.ipynb</a>
Solutions of $Ax=b$; homogeneous solutions; linear independence criteria and examples
</summary>

### Contents

#### 1. Linear Independence and Dependence

##### 1.1 Definition
- A set $\{v_1,\dots,v_k\}$ is **linearly independent** if  
  $\qquad c_1 v_1 + \cdots + c_k v_k = 0$  
  implies $c_1=\cdots=c_k=0$.
- Linear dependence means at least one vector can be written as a linear combination of the others.

##### 1.2 Dependence Relations
- A nontrivial linear combination producing zero is called a dependence relation.
- Dependence implies redundancy within the set.

---

#### 2. Homogeneous Systems and Independence

##### 2.1 Matrix Formulation
- Vectors assembled as columns of a matrix $A$.
- Independence corresponds to the homogeneous system  
  $\qquad A x = 0$  
  having only the trivial solution.

##### 2.2 Pivot Interpretation
- Independent columns correspond to pivot columns.
- Free variables indicate dependence.

---

#### 3. Geometric Interpretation

##### 3.1 Direction and Dimension
- Independent vectors point in distinct directions.
- Dependent vectors lie in a lower-dimensional subspace.

##### 3.2 Examples
- Lines vs. planes in $\mathbb{R}^2$ and $\mathbb{R}^3$.
- Visualization of redundancy.

---

### Examples
- Testing sets of vectors for independence.
- Interpreting dependence geometrically.

---

### Conceptual Insights
- Independence captures the absence of redundancy.
- Elimination reveals independence through pivots.
- Geometry and algebra provide complementary viewpoints.

____
</details>



<details><summary><a href="LinearIndependence.ipynb" style="display:inline-block; width:9cm;">LinearIndependence.ipynb</a>
Linear independence tests; structural cases; dependence in $\mathbb{R}^N$ and function spaces
</summary>

### Contents

#### 1. Independence via Linear Systems

##### 1.1 Homogeneous Systems
- Independence defined via uniqueness of the zero solution to  
  $\qquad A x = 0$.

##### 1.2 Trivial vs. Nontrivial Solutions
- Trivial solution corresponds to independence.
- Nontrivial solutions indicate dependence.

---

#### 2. Rank and Independence

##### 2.1 Rank Definition
- Rank equals the number of independent columns.
- Rank measures intrinsic dimensionality.

##### 2.2 Rank Deficiency
- When rank is smaller than the number of vectors, dependence occurs.

---

#### 3. Elimination Perspective

##### 3.1 Gaussian Elimination
- Pivot positions identify independent vectors.
- Missing pivots reveal linear relations.

##### 3.2 Examples
- Column sets tested using elimination.

---

### Conceptual Insights
- Independence is invariant under row operations.
- Rank provides a quantitative measure of independence.

____
</details>


<details><summary><a href="15_VectorSpaces.ipynb" style="display:inline-block; width:9cm;">15_VectorSpaces.ipynb</a>
Vector spaces; spans; closure properties; subspaces; examples in $\mathbb{R}^N$, matrices, and function spaces
</summary>

### Contents

#### 1. Vector Spaces

##### 1.1 Definition
- A vector space is defined by axioms governing addition and scalar multiplication.
- Emphasis on closure, identity, inverses, and distributive laws.

##### 1.2 Scalars and Structure
- Scalars drawn from a field.
- Structure independent of coordinate representation.

---

#### 2. Subspaces

##### 2.1 Definition
- A subspace is a subset closed under addition and scalar multiplication.

##### 2.2 Subspace Test
- Zero vector inclusion.
- Closure properties.

---

#### 3. Examples of Vector Spaces

##### 3.1 Coordinate Spaces
- $\mathbb{R}^n$ and subspaces defined by linear equations.

##### 3.2 Non-Coordinate Spaces
- Polynomial spaces.
- Matrix spaces.
- Function spaces.

---

### Conceptual Insights
- Vector spaces generalize linear structure.
- Linear algebra applies far beyond coordinate vectors.

____
</details>



<details><summary><a href="16_Basis.ipynb" style="display:inline-block; width:9cm;">16_Basis.ipynb</a>
Bases; dimension; constructing bases; column/row/null spaces; Fundamental Theorem (Part 1)
</summary>

### Contents

#### 1. Bases and Dimension

##### 1.1 Bases from Elimination
- Start with columns of a matrix $A$.
- Row echelon form identifies pivot columns.
- Pivot columns form a basis for the span.

##### 1.2 Basis and Dimension
- A basis is a spanning set with no redundancy.
- Dimension is the number of basis vectors.
- Examples in $\mathbb{R}^n$ and function spaces.

---

#### 2. The Four Fundamental Subspaces

##### 2.1 Definitions
For $A \in \mathbb{R}^{M\times N}$:
- column space $\mathscr{C}(A)$,
- row space $\mathscr{R}(A)$,
- null space $\mathscr{N}(A)$,
- left null space $\mathscr{N}(A^T)$.

##### 2.2 Bases from Elimination
- $\mathscr{C}(A)$: pivot columns of $A$.
- $\mathscr{R}(A)$: nonzero rows of row echelon form.
- $\mathscr{N}(A)$: free-variable solutions of $Ax=0$.
- $\mathscr{N}(A^T)$: obtained from elimination data.

---

#### 3. Fundamental Theorem of Linear Algebra (Part I)

##### 3.1 Statement
If $\operatorname{rank}(A)=r$:
- $\dim \mathscr{C}(A)=r$,
- $\dim \mathscr{R}(A)=r$,
- $\dim \mathscr{N}(A)=N-r$,
- $\dim \mathscr{N}(A^T)=M-r$.

##### 3.2 Dimension Identities
$\qquad \dim \mathscr{C}(A)+\dim \mathscr{N}(A)=N$  
$\qquad \dim \mathscr{R}(A)+\dim \mathscr{N}(A^T)=M$

---

#### 4. Take Away
- Elimination produces bases.
- Rank controls all four subspaces.
- Domain and codomain structure are linked by dimension formulas.

____
</details>

____
<details><summary><a href="CoordinateSystems.ipynb" style="display:inline-block; width:9cm;">CoordinateSystems.ipynb</a>
Coordinate representations; expressing vectors in different spanning sets
</summary>

### Contents

#### 1. Coordinates Relative to a Basis
- Given a basis $\{b_1,\dots,b_n\}$, every vector $v$ has coordinates  
  $\qquad v = c_1 b_1 + \cdots + c_n b_n$.
- Coordinate vectors depend on the chosen basis.

---

#### 2. Basis Matrices
- A **basis matrix** $B=[b_1\;\cdots\;b_n]$ maps coordinates to vectors:
  $\qquad v = B[v]_B$.
- Invertibility of $B$ ensures unique coordinates.

---

#### 3. Change of Basis
- Coordinate change between bases $B$ and $C$ given by  
  $\qquad [v]_C = C^{-1}B[v]_B$.
- Same vector, different coordinate descriptions.

---

#### 4. Take Away
- Coordinates are representations, not vectors.
- Basis choice determines numerical form.

____
</details>


<details><summary><a href="SimilarityTransform.ipynb" style="display:inline-block; width:9cm;">SimilarityTransform.ipynb</a>
Change of coordinates; matrix representations in different bases; geometric example with rotations
</summary>

### Contents

#### 1. Change of Coordinates: Decomposition of a Vector

##### 1.1 Coordinate Vectors and Bases
- A vector $b$ is expressed in a basis $\{s_1,s_2\}$ by solving  
  $\qquad b=\alpha_1 s_1+\alpha_2 s_2\;\; \Leftrightarrow \;\; S\begin{pmatrix}\alpha_1\\\alpha_2\end{pmatrix}=b$.

##### 1.2 Example Computation
- Computes the coordinates $(\alpha_1,\alpha_2)$ of a given $b$ relative to a nonstandard basis $\{s_1,s_2\}$.
- Emphasis: the displayed vectors are **coordinate vectors** relative to the current axes.

---

#### 2. Similarity Transforms

##### 2.1 Linear Transforms and Coordinate Systems
- For $y=Ax$ and a change of coordinates $x=S\tilde{x}$, $y=S\tilde{y}$:  
  $\qquad \tilde{y}=\tilde{A}\tilde{x},\quad \tilde{A}=S^{-1}AS$.
- **Definition:** similarity transform $\tilde{A}=S^{-1}AS$ for square $A$ and invertible $S$.

##### 2.2 Example: a 3D Rotation
- Starts from a standard rotation matrix $\tilde{R}_\theta$ in one coordinate system (“blue axes”).
- Chooses an orthonormal basis $\{s_1,s_2,s_3\}$ described in the standard basis (“red axes”), forming $S=[s_1\;s_2\;s_3]$.
- Uses orthonormality to note $S^{-1}=S^T$.
- Produces the rotation matrix in the red coordinate system via  
  $\qquad R_\theta=S\tilde{R}_\theta S^{-1}$,
  yielding an explicit (simplified) closed form for $R_\theta$.
- A video illustrates the rotation

---

#### 3. Generalization of the Similarity Transform

##### 3.1 Different Bases for Domain and Codomain
- For $y=Ax$ with $x=V\tilde{x}$ and $y=U\tilde{y}$ (possibly $U\ne V$):  
  $\qquad \tilde{A}=U^{-1}AV$.

##### 3.2 Example
- Provides a concrete choice of $A$, $U$, and $V$ where  
  $\qquad \tilde{A}=U^{-1}AV$
  becomes “particularly simple” compared to $A$, illustrating how tailored coordinate choices simplify a linear map.

---

#### 4. Take Away
- Vectors: $x=S\tilde{x}$ encodes coordinate change via a basis matrix.
- Square matrices (same basis in domain/codomain): $\tilde{A}=S^{-1}AS$.
- Rectangular / different bases: $\tilde{A}=U^{-1}AV$.
- Examples show coordinate choices can make a transform easier to interpret or compute.

____
</details>


<details><summary><a href="CxFundamentalTheorem.ipynb" style="display:inline-block; width:9cm;">CxFundamentalTheorem.ipynb</a>
Complex inner products; conjugation; fundamental subspaces in the complex case
</summary>

### Contents

#### 1. The Complex Inner Product Requires a Complex Conjugate
- Complex inner product defined by  
  $\qquad \langle u,v\rangle = u\cdot \overline{v}$.
- Orthogonality check for a row-space vector $r$ and a null-space vector $x$ uses  
  $\qquad r\cdot \overline{x}=0 \;\;\Leftrightarrow\;\; \overline{r}\cdot x=0$.
- Key orthogonality adjustment (compared to the real case):  
  $\qquad \mathscr{R}(A^H) \perp \mathscr{N}(A),\quad \mathscr{C}(A) \perp \mathscr{N}(A^H)$

##### Simple Rank-1 Example
- Organizes the discussion around:
  - row and column spaces,
  - right and left null spaces,
  - which spaces are orthogonal under the complex inner product.

---

#### 2. Code
- Constructs a small complex matrix $A$ and related variants:
  - conjugate $\overline{A}$,
  - transpose (with conjugation as used in the notebook),
  - Hermitian transpose $A^H$.
- Computes bases for $\mathscr{R}(\cdot)$, $\mathscr{C}(\cdot)$, and null spaces via elimination / homogeneous-solution routines.
- Verifies orthogonality relations between the appropriate pairs (with conjugation / Hermitian transpose where required).

---

#### 3. Example
- A concrete complex-matrix example checks statements of the form:
  - $\mathscr{R}(A^H)\perp \mathscr{N}(A)$ and $\mathscr{C}(A)\perp \mathscr{N}(A^H)$,
  with the correct conjugation/Hermitian-transpose modifications.
- Demonstrates the “fundamental subspaces” picture in the complex setting by explicit basis construction and orthogonality checks.

____
</details>

---
<details><summary><a href="ThreeBasesExample.ipynb" style="display:inline-block; width:9cm;">ThreeBasesExample.ipynb</a>
Three orthonormal bases (standard, Fourier, Haar); coordinate representations
</summary>

### Contents

#### 1. Data
- A fixed data vector used throughout the notebook.
- Purpose: compare representations across different bases.

---

#### 2. Columns of the Identity Matrix
- Standard basis vectors (coordinate basis).
- Data represented directly in physical/sample space.
- Serves as the reference representation.

---

#### 3. Fourier Basis (Sines and Cosines)
- Representation of the same data using trigonometric basis vectors.
- Coefficients correspond to frequency content.
- Highlights global structure of the signal.

---

#### 4. Haar Wavelet Basis
- Piecewise-constant wavelet basis.
- Representation emphasizes local features and discontinuities.
- Contrasts with the global nature of the Fourier basis.

---

#### 5. Take Away
- Same vector, different coordinate descriptions.
- Choice of basis determines what structure is emphasized.
- Selection of a basis based on the application.

____
</details>


<details><summary><a href="FourierMatrix.ipynb" style="display:inline-block; width:9cm;">FourierMatrix.ipynb</a>
Discrete Fourier matrix; orthogonality; complex exponentials; diagonalization of circulant matrices
</summary>

### Contents

#### 1. The Discrete Fourier Basis
- Construction of the discrete Fourier basis.
- Basis vectors correspond to sampled sines and cosines.
- Orthonormal basis for sampled data.

---

#### 2. Examples with Sampled Functions

##### 2.1 Single Sine
- Sample a sine function at evenly spaced points.
- Express the sampled data in the Fourier basis.

##### 2.2 Mixed Frequencies
- Combination of sine and cosine at different frequencies.
- Fourier coordinates separate frequency components.

---

#### 3. A Function of Time

##### 3.1 Sampling
- Continuous function $x(t)$ sampled at discrete times.
- Sampled values form a vector.

##### 3.2 Removing Fourier Coefficients
- Zeroing selected Fourier coordinates.
- Reconstructing filtered versions of the signal.

---

#### 4. Higher-Dimensional Generalization
- Extension of Fourier bases to higher-dimensional spaces.
- Matrix formulation of discrete Fourier transforms.

---

#### 5. Take Away
- Fourier matrix performs a change of basis.
- Coordinates encode frequency information.
- Filtering corresponds to modifying coordinates.

____
</details>


<details><summary><a href="LightsOut.ipynb" style="display:inline-block; width:9cm;">LightsOut.ipynb</a>
Lights Out puzzle as a linear system; mod-2 arithmetic
</summary>

### Contents

#### 1. Modeling the Puzzle

##### 1.1 Modulo Two Arithmetic
- Puzzle operations modeled using arithmetic modulo $2$.
- Light states and button presses encoded as binary vectors.

##### 1.2 Possible Activations
- Enumeration of button press patterns.
- Each press affects a fixed set of lights.

##### 1.3 Linear Model
- Puzzle written as a linear system  
  $\qquad A x = b \quad (\text{mod }2)$.

---

#### 2. Solving the Puzzle

##### 2.1 Formulating the System
- Construction of the matrix $A$ encoding button–light interactions.

##### 2.2 Gaussian Elimination Modulo 2
- Adaptation of Gaussian elimination to $\mathbb{Z}_2$ arithmetic.

##### 2.3 Computing a Solution
- Explicit solution of the system for a given puzzle state.

---

#### 3. Solvability and Uniqueness

##### 3.1 Fundamental Subspaces over $\mathbb{Z}_2$
- Column space, null space, and rank defined over $\mathbb{Z}_2$.

##### 3.2 Solvability Conditions
- Existence of solutions determined by consistency.
- Uniqueness determined by the null space.

---

#### 4. Enhancement Ideas
- Variations of the puzzle.
- Alternative board sizes and interaction rules.

____
</details>

---
# 5. Linear Transformations
<details><summary><a href="09_LinearTransformations.ipynb" style="display:inline-block; width:9cm;">09_LinearTransformations.ipynb</a>
Linear transformations: geometric interpretation and algebraic representation. One-to-One and Onto
</summary>


### Contents

#### 1. Introduction

##### 1.1 Functions Transforming Vectors to Vectors
- Transformations $T:\mathbb{F}^N\to\mathbb{F}^M$; domain, codomain, range.

##### 1.2 Geometric Representations
- Examples of transformations visualized geometrically (input/output point sets).

##### 1.3 Basic Concepts
- Definitions: range; one-to-one; onto (injective/surjective/bijective).
- Example: one-to-one / onto from the geometry of the range.

##### 1.4 Special Case: Linear Transformations
- Definition of linearity (additivity and homogeneity), combined as
  $\qquad T(\alpha u+\beta v)=\alpha T(u)+\beta T(v)$.
- Two examples illustrating linear vs. non-linear behavior.

---

#### 2. Useful Theorems

##### 2.1 Linearity over Linear Combinations
- Theorem: linear maps distribute over linear combinations.
- Important example using explicit vectors/scalars to illustrate the rule.

##### 2.2 Matrix Representation of Linear Maps
- Theorem: any linear $T:\mathbb{F}^N\to\mathbb{F}^M$ has a matrix $A$ with
  $\;\; T x = A x$.
- Construction idea: columns of $A$ are $T e_i$.

##### 2.3 Composition
- Theorem: composition of linear transformations is linear.
- Composition corresponds to matrix multiplication.

##### 2.4 One-to-one and Onto Transformations
- Theorem: for $y=Ax$,
  - one-to-one iff echelon form has a pivot in every column,
  - onto iff echelon form has a pivot in every row.
- Examples showing how these conditions fail/succeed.

---

#### 3. Finding the Matrix of a Linear Transformation
- Uses $T e_i$ to build the matrix of $T$.
- Examples mapping $\mathbb{F}\to\mathbb{F}^M$ and $\mathbb{F}^N\to\mathbb{F}^M$.

---

### Examples
- Multiple geometric examples in low dimensions.
- Examples constructing $A_T$ from images of basis vectors.
- Examples classifying transformations as one-to-one / onto via pivots.

____
</details>

<details><summary><a href="10a_LinearTx_Examples.ipynb" style="display:inline-block; width:9cm;">10a_LinearTx_Examples.ipynb </a>
Examples in $\mathbb{R}^2$: dilations, rotations, reflections, projections; composition of linear transformations
</summary>

### Contents

#### 1. Review: Basic Definitions and Theorems

##### 1.1 Definition
- Linear transformation $T:U\to V$ (additivity and scalar homogeneity; combined linear-combination rule).

##### 1.2 One-to-One and ONTO Transformations
- One-to-one / onto language and criteria (linked back to pivot structure / solvability viewpoint).

---

#### 2. Coordinate Vectors and Matrix Representations
- Coordinate vector viewpoint: expressing $b$ as a linear combination of basis vectors (pivot columns).
- Example: extracting a basis by removing a non-pivot column; interpreting the resulting coordinate vector.

##### 2.1 $\mathscr{P}_2[-1,1]\to\mathbb{R}^3$ Example
- Polynomial space mapped into $\mathbb{R}^3$ via coordinates/evaluation-style representation.
- Emphasis on choosing bases in domain/codomain to obtain a matrix for $T$.

---

#### 3. Geometric Linear Transformations in $\mathbb{R}^2$

##### 3.1 Rotation / Reflection / Combined Transformation
- Rotation and reflection matrices used as canonical linear transformations.
- Example(s) specifying an angle and forming the corresponding matrix.
- Combined transformations treated via matrix products.

##### 3.2 Homogeneous Coordinates
- Homogeneous-coordinate framework for representing planar transformations in augmented form.

---

#### 4. Take Away
- Build matrices from basis images / coordinate conventions.
- Compose transformations by multiplying matrices.
- Homogeneous coordinates package transformations into a single matrix framework.

____
</details>


<details><summary><a href="10b_LinearTx_SpaceOfFunctions_Examples.ipynb" style="display:inline-block; width:9cm;">10b_LinearTx_SpaceOfFunctions_Examples.ipynb</a>
Matrix representation of $T:U\rightarrow V$ between vector spaces; examples with function spaces
</summary>

### Contents

#### 1. Application: A Matrix Representation for a Linear Transformation
- Theorem for $T:\mathbb{F}^N\to\mathbb{F}^M$:  
  $\qquad T x = A_Tx,\quad A_T=(Te_1\mid T e_2\mid\cdots\mid T e_N)$.
- Example illustrating column-by-column construction.

---

#### 2. Finite-Dimensional Vector Spaces Can be Represented by $\mathbb{F}^n$
- Given a basis $\{v_1,\dots,v_n\}$ of $V$, define the linear coordinate map $D:V\to\mathbb{F}^n$ by $Dv_i=e_i$.
- Remarks: $D$ is invertible; computations in $V$ can be done via coordinates in $\mathbb{F}^n$.

---

#### 3. Examples of Linear Transformations on Function Spaces
- Multiple examples defining $T$ on a function space with a chosen basis, then computing the matrix of $T$ in coordinates.
- Includes an “implementation using SymPy” section for carrying out the coordinate computations.

##### Note on Notation
- Explicit reminder in the notebook: use $\mathbb{F}^n$ for the coordinate space (rather than reusing $U$).

---

#### 4. Take Away
- Choose bases $\rightarrow$ build coordinate map $\rightarrow$ represent $T$ by a matrix.
- Function-space examples reduce to linear algebra in $\mathbb{F}^n$.

____
</details>


<details><summary><a href="10c_GeoGebra.ipynb" style="display:inline-block; width:9cm;">10c_GeoGebra.ipynb</a>Interactive GeoGebra applet for visualizing planar linear transformations
</summary>

### Contents

**General Information and Setup**  
Explanation of the GeoGebra-based environment used to visualize linear transformations in the plane.  
Overview of how matrices, vectors, and images of vectors will be displayed.

**Applet Initialization**  
Cells that configure the panel layout, widgets, and embedded GeoGebra applet.  
Instructions for running the setup cells in sequence.

**Specifying a Matrix**  
Controls for entering a $2\times2$ matrix directly in the notebook and passing it to the applet.  
Visualization of the action of the matrix on basis vectors and on a grid.

**Presets: Rotations and Reflections**  
Convenience routines to load standard rotation and reflection matrices.  
Support for experimenting with different angles and axes.

**Exploration of Linear Transformation Geometry**  
By varying the matrix entries and presets, the user can observe:  
- stretching and squeezing along preferred directions,  
- rotations that preserve lengths and angles,  
- reflections across lines through the origin,  
all within an interactive geometric interface.

____
</details>

<details><summary><a href="10d_LinearTx_Examples.ipynb" style="display:inline-block; width:9cm;">10d_LinearTx_Examples.ipynb</a>
Change of coordinates; examples in $\mathbb{R}^2$ and polynomial spaces; composition of linear maps
</summary>

### Contents

#### 1. Coordinate Vector, Change of Coordinates

##### 1.1 $\mathbb{R}^2\to\mathbb{R}^2$ Example
- Coordinate-vector interpretation of $Ax=b$ as expressing $b$ in the column basis of $A$.
- Illustration comparing standard coordinates vs. coordinates in a nonstandard basis.

##### Solve for the Coordinate Vector
- Solving for coordinates relative to a chosen basis.

---

#### 2. Linear Transformation Examples

##### 2.1 Transformations Between Coordinate Systems
- Change-of-basis viewpoint: represent a transformation by a matrix once bases are fixed.

##### 2.1.1 Transformation Example (Function/Polynomial Coordinates)
- Example computing the coordinate vector of a polynomial relative to a polynomial basis.
- Interprets the coordinate map as a linear transformation into $\mathbb{R}^n$.

##### Use the Matrix Transformation
- Uses the matrix form to apply the transformation to inputs in coordinates.

##### 2.3 Conclusion
- Coordinates and basis choice control the matrix representation.
- Coordinate maps are linear and (in the examples) one-to-one and onto onto the coordinate space.

____
</details>

---
<details><summary><a href="NonLinearTransformations.ipynb" style="display:inline-block; width:9cm;">NonLinearTransformations.ipynb</a>
Visual comparison of linear and nonlinear transformations; failure of linearity conditions
</summary>

### Contents

#### 1. Effect of Linear and NonLinear Transformations
##### 1.1 Random Linear Transform
- Applies a randomly chosen linear transformation to a data set and compares the effect on geometry.

##### 1.2 Non-linear Transform of the Data
- Applies a nonlinear transformation to the same data to illustrate qualitative differences from linear maps.

---

#### 2. Suggestion
- Brief concluding suggestion connecting the experiment to modeling/feature design.

____
</details>


<details><summary><a href="Projections.ipynb" style="display:inline-block; width:9cm;">Projections.ipynb</a>
Dual bases; oblique and orthogonal projections; relation to diagonalizable matrices and QR
</summary>

### Contents

#### 1. Dual Basis
- For invertible $V=[v_1\;\cdots\;v_n]$, define $U=V^{-1}$ and interpret rows of $U$ as the dual basis.
- Coordinate recovery via dot products with dual vectors.

---

#### 2. Oblique Projections
- Decomposition of a vector using $b=Vx$ rewritten via $x_i=u_i\cdot b$.
- Projection matrices built from outer products $v_i u_i^T$; components generally not orthogonal.

---

#### 3. Orthogonal Projections
- Special case: orthonormal basis $Q$ with $U=Q^T$.
- Rank-1 projection onto a unit vector:  
  $\qquad P_i=q_i q_i^T$.
- General orthogonal projection onto $\operatorname{span}(A)$:  
  $\qquad P=A(A^T A)^{-1}A^T$.
- Connection to the normal equations (least-squares shortcut noted).

---

#### 4. Diagonalizable Matrices
- Projection-matrix viewpoint for diagonalizable/symmetric cases.
- Spectral expansion written using orthogonal projectors:  
  $\qquad A=\sum_i \lambda_i q_i q_i^T$.

---

#### 5. Application Examples
##### 5.1 $A=QR$
- Gram–Schmidt described via repeated orthogonal projections; $QR$ context.

##### 5.2 Projection Problem (Spring 14)
- Build projection matrices onto the four fundamental subspaces (column/row/null/left-null):
  - basis identification via pivots and elimination data,
  - then form orthogonal projection matrices using $P=A(A^T A)^{-1}A^T$ (with appropriate basis matrices).

____
</details>


---
# 6. Length, Areas, Determinants, Orthogonality
<details>
<summary>
<a href="20_LengthOrthogonality.ipynb" style="display:inline-block; width:9cm;">
20_LengthOrthogonality.ipynb
</a>
Vector length, inner product, orthogonality, angles; geometric and algebraic characterizations
</summary>

### Contents

#### 1. Orthogonality

##### 1.1 Orthogonal and Orthonormal Vectors
- Definitions of orthogonal and orthonormal sets.
- Inner product conditions.

##### 1.2 Consequences
- Simplified coordinate computation.
- Independence guaranteed for nonzero orthogonal vectors.

---

#### 2. Orthogonal Bases

##### 2.1 Expansion in an Orthogonal Basis
- Coordinates obtained via dot products.
- Contrast with general (non-orthogonal) bases.

##### 2.2 Pythagorean Theorem
- Norm decomposition for sums of orthogonal vectors.
- Energy interpretation.

---

#### 3. Orthogonal Projections

##### 3.1 Projection onto a Vector
- Rank-1 projection using outer products.

##### 3.2 Projection onto a Subspace
- Projection onto $\operatorname{span}(Q)$ for orthonormal $Q$.
- Connection to least squares previewed.

---

#### 4. Take Away
- Orthogonality simplifies geometry and computation.
- Projections and coordinates become transparent.

____
</details>


<details>
<summary>
<a href="21_ProjectionsGramSchmidt.ipynb" style="display:inline-block; width:9cm;">
21_ProjectionsGramSchmidt.ipynb
</a>
Orthogonal projection; least-squares geometry; Gram–Schmidt orthogonalization
</summary>

### Contents

#### 1. Motivation
- Replace a general basis with an orthonormal one.
- Preserve span while improving numerical and geometric properties.

---

#### 2. Gram–Schmidt Process

##### 2.1 Orthogonalization
- Iterative subtraction of projections.
- Construction of orthogonal vectors spanning the same space.

##### 2.2 Normalization
- Scaling to produce orthonormal vectors.

---

#### 3. QR Decomposition

##### 3.1 Construction
- Columns of $Q$ from Gram–Schmidt.
- Upper-triangular matrix $R$ collects coefficients.

##### 3.2 Interpretation
- $A = QR$ as change of basis plus coordinates.
- Link to least squares and projections.

---

#### 4. Take Away
- Gram–Schmidt produces orthonormal bases systematically.
- QR factorization emerges naturally.

____
</details>



<details>
<summary>
<a href="ModifiedGramSchmidt.ipynb" style="display:inline-block; width:9cm;">
ModifiedGramSchmidt.ipynb
</a>
Numerically stable version of Gram–Schmidt; geometric structure; orthonormality verification
</summary>

### Contents

#### 1. Motivation
- Classical Gram–Schmidt is sensitive to rounding errors.
- Modified version improves numerical stability.

---

#### 2. Modified Gram–Schmidt Algorithm
- Orthogonalize one vector at a time against the current orthonormal set.
- Update vectors incrementally.

---

#### 3. Comparison with Classical Gram–Schmidt
- Same theoretical result.
- Different numerical behavior.

---

#### 4. Take Away
- Algorithmic order matters in numerical linear algebra.
- Modified Gram–Schmidt preferred in practice.

____
</details>

____
<details>
<summary>
<a href="21a_LinearTx_NormalEquations.ipynb" style="display:inline-block; width:9cm;">
21a_LinearTx_NormalEquations.ipynb
</a>
Least squares via linear transformations; normal equations; geometric meaning of projection
</summary>

### Contents

#### 1. Overdetermined Systems
- Linear systems with more equations than unknowns.
- Exact solutions may not exist.

---

#### 2. Least-Squares Approximation

##### 2.1 Geometric Viewpoint
- Approximate $Ax \approx b$ by projecting $b$ onto $\mathscr{C}(A)$.
- Residual orthogonal to the column space.

##### 2.2 Normal Equations
- Derivation of  
  $\qquad A^T A x = A^T b$.
- Square system encoding optimality.

---

#### 3. Solution Methods
- Solve via normal equations.
- Alternative via QR factorization.

---

#### 4. Take Away
- Least squares is projection onto a subspace.
- Orthogonality explains optimality conditions.

____
</details>

____
<details><summary><a href="MeanAndStdProjections.ipynb" style="display:inline-block; width:9cm;">MeanAndStdProjections.ipynb</a>
Projection viewpoint on mean, mean-removal, centered data matrices, covariance, and correlation
</summary>

### Contents

#### 1. Mean and Deviation from the Mean

##### 1.1 The Mean of a Set of Samples
- Introduces the all-ones vector  
  $\qquad o=(1,1,\dots,1)^T \in \mathbb{R}^n$.
- Mean of a data vector $x$ written as a projection:
  $\qquad \mu=\dfrac{o^T x}{o^T o}$.
- Projection matrix onto the constant subspace:
  $\qquad P_o=\dfrac{o\,o^T}{o^T o}$.

##### 1.2 Deviation from the Mean
- Decomposition:
  $\qquad x = P_o x + (I-P_o)x$.
- Mean component and deviation component are orthogonal.

---

#### 2. Standard Deviation, Covariance, and Correlation

##### 2.1 Standard Deviation
- Standard deviation interpreted as the norm of the deviation vector.
- Energy split explained via orthogonality.

##### 2.2 Covariance and Correlation
- Covariance defined via inner products of deviation vectors.
- Correlation obtained by normalization.

##### 2.3 Covariance and Correlation Matrices
- Matrix formulation for multiple variables.
- Interpretation in terms of projections and inner products.
- Conversion between Covariance and Correlation Matrices

---

### Take Away
- Basic statistical quantities arise from orthogonal projections.
- Mean, variance, covariance, and correlation have clear geometric meaning.

____
</details>


<details>
<summary>
<a href="LeastMeanSquares.ipynb" style="display:inline-block; width:9cm;">
LeastMeanSquares.ipynb
</a>
Least-mean-squares (LMS) method; iterative estimation; gradient interpretation
</summary>

### Contents

#### 1. Perform an Experiment
- Synthetic data generated with noise.
- Visualization motivates approximation rather than exact interpolation.

---

#### 2. Conjecture a Linear Model

##### 2.1 Solve the Resulting Normal Equations
- Model written as  
  $\qquad A x \approx y$.
- Least-mean-squares solution obtained from  
  $\qquad A^T A x = A^T y$.

###### 2.1.1 Compute and Solve the Normal Equations
- Explicit construction of $A^T A$ and $A^T y$.

###### 2.1.2 Compute the Projections
- Projection of $y$ onto $\mathscr{C}(A)$.
- Residual orthogonal to the column space.

---

#### 2.2 Polynomial and Nonlinear Models
- Models of increasing complexity:
  - quadratic with sinusoidal term,
  - higher-degree polynomials.
- Comparison of fit quality as model complexity increases.

---

#### 3. Sampling Issues
- Discussion of poor conditioning with equally spaced points.
- Introduction of **Chebyshev nodes** as improved sample points.

---

### Take Away
- Least-mean-squares fitting is projection onto a model space.
- Model choice and sampling strongly affect results.

____
</details>


<details>
<summary>
<a href="Regression.ipynb" style="display:inline-block; width:9cm;">
Regression.ipynb
</a>
Linear regression; least squares; fitting lines and curves; residual analysis
</summary>

### Contents

#### 1. Create Some Data

##### 1.1 Pandas DataFrame
- Data organized into columns.
- Columns manipulated algebraically to build models.

##### 1.2 Visual Inspection
- Plots used to assess structure and noise.

---

#### 2. Fit a Model

##### 2.1 Linear Regression
- Model:
  $\qquad y = a + b x$.
- Written in matrix form:
  $\qquad A x = y + e$.
- Normal equations used to compute best-fit parameters.

---

#### 3. Extensions
- Discussion of richer models.
- Emphasis on least-squares interpretation rather than exact fitting.

---

#### 4. Sampling Strategy
- Revisits Chebyshev nodes as superior sampling points.
- Highlights numerical stability considerations.

---

### Take Away
- Regression is least-squares approximation in matrix form.
- Design matrix encodes the chosen model.

____
</details>



<details>
<summary>
<a href="Orthogonal_Decomposition_Example.ipynb" style="display:inline-block; width:9cm;">
Orthogonal_Decomposition_Example.ipynb
</a>
Orthogonal decomposition into parallel and perpendicular components; projection interpretation
</summary>

### Contents

#### 1. Drawing Routines
- Utilities for visualizing vectors and planes in 3D.
- Used throughout the notebook to display geometry.

---

#### 2. Normal Equation and Decomposition (3D Example)

##### 2.1 Plane Defined by Basis Vectors
- Two independent vectors $\{a_1,a_2\}$ define a plane.
- A third vector $b$ lies outside the plane.

##### 2.2 $Ax=b$ with More Than One Solution
- System with non-unique solutions.
- Identification of solution space geometry.

###### 2.2.1 Implementation
- Computation of projections and solutions.

###### 2.2.2 Display
- Visualization of components and residuals.

---

#### 2.3 Reduced Problem
- Reduced system obtained via elimination.
- Clear separation of components parallel and orthogonal to the plane.

---

### Take Away
- Normal equations enforce orthogonality of the residual.
- Least-squares solutions correspond to geometric projections.

____
</details>

____
<details>
<summary>
<a href="22_QR_Decomposition.ipynb" style="display:inline-block; width:9cm;">
22_QR_Decomposition.ipynb
</a>
QR decomposition; orthonormal bases; solving least squares; geometric viewpoint
</summary>

### Contents

#### 1. Gram–Schmidt and the QR Decomposition

##### 1.1 Reformulate Gram–Schmidt: $A=QR$
- Gram–Schmidt written in terms of vectors $w_i$ and normalized vectors $q_i$.
- Produces the factorization
  $\; A = Q R \;$
  with orthonormal columns in $Q$ and upper-triangular $R$.

##### Example
- Gram–Schmidt applied to polynomials $1,x,x^2,\dots$ using an integral inner product; normalization convention $q_i(x)=w_i(x)/w_i(1)$ (Legendre-polynomial context).

---

#### 2. QR and the Normal Equation

##### 2.1 Multiplication by $W^T$ rather than $A^T$
- Uses the relationship between the column spaces of $A^T$ and $W^T$ to eliminate the perpendicular component $b_\perp$.
- Derives the standard QR simplification of least squares $R x = Q^T b$.
- Hand-computation remark: reduce further to $W^T A x = W^T b$.

##### 2.2 Example (projection onto a plane in $\mathbb{R}^4$)
- Compute the orthogonal projection matrix onto
  $\qquad S=\operatorname{span}\{a_1,a_2\}$
  and decompose a given $b$ into $b_\parallel\in S$ and $b_\perp\in S^\perp$.
- Solves for the projection coefficients using the reduced triangular system.

---

#### 3. Take Away
- Gram–Schmidt $\Rightarrow$ $A=QR$.
- Least squares via QR reduces to triangular solves.

____
</details>


<details>
<summary>
<a href="23_MetricSpaces.ipynb" style="display:inline-block; width:9cm;">
23_MetricSpaces.ipynb
</a>
Metrics, distance functions, induced norms; completeness; examples
</summary>

### Contents

#### 1. Inner Products

##### 1.1 Inner Products and Metrics in $\mathbb{R}^n$
- Uses $<u,v>$ notation.
- Examples of weighted inner products (different “cost” along coordinate axes).
- Induced norm and metric:  
  $\qquad \Vert u\Vert =\sqrt{<u,u>},\quad d(u,v)=\Vert v-u\Vert $.

##### 1.2 Inner Products in Function Spaces
- “Functions are vectors” viewpoint; sampled functions vs. continuous functions.
- Example inner products defined by integrals (including weighted integrals).

##### Examples
- Weighted-coordinate inner product in $\mathbb{R}^3$ (explicit formula).
- Function-space inner products on an interval (integral forms).

---

#### 2. Orthogonality
- Definition:  
  $\qquad u\perp v \iff <u,v>=0$.

##### Example
- Orthogonality condition under a weighted inner product in $\mathbb{R}^2$ leading to a linear constraint on components of $v$.

---

#### 3. Gram–Schmidt
- Gram–Schmidt works with any specified inner product.

##### Example (polynomials on $[-1,1]$)
- Applies Gram–Schmidt to  
  $\qquad f_1(x)=1,\; f_2(x)=x,\; f_3(x)=x^2$  
  using  
  $\qquad <f,g>=\int_{-1}^1 f(x)g(x)\,dx$,  
  showing Step 1 / Step 2 / Step 3 and producing normalized orthogonal polynomials.

____
</details>



<details>
<summary>
<a href="Orthogonality.ipynb" style="display:inline-block; width:9cm;">
Orthogonality.ipynb
</a>
Orthogonality in $\mathbb{R}^n$; orthonormal sets; orthogonal complement; applications
</summary>

### Contents

#### 1. Inner Product Spaces and Metrics

##### 1.1 Basic Definitions
- Inner product, norm, metric; examples across $\mathbb{F}$.

##### 1.2 Inequalities, Angle, Orthogonal Vectors
- Cauchy–Schwarz:  
  $\qquad |<u,v>|\le \Vert u\Vert \,\Vert v\Vert $.
- Generalized cosine/angle definition via normalized inner product.
- Orthogonality condition $<u,v>=0$.

---

#### 1.3 Fundamental Theorem of Linear Algebra (Part 2)
##### 1.3.1 Main definitions and theorem
- Orthogonal vectors are linearly independent.
- Orthogonality relations for a matrix $A$:
  - $\mathscr{R}(A)\perp \mathscr{N}(A)$ in $\mathbb{R}^N$,
  - $\mathscr{C}(A)\perp \mathscr{N}(A^T)$ in $\mathbb{R}^M$.
- Double-orthogonal identities:
  $\qquad (U^\perp)^\perp = U$,
  and orthogonal complement pairing statements.
- “Union of bases” statements: bases for paired orthogonal subspaces combine to a basis of the ambient space.

##### 1.3.2 Decompose a vector (naive method)
- Decompose
  $\;\; b=b_\parallel+b_\perp$  
  using bases for $\mathscr{C}(A)$ and $\mathscr{N}(A^T)$, then solve for coefficients via orthogonality.

##### 1.3.3 Decompose a vector (normal-equation method)
- Uses the normal equation to obtain $b_\parallel$ directly from $A$.

---

#### 2. The Normal Equation

##### 2.1 Basic properties
- Normal equation and its geometric meaning (orthogonal residual).

##### 2.2 Examples
- 2.2.1 Split a vector into parallel/perpendicular components.
- 2.2.2 Distance of a vector from a $k$-plane.
- 2.2.3 Special case: mutually orthogonal (and orthonormal) columns, yielding diagonal simplifications.

---

#### 3. Projection Matrices, Orthogonal Matrices, Unitary Matrices

##### 3.1 Orthogonal projection matrices
- Projection matrix
  $\;\; P=A(A^T A)^{-1}A^T\;\;$
  (full column rank case).
- Examples section emphasizes constructing projections via $P$ (and remark about projecting onto a line via a basis for $\mathscr{N}(A^T)$).

##### 3.2 Orthogonal and unitary matrices
- Definitions:  
  $\qquad Q^TQ=I$ (orthogonal), $\qquad Q^H Q=I$ (unitary).
- Major named examples: Haar matrix (orthogonal) and DFT matrix (unitary).
- Key property: preserves lengths and angles.

____
</details>



<details>
<summary>
<a href="QR_orthogonal_polynomials.ipynb" style="display:inline-block; width:9cm;">
QR_orthogonal_polynomials.ipynb
</a>
Constructing orthogonal polynomials via QR; numerical orthogonalization of function samples
</summary>


### Contents

#### Inner Product
- Polynomial inner product on $(-1,1)$ defined by an integral:  
  $\qquad <f,g>=\int_{-1}^1 f(x)g(x)\,dx$.

---

#### 1. Gram–Schmidt Procedure
- Gram–Schmidt formulas for $w_i(x)$ and orthogonalization via inner products.
- Produces orthogonal polynomials; normalization convention stated in the notebook.

##### Example
- Run Gram–Schmidt on  
  $\qquad 1,x,x^2,x^3,x^4,x^5,x^6$
  to obtain (normalized) Legendre polynomials.

---

#### 2. Convert Power Series to Legendre Expansion
- Express a polynomial/function in the Legendre basis using projection coefficients:  
  $\qquad\displaystyle{ f(x)=\sum_{i=0}^k \frac{<f,p_i>}{<p_i,p_i>}p_i(x)}$.

##### Example
- Conversion of a polynomial expressed in the power basis into a Legendre-polynomial expansion.

---

#### 3. Fit a Function
- Uses the truncated expansion as a best-approximation (least-squares) polynomial fit with respect to the induced norm.

##### Example
- Fit a non-polynomial function by projecting onto the span of the first $k$ Legendre polynomials.

____
</details>

____
<details>
<summary>
<a href="13_WedgeProduct.ipynb" style="display:inline-block; width:9cm;">
13_WedgeProduct.ipynb
</a>
Exterior algebra; wedge product; oriented area and volume; multilinearity
</summary>

### Contents

#### 1. The Wedge Product
<strong>Design a vector product to compute areas</strong>: define $\;a\wedge b\;$  
to capture the oriented area of the parallelogram spanned by $a,b$.

##### 1.1 Changing the Length of a Vector
- Scaling laws:  
  $\qquad (\alpha a)\wedge b=\alpha(a\wedge b),\quad a\wedge(\beta b)=\beta(a\wedge b)$.
- Special cases highlighted (e.g. $\alpha=0$, $\alpha=-1$).

##### 1.2 Anticommutativity
- Orientation reversal:  
  $\qquad a\wedge b = -(b\wedge a)$.
- Special cases (e.g. $a=b \Rightarrow a\wedge a=0$).

##### 1.3 Distributivity over Vector Addition
- Bilinearity:  
  $\qquad (a+c)\wedge b = a\wedge b + c\wedge b$ and similarly in the second slot.
- Geometric sections: “Area of a parallelogram”, “Splitting a parallelogram”.

##### 1.4 Generalization to More Vectors
- **Blades / $k$-blades**:  
  $\qquad a_1\wedge a_2\wedge\cdots\wedge a_k$.
- Associativity + linearity; swapping vectors changes sign; repeated vectors give zero (“moving vectors in a blade”, “repeated vectors in a blade”).

##### 1.5 Example Computations
- Examples with **two vectors** (expanded using bilinearity/anticommutativity; introduces index notation like $e_{21}=e_2\wedge e_1$  
  and the orientation interpretation).
- Example with **two vectors in 3D**, with a remark **comparing wedge rules to cross-product rules** (and noting cross product is 3D-only).
- Example with **three vectors** (volume / hypervolume viewpoint).

---

### Examples
- 2-vector computation in the $e_i$ basis with a signed-area interpretation.
- 2-vector computation in $\mathbb{R}^3$ with an explicit comparison to the cross product.
- 3-vector wedge example illustrating hypervolume and sign changes under swaps.

---

### Conceptual Insights
- Wedge product is a multilinear, alternating product encoding oriented area/volume.
- Its algebraic rules (scaling, distributivity, sign changes) are designed to match geometric hypervolume behavior.
- Sets up the determinant as the scalar that measures wedge-product hypervolume relative to a reference.

____
</details>



<details>
<summary>
<a href="14_Determinants.ipynb" style="display:inline-block; width:9cm;">
14_Determinants.ipynb
</a>
Determinant definitions; multilinearity; geometric meaning; properties
</summary>

### Contents

#### 1. Some Formulae

##### 1.1 Laplace Expansion, Leibniz Formula
- Cofactors/minors introduced and used in Laplace expansion.
- Leibniz (permutation) formula stated.

##### 1.2 Bilinearity
- Determinant properties emphasized through linearity in columns/rows (as presented in the notebook).
- Includes a short examples block.

##### 1.3 Scalar and Matrix Products
- Determinant and scalar factors; determinant of products of matrices.
- Main multiplicative formula:  
  $\qquad \Vert A B \Vert =\Vert A\Vert\,\Vert B \Vert$.
- Theorems/special cases summarized (including immediate consequences such as determinant of inverses/powers as used in the notebook).

##### Example (in this section)
- **Determinant of a projection matrix**: for $P^2=P$, taking determinants yields  
  $\qquad \Vert P \Vert^2= \Vert P\Vert \Rightarrow \Vert P \Vert\in\{0,1\}$.

---

#### 2. The Determinant by Gaussian Elimination

##### 2.1 A Practical Algorithm
- Uses elimination to compute $|A|$ efficiently (tracking row operations / pivot effects as in the notebook’s algorithm).
- Remarks section clarifies how row operations change determinants.

##### 2.2 Existence of the Inverse
- Connects
  $\;\; ExampleA Example\ne 0\;\;$
  to invertibility, in the elimination framework.

---

#### 3. Cramer’s Rule, Formula for the Inverse of a Matrix

##### 3.1 Solving $\textbf{A x = b}$ with the Wedge Product
- 3.1.1 The idea: wedge-product/determinant viewpoint for solving for components.
- 3.1.2 A $2\times 2$ example (with a numerical/geometric interpretation section).
- 3.1.3 General case (Cramer’s rule form).

##### 3.2 A Formula for the Inverse
- Presents the inverse formula in determinant/cofactor form.
- Includes an example showing how to generate inverses with integer entries (as a construction example).

---

### Examples
- Determinant of a projection matrix ($ExampleP Example\in\{0,1\}$).
- Determinant computed by Gaussian elimination with determinant-tracking remarks.
- Cramer’s rule: a worked $2\times 2$ illustration plus the general statement.
- Inverse formula example (integer-entry inverse generation).

---

### Conceptual Insights
- Determinant is treated both as (i) a multilinear alternating quantity (wedge-product motivation) and (ii) a computable scalar via elimination.
- Multiplicativity $\;\;\Vert A B \Vert = \Vert A \Vert\ \Vert B\Vert$ underpins fast determinant computation and structural results.
- Cramer’s rule and the cofactor inverse formula are presented as determinant-based solution tools.

____
</details>

____
# 7. Eigendecomposition
<details><summary><a href="17_EigenAnalysis.ipynb" style="display:inline-block; width:9cm;">17_EigenAnalysis.ipynb</a>
Eigenvalue–eigenvector analysis; eigenspaces; geometric interpretation of linear transformations
</summary>

### Contents

#### 1. Special Directions for $y=Ax$

##### 1.1 Introduction
- Motivation: find “good” bases for a linear map $\mathbb{R}^n\to\mathbb{R}^n$.

##### 1.1.1 Examples
- Orthogonal projections
- Reflection through a plane
- Rotation about an axis
- Dilation
- $k$-planes (special invariant subspaces, not only directions)

##### 1.2 The Eigenvector/Eigenvalue Problem
- Definition of eigenpair $(\lambda,x)$ from  
  $\qquad Ax=\lambda x$.
- Checking potential eigenvectors by direct substitution.

##### Example
- A concrete matrix with listed candidate eigenvectors/eigenvalues (verification by $A x=\lambda x$).

---

#### 2. Solution of $Ax=\lambda x$

##### 2.1 The Characteristic Polynomial
- Rewrite as a homogeneous system:  
  $\qquad (A-\lambda I)x=0$.
- Define characteristic polynomial  
  $\qquad p(\lambda)=\det(A-\lambda I)$.
- Trace check emphasized as an eigenvalue sanity test.

##### 2.2 Eigenvector/Eigenvalue Computation Examples
- Step-by-step workflow:
  1) solve $p(\lambda)=0$,
  2) find a basis for $\mathscr{N}(A-\lambda I)$ for each eigenvalue,
  3) summarize in a table.

##### Example
- A simple $2\times2$ eigenproblem with explicit characteristic polynomial factorization and eigenspace bases summarized in a table.

##### 2.3 Special Cases
- Repeated eigenvalues and eigenspace dimension (missing pivots discussion).
- Case $\lambda=0$ highlighted.
- Complex eigenvalues introduced and treated as a separate case.

---

#### 3. Take Away
- Explicit algorithm: characteristic polynomial $\to$ eigenvalues, then null spaces $\mathscr{N}(A-\lambda I)$ for eigenvectors, then summary table.

____
</details>



<details>
<summary>
<a href="18_EigenComputations.ipynb" style="display:inline-block; width:9cm;">
18_EigenComputations.ipynb
</a>
Practical computation of eigenvalues and eigenvectors for $2\times 2$ and $3\times 3$ matrices
</summary>

### Contents

#### 1. Stochastic Matrices
- Definitions: right/left stochastic; row/column sums.
- Row-sum/column-sum eigenvalue test using the all-ones vector $\mathscr{1}$.
- Remark: $A$ and $A^T$ share eigenvalues.

##### Example
- “Check for an eigenvalue” by summing rows/columns on an explicit $3\times3$ example.

---

#### 2. Null Space Computations
- Targeted null-space construction for a row-echelon matrix with a single nonzero row.
- Basis vectors built by pairing entries to enforce dot-product zero.

##### Example
- A row-echelon matrix with one nonzero row; explicit null-space basis constructed by the stated method.

---

#### 3. Matrices of Size $2\times2$
- Theory: characteristic polynomial for $2\times2$ matrices.
- Eigenvector basis computed from $\mathscr{N}(A-\lambda I)$.

##### Example
- Full $2\times2$ eigenpair computation (roots + eigenvector basis).

---

#### 4. Matrices of Size $3\times3$ with a Known Non-zero Eigenvalue
- Use a known eigenvalue to simplify finding remaining eigenvalues/eigenvectors.

##### Example
- A $3\times3$ computation where one nonzero eigenvalue is identified first, then the eigenproblem is completed.

---

#### 5. Determinants that Can be Factored
- Techniques/observations for recognizing factorable determinants in characteristic polynomials.

____
</details>


<details><summary><a href="19_Diagonalization.ipynb" style="display:inline-block; width:9cm;">19_Diagonalization.ipynb</a>
Diagonalization; change of basis using eigenvectors; repeated application of a linear operator
</summary>

### Contents

#### 1. The Similarity Transform

##### 1.1 Change of Basis
- Coordinates under a basis matrix $S$; transform rule  
  $\qquad \tilde{A}=S^{-1}AS$.

##### 1.2 Similarity Transform
- Definition and example of similar matrices.
- Similar matrices share eigenvalues; eigenpairs transform with the basis.

##### 1.3 Special Case: A Basis of Eigenvectors
- If $S$ is built from eigenvectors, then  
  $\qquad S^{-1}AS=\Lambda$ (diagonal).

##### Example (worked in steps)
- A $2\times2$ diagonalization:
  Step 1: characteristic polynomial roots  
  Step 2: eigenspace bases  
  Step 3: compute $S^{-1}AS$ and obtain a diagonal matrix.

---

#### 2. Diagonalizable Matrices
- Definition of diagonalizable.
- Non-diagonalizable matrices (counterexample section).
- Special cases:
  - complex eigenvalues (with a summary table),
  - criteria: distinct eigenvalues,
  - symmetric matrices,
  - normal matrices.

---

#### 3. Applications

##### 3.1 Powers of a Diagonalizable Matrix
- Powers of diagonal matrices and transfer to $A^n$ via diagonalization.

##### Example
- An explicit “matrix powers” example using $A=S\Lambda S^{-1}$.

##### 3.2 Functions of a Matrix
- Uses diagonalization to define/compute $f(A)$ from $f(\Lambda)$.

---

#### 4. Take Away
- Similarity expresses a linear map in a new basis; eigenvector bases diagonalize when available; diagonalization enables fast powers and matrix functions.

____
</details>



<details>
<summary>
<a href="DifferenceEquations.ipynb" style="display:inline-block; width:9cm;">
DifferenceEquations.ipynb
</a>
Linear first-order recurrence relations; state-transition matrices; trajectories and long-term behavior
</summary>

### Contents

#### 1. Code: Display Trajectories
- Output formatting utilities.
- Construct random $2\times2$ matrices with prescribed eigenvectors.
- Iteration scheme for generating trajectories $y_n$.
- Plotting/monitoring tools.

##### Examples
- Simple trajectory plot.
- “Graphics Monitor” class demonstration.

---

#### 2. Difference Equations: Iterations of a Linear Map

##### 2.1 Definition
- System
  $\;\; y_n = Ay_{n-1},\quad y_0\ \text{given}$.

##### Example
- A concrete $(u_n,v_n)$ system rewritten as $y_n=Ay_{n-1}$.

##### 2.2 Solution
- By induction:  
  $\qquad y_n=A^n y_0$.
- If $A=S\Lambda S^{-1}$:  
  $\qquad y_n=S\Lambda^n S^{-1}y_0$ (explicitly referenced to 19_Diagonalization).

##### Examples
- Examples computing/plotting $y_n$ using the $A^n y_0$ form.

---

#### 2.3 Behavior as $n\to\infty$
##### 2.3.1 Real Eigenvalues
- Long-term behavior discussed via $|\lambda|$ cases; straight-line divergence noted.
- Includes an exercise block.

##### 2.3.2 Complex Eigenvalues
- Spiral/rotation-type behavior tied to complex eigenvalues.

____
</details>


<details><summary><a href="MarkovChains.ipynb" style="display:inline-block; width:9cm;">MarkovChains.ipynb</a>
Markov chains; transition matrices; steady states; long-term stochastic behavior
</summary>

### Contents

#### 1. Code
- Create random $2\times2$ matrices with chosen eigenvalues.
- Phase portrait utilities.
- Pretty-print routine.

---

#### 2. Stochastic Matrix

##### 2.1 Definitions
- Probability vector definition.
- Right/left/doubly stochastic matrix definitions.
- Convention used: columns are probability vectors (left stochastic matrices).

##### Example (Markov chain setup)
- Socioeconomic-class transition example:
  - state space $\{\text{Rich, Middle, Poor}\}$,
  - transition graph and transition matrix $P$ with column indexing “starting state”.

---

#### 2.2 Evolution of the Probability Vector
- Iteration:  
  $\qquad v_{n+1}=Pv_n$ (with the notebook’s column-stochastic convention).

##### 2.3 Phase Curves and Phase Portraits
- Visualizes trajectories of $v_n$ under iteration.

##### 2.4 Eigenvalues and Eigenvectors of Positive Stochastic Matrices
- Focus on the dominant eigenvalue/eigenvector behavior for positive stochastic matrices.

##### Example
- A concrete positive stochastic matrix example illustrating eigenstructure and long-term behavior.

---

#### 3. Take Away
- Markov dynamics are repeated multiplication by a stochastic matrix; eigenstructure organizes long-term behavior; phase portraits visualize convergence.

____
</details>

---
<details><summary><a href="ComplexEigenProblems.ipynb" style="display:inline-block; width:9cm;">ComplexEigenProblems.ipynb</a>
Complex eigenvalues; polar form; rotations and oscillatory linear dynamics
</summary>

### Contents

#### 1. Complex Eigenvalues from Real Matrices
- Review: real matrices may have complex eigenvalues.
- Eigenpairs appear in complex-conjugate pairs.

##### Example
- A real $2\times2$ matrix with no real eigenvalues.
- Explicit computation of complex eigenvalues and eigenvectors.

---

#### 2. Interpreting Complex Eigenpairs
- Relationship between complex eigenvalues and rotations/scalings.
- Connection to oscillatory behavior in linear systems.

##### Example
- Iteration $x_{k+1}=Ax_k$ producing spirals in the plane.

---

#### 3. Real Representation
- Expressing complex eigenmodes using real sine/cosine components.
- Link to block diagonal real canonical form.

---

### Take Away
- Complex eigenvalues encode rotation and growth/decay.
- Real matrices can be fully understood using complex eigenanalysis.

____
</details>


<details><summary><a href="CirculantMatrices.ipynb" style="display:inline-block; width:9cm;">CirculantMatrices.ipynb</a>
Circulant matrices; discrete Fourier basis; diagonalization via DFT; convolution interpretation
</summary>

### Contents

#### 1. Circulant Matrices
- Definition: each row is a cyclic shift of the previous row.
- Specified by a single generating row.

##### Example
- Explicit construction of a small circulant matrix from its first row.

---

#### 2. Eigenvectors
- Fourier modes are eigenvectors of every circulant matrix.
- Discrete complex exponentials introduced.

##### Example
- Verification that a Fourier vector is an eigenvector.

---

#### 3. Eigenvalues
- Eigenvalues obtained from the discrete Fourier transform of the first row.

##### Example
- Compute all eigenvalues of a circulant matrix via FFT-style formula.

---

#### 4. Diagonalization
- Circulant matrices diagonalized by the Fourier matrix:  
  $\qquad C = F^H\ \Lambda F$.

---

### Take Away
- Circulant matrices are exactly the matrices diagonalized by the DFT.
- Fast algorithms follow directly from this structure.

____
</details>


<details><summary><a href="GreshgorinCircles.ipynb" style="display:inline-block; width:9cm;">GreshgorinCircles.ipynb</a>
Gershgorin disks; eigenvalue localization; stability estimation from row or column sums
</summary>

### Contents

#### 1. Gershgorin Disks
- For each row:  
  $\qquad D(a_{ii},\,\sum_{j\ne i}|a_{ij}|)$.
- All eigenvalues lie in the union of disks.

---

#### 2. Row vs Column Disks
- Statement of both row-based and column-based versions.
- Equivalence for eigenvalue containment.

##### Example
- Construct disks for a concrete $3\times3$ matrix and locate eigenvalues.

---

#### 3. Interpretation
- Diagonal dominance implies eigenvalue bounds.
- Visual intuition for stability and conditioning.

---

### Take Away
- Gershgorin circles give quick, computable eigenvalue bounds.
- No eigenvalue computation required.

____
</details>



<details><summary><a href="HamiltonCayley.ipynb" style="display:inline-block; width:9cm;">HamiltonCayley.ipynb</a>
Cayley–Hamilton theorem; characteristic polynomial; expressing matrix powers via lower powers
</summary>

### Contents

#### 1. Statement of the Theorem
- Every square matrix satisfies its own characteristic polynomial:  
  $\qquad p(A)=0$.

---

#### 2. Examples

##### Example (2×2)
- Compute characteristic polynomial.
- Substitute $A$ into $p(\lambda)$ and verify $p(A)=0$ explicitly.

##### Example (3×3)
- Same verification process for a higher-dimensional case.

---

#### 3. Applications
- Express high powers $A^k$ using lower powers.
- Simplify matrix functions.

---

### Take Away
- Cayley–Hamilton converts eigenvalue information into algebraic identities.
- Enables computation of matrix powers and inverses.

____
</details>



<details><summary><a href="RayleighQuotients.ipynb" style="display:inline-block; width:9cm;">RayleighQuotients.ipynb</a>
Rayleigh quotient; extremal eigenvalues of symmetric matrices; variational characterization
</summary>

### Contents

#### 1. Definition
- Rayleigh quotient:  
  $\qquad R(x)=\dfrac{x^T A x}{x^T x}$.

---

#### 2. Properties (Symmetric Case)
- Minimum and maximum values are eigenvalues.
- Achieved at corresponding eigenvectors.

##### Example
- Compute $R(x)$ for several vectors and compare to eigenvalues.

---

#### 3. Geometric Interpretation
- Quotient measures energy per unit length.
- Explains why eigenvectors are stationary points.

---

#### 4. Applications
- Estimating dominant eigenvalues.
- Basis for iterative eigenvalue algorithms.

---

### Take Away
- Rayleigh quotient links eigenvalues to optimization.
- Central tool in numerical linear algebra.

____
</details>


---
<details><summary><a href="24_SpectralTheorem.ipynb" style="display:inline-block; width:9cm;">24_SpectralTheorem.ipynb</a>
Spectral theorem; orthogonal diagonalization; symmetric operators; orthonormal eigenbases
</summary>

### Contents

#### 1. Symmetric Matrices
- Definition:  
  $\qquad A^T = A$.

---

#### 2. Spectral Theorem

##### Theorem (Spectral Theorem)
- For a real symmetric matrix $A$:
  - all eigenvalues and eigenvectors are real,
  - eigenvectors corresponding to distinct eigenvalues are orthogonal,
  - there exists an orthogonal matrix $Q$ such that  
    $\qquad A = Q \Lambda Q^T$.

---

#### 3. Eigenvector Expansion
- $A$ written as a sum of rank-1 matrices:  
  $\qquad \displaystyle{A = \sum_i \lambda_i q_i q_i^T}$.
- Interpretation as weighted orthogonal projections.

---

#### 4. Examples
- Full orthogonal diagonalization of a symmetric matrix.
- Verification of orthogonality and reconstruction of $A$ from eigenpairs.

---

### Take Away
- Symmetry guarantees orthogonal diagonalization.
- Matrix action decomposes into independent eigen-directions.

____
</details>



<details><summary><a href="25_PositiveDefiniteMatrices.ipynb" style="display:inline-block; width:9cm;">25_PositiveDefiniteMatrices.ipynb</a>
Positive definite matrices; quadratic forms; energy interpretations; eigenvalue characterizations
</summary>

### Contents

#### 1. Quadratic Forms
- Expression:  
  $\qquad x^T A x$ with $A$ symmetric.

---

#### 2. Positive Definiteness

##### Definition
- $A$ is **positive definite** if  
  $\qquad x^T A x > 0 \quad \text{for all } x \ne 0$.

---

#### 3. Eigenvalue Interpretation
- Using the spectral theorem:  
  $\qquad x^T A x = \sum \lambda_i \tilde{x}_i^2$.
- Positivity determined by signs of eigenvalues.

---

#### 4. Geometry
- Level sets are ellipsoids.
- Contrast with indefinite and semidefinite cases.

---

#### 5. Examples
- Classification of matrices by eigenvalue sign.
- Graphical illustration of quadratic forms.

---

### Take Away
- Positive definiteness is an eigenvalue property.
- Geometry of $x^T A x$ follows directly from the spectrum.

____
</details>


<details><summary><a href="25a_QuadricSurfaceDisplay.ipynb" style="display:inline-block; width:9cm;">25a_QuadricSurfaceDisplay.ipynb</a>
Quadratic surface Visualization in 3D; classification via eigenstructure
</summary>

### Contents

#### 1. Quadratic Surfaces
- Surfaces defined by  
  $\qquad x^T A x = c$.

---

#### 2. Classification by Eigenvalues
- All $\lambda_i>0$: ellipsoids.
- Mixed signs: hyperboloids.
- Zero eigenvalues: degenerate surfaces.

---

#### 3. Visualization
- 2D and 3D surface plots.
- Visual comparison of positive definite, indefinite, and semidefinite cases.

---

### Take Away
- Eigenvalues determine surface shape.
- Visualization reinforces algebraic classification.

____
</details>


<details><summary><a href="PositiveDefiniteTests.ipynb" style="display:inline-block; width:9cm;">PositiveDefiniteTests.ipynb</a>
Testing positive/negative(semi)definiteness; principal minors; pivot tests; structural criteria
</summary>

### Contents

#### 1. Positive Definite Matrices

##### Definition
- $A$ symmetric is **positive definite** if  
  $\qquad x^T A x > 0 \quad \text{for all } x \ne 0$.

##### Theorem (Equivalent Tests — in order)

**Positive Definite Tests:** For a symmetric matrix $A$, the following are equivalent:
* $ x^T A x > 0 \quad \text{for all } x \ne 0$.
* All eigenvalues of $A$ are positive.
* All pivots of $A$ (from Gaussian elimination, with no row exchanges) are positive.
* All leading principal minors of $A$ are positive.
* $A$ admits a Cholesky factorization $\;\; A = R^T R$ with $R$ invertible.

**Positive Semidefineite Tests:** For a symmetric matrix $A$, the following are equivalent:
* $ x^T A x \ge 0 \quad \text{for all } x$
* All eigenvalues of $A$ are nonnegative.
* All pivots of $A$ (from Gaussian elimination, with no row exchanges) are nonnegative.
* All principal minors of $A$ are nonnegative.
* $A$ can be written in the form $\;\; A = R^T R\;\;$
   for some (not necessarily square) matrix $R$.

##### Examples
- Each test verified on concrete symmetric matrices.
- Comparison of computational convenience across tests.

---

#### 2. Negative Definite Matrices

##### Definition
- $A$ symmetric is **negative definite** if  
  $\qquad x^T A x < 0 \quad \text{for all } x \ne 0$.

##### Equivalent Tests
- The five tests above applied to $-A$.
- Eigenvalues negative; pivots and minors alternate in sign.

##### Examples
- Parallel examples illustrating negative definiteness.

---

### Take Away
- Definiteness admits multiple equivalent characterizations.
- For a given matrix $A$, some tests may be easier to check than others.

____
</details>

---
<details><summary><a href="FunctionsOfAMatrix.ipynb" style="display:inline-block; width:9cm;">FunctionsOfAMatrix.ipynb</a>
Matrix functions; polynomial and power-series definitions; matrix exponential and linear ODE systems
</summary>

### Contents

#### 1. Eigendecomposition
- Assume $A$ is diagonalizable:  
  $\qquad A = S\Lambda S^{-1}$

---

#### 2. Powers of $A$

##### 2.1 Integer Power of $A$

$\qquad A^n = S\Lambda^n S^{-1}$

##### 2.2 Non-negative Power of $A$

$\qquad A^n = S\Lambda^n S^{-1}\;\;$ provided there are no zero eigenvalues

---

#### 3. Functions of $A$
- Define $f(A)$ through the diagonal form:  
  $\qquad f(A)=S\,f(\Lambda)\,S^{-1}$

---

#### 4. Application: Difference Equations
- Iteration $y_{n}=Ay_{n-1}$ expressed via $A^n$:  
  $\qquad y_n=A^n y_0 = S\Lambda^n S^{-1}y_0$

##### Example
- A concrete iteration problem illustrating long-term behavior via eigenvalues.

---

#### 5. Application: Linear System of ODEs
- Convert a 3–variable system to $y'=Ay$ and decouple by diagonalization:  
  $\qquad \tilde{y}'=\Lambda \tilde{y} \;\;\Leftrightarrow\;\;  y(t)=e^{At}y(0)$

##### Example
- A specific $3\times 3$ system with initial condition, solved by $y(t)=e^{At}y(0)$ using $S^{-1}AS=\Lambda$.

____
</details>



<details><summary><a href="FunctionsOfAMatrixExamples.ipynb" style="display:inline-block; width:9cm;">FunctionsOfAMatrixExamples.ipynb</a>
Worked examples of matrix functions; exponential of triangular and nilpotent matrices; limiting behavior
</summary>

### Contents

#### 1. Functions of a Matrix (worked problems)

##### 1.1 Compute $\sin(At)$
- Uses eigendecomposition and applies $f(\Lambda)$ entrywise.
- Includes a “multiply it out” step after expressing $\sin(At)=S\sin(\Lambda t)S^{-1}$.

##### 1.2 Compute $e^{At}$ and multiply out
- Explicitly forms $e^{At}=Se^{\Lambda t}S^{-1}$ and expands the product.

##### 1.3 Limit $\lim_{t\to\infty} e^{At}$
- Uses eigenvalues/signs to determine convergence/divergence.

##### Example
- All parts use a single explicit $3\times 3$ matrix $A$ given at the start.

---

#### 2. Difference Equation

##### 2.1 Relation between eigendecompositions of $A$ and $B$
- Scaling example with $B=\frac{1}{10}A$:
  eigenvalues scale and eigenspaces relate by $(B-\mu I)x=0$.

##### 2.1 Solution of a Difference Equation
- Solves $y_{n+1}=By_n$ using $B^n$ / diagonalization.

##### 2.2 Limit $\lim_{n\to\infty} y_n$
- Uses spectral size to determine the limit.

##### Example
- A concrete scaled-matrix setting linking eigenvalues of $A$ and $B$ and applying it to the iteration.

____
</details>



<details><summary><a href="JordanForm.ipynb" style="display:inline-block; width:9cm;">JordanForm.ipynb</a>
Jordan canonical form; generalized eigenvectors; structure of defective eigenvalues
</summary>

### Contents

#### 1. Jordan Form of a Matrix

##### 1.1 Definitions and Theorem
- Jordan block $B_n(\lambda)$ (diagonal $\lambda$ with 1’s on the superdiagonal).
- Jordan form $J$ as block diagonal matrix of Jordan blocks.
- Statement: every square matrix admits  
  $\qquad A = SJS^{-1}$

##### 1.2 Example
- Basic illustration of what Jordan blocks/forms look like.

---

#### 2. Naive Computation of a Jordan Form

##### 2.1 Jordan Chains
- Chains built by solving successive systems involving $(A-\lambda I)$.

##### 2.2 Naive Computation Example
- Constructs chains for two explicit starting vectors and assembles $S$ and $J$.

##### Examples
- Two named chain computation followed by “A Jordan form for $A$”.

---

#### 3. Computation of a Jordan Form

##### 3.1 Point Diagram and its Properties
- Diagram viewpoint.
- Nested null spaces $\mathscr{N}((A-\lambda I)^k)$.
- Algorithm summarized.

##### 3.2 Computation of a Jordan Form Example
- Step 1: eigenvalues and algebraic multiplicities.
- Step 2: row echelon forms of $(A-\lambda I)^k$.
- Step 3: nested basis vectors and their chains (organized by levels).
- Step 4: assemble $S$ and $J$.

##### Example
- Full worked “Step 1–4” computation with explicit bases at levels (including a level $n=3$ block).

---

#### 4. Take Away
- Jordan form extends diagonalization to defective/degenerate cases.
- Useful theoretically; notebook remarks it is not used for numerical computation.

____
</details>



<details><summary><a href="FunctionsOfADegenerateMatrix.ipynb" style="display:inline-block; width:9cm;">FunctionsOfADegenerateMatrix.ipynb</a>
Matrix functions for defective matrices; block-wise evaluation; exponential of Jordan blocks
</summary>

### Contents

#### 1. Introduction
- Motivation: extend “functions of a matrix” beyond diagonalizable cases.

---

#### 2. Jordan Blocks, Matrix Powers and Functions of Matrices

##### 2.1 Definition
- Works with nilpotent blocks $N_n$ and Jordan blocks $J_n(\lambda)$.

##### 2.2 Integer Powers of Degenerate Matrices
- 2.2.1 Powers of $N_n$.
- 2.2.2 Powers of $J_n(\lambda)$.
- 2.2.3 General case (block structure).

##### 2.3 Arbitrary Powers of Degenerate Matrices
- Extends $A^t$ beyond integers using Jordan-block structure.

##### 2.4 Functions of Degenerate Matrices
- 2.4.1 Definition via series expansions.
- 2.4.2 Example: exponential of a degenerate matrix.
- 2.4.3 Example: logarithm of a degenerate matrix.

##### Examples
- Explicit computation of $e^{Jt}$ for a Jordan block.
- Explicit computation of $\log(J)$ (where defined) using series/structure.

---

#### 3. Special Case: Projection Matrices
- 3.1 Definition.
- 3.2 Powers of projection matrices ($P^2=P$ behavior emphasized).
- 3.3 Functions of projection matrices.

##### Example
- Compute $P^k$ and evaluate simple $f(P)$ using idempotence.

---

#### 4. Special Case: Nilpotent Matrices
- 4.1 Definition and examples.
- 4.2 Eigenvalues/eigenvectors; Jordan form for nilpotent matrices.
- 4.3 Powers of a nilpotent matrix:
  - 4.3.1 integer powers,
  - 4.3.2 fractional-power generalization.

##### Examples
- Nilpotent example illustrating $N^k=0$ for sufficiently large $k$.
- Fractional-power discussion in the nilpotent/Jordan-block setting.

---

#### 5. Take Away
- Jordan blocks provide the correct framework for defining powers and functions when diagonalization fails.
- Series definitions ($e^A$, $\log A$, etc.) reduce to finite or structured formulas on Jordan blocks.

____
</details>


---
<details><summary><a href="Schur_Decomposition.ipynb" style="display:inline-block; width:9cm;">Schur_Decomposition.ipynb</a>
Schur form; triangularization by unitary similarity; iterative refinement toward eigenvalues
</summary>

### Contents

#### Setup and Plotting Functions
- Utilities for experiments/plots used later.

---

#### 1. Introduction
- Motivation: stable eigenvalue computation and triangular reduction.

---

#### 2. The QR Algorithm for Computing Eigenvalues

##### 2.1 Simplest Form of the Algorithm
- Iterative QR steps; convergence behavior discussed.

##### 2.2 Improvement: Reduce to Hessenberg Form
- 2.2.1 Hessenberg form definition.
- 2.2.2 Numerical experiment comparing runtime/behavior.

##### Examples
- Side-by-side runs:
  - QR on the original matrix,
  - QR on a Hessenberg form,
  including “Eigenvalue Estimation” and comparison outputs.

##### 2.3 Improvement: QR Algorithm with Shifts
- Shifted iteration to accelerate convergence.

##### Example
- Execute shifted QR and compare results to unshifted (explicit comparison section).

---

#### 3. Take Away

##### 3.1 Key Insights
- What QR is doing numerically (as summarized in the notebook).

##### 3.2 Why Schur Decomposition?
- Connects QR convergence to Schur form.

##### 3.3 Applications
- Uses of Schur/triangular form in eigenvalue problems and matrix functions (as listed in the notebook).

____
</details>


---
# 8. Singular Value Decomposition
<details><summary><a href="26_GramMatrix.ipynb" style="display:inline-block; width:9cm;">26_GramMatrix.ipynb</a>
Gram matrix $A^tA$; rank and null spaces; eigenstructure of $A^T $ and $A A^T$; preparation for SVD
</summary>

### Contents

#### 1. Gram Matrix

##### Definition
- For column vectors $a_1,\dots,a_n$, the **Gram matrix** is  
  $\qquad G = A^T A$,  
  where $A=[a_1\;\cdots\;a_n]$.
- Entries satisfy  
  $\qquad G_{ij}=a_i^T a_j$.

---

#### 2. Properties
- $G$ is symmetric.
- $G$ is positive semidefinite.
- $\operatorname{rank}(G)=\operatorname{rank}(A)$.
- $G$ is positive definite iff the columns of $A$ are linearly independent.

---

#### 3. Geometry
- Diagonal entries give squared column lengths.
- Off-diagonal entries give pairwise inner products.
- Encodes angles and correlations between columns.

---

#### 4. Examples
- Explicit computation of a Gram matrix from a given $A$.
- Example illustrating loss of rank when columns are dependent.
- Example linking Gram matrix eigenvalues to singular values.

---

### Take Away
- Gram matrices encode all inner-product information of a set of vectors.
- $A^T A$ is the central object behind SVD and least squares.

____
</details>



<details><summary><a href="27_SVD.ipynb" style="display:inline-block; width:9cm;">27_SVD.ipynb</a>
Singular value decomposition; geometry of $U$, $\Sigma$, $V^t$; full and reduced SVD; rank-$k$ approximations
</summary>

### Contents

#### 1. Singular Value Decomposition

##### Theorem (SVD)
- For any $A\in\mathbb{R}^{m\times n}$,  
  $\qquad A = U\Sigma V^T$,  
  with $U,V$ orthogonal and $\Sigma$ diagonal with nonnegative entries.

---

#### 2. Construction via Gram Matrices
- Singular values are $\sqrt{\text{eigenvalues of }A^T A}$.
- Right singular vectors are eigenvectors of $A^T A$.
- Left singular vectors obtained from $Av_i=\sigma_i u_i$. (Must be consistent!)

---

#### 3. Rank and Null Spaces
- Number of nonzero singular values equals $\operatorname{rank}(A)$.
- Links to column space, row space, and null spaces.

---

#### 4. Geometry
- Action of $A$ maps the unit sphere to an ellipsoid.
- Singular values are the principal semi-axis lengths.

---

#### 5. Examples
- Full SVD computation for a small matrix.
- Verification of orthogonality and reconstruction $U\Sigma V^T=A$.

---

### Take Away
- SVD exists for every matrix.
- Separates stretching (singular values) from direction (singular vectors).

____
</details>


<details><summary><a href="28_PseudoInverse.ipynb" style="display:inline-block; width:9cm;">28_PseudoInverse.ipynb</a>
Moore–Penrose pseudoinverse from SVD; least-squares and minimum-norm solutions
</summary>

### Contents

#### 1. Motivation
- Linear systems with no solution or infinitely many solutions.
- Need for a canonical generalized inverse.

---

#### 2. Definition via SVD
- If $A=U\Sigma V^T$, then $\;\; A^\dagger = V\Sigma^+U^T$,  
  where nonzero singular values are inverted.

---

#### 3. Least-Squares Solutions
- $x=A^+b$ minimizes $\Vert A x-b\Vert$.
- Residual orthogonal to the column space.

##### Example
- Overdetermined system solved using $A^\dagger$.

---

#### 4. Minimum-Norm Solutions
- For underdetermined systems, $A^\dagger b$ is the solution with smallest norm.

##### Example
- Underdetermined system with infinitely many solutions.

---

### Take Away
- Pseudoinverse unifies least squares and inverse problems.
- SVD provides a clean, stable construction.

____
</details>


<details><summary><a href="29_SVDapplications.ipynb" style="display:inline-block; width:9cm;">29_SVDapplications.ipynb</a>
Applications of SVD; low-rank approximation; image compression; dominant modes in data
</summary>

### Contents

#### 0. SVD as a Sum of Rank-1 Terms
- Starts by rewriting the reduced SVD as  
  $\qquad A = \sigma_1 u_1 v_1^T + \sigma_2 u_2 v_2^T + \cdots + \sigma_r u_r v_r^T$
- Interprets each term as: project onto $v_i$, scale by $\sigma_i$, assign to $u_i$.

---

#### 1. The Eckart–Young Theorem
- Motivation: singular values decrease in importance, so truncate the expansion:  
  $\qquad A_k = \sigma_1 u_1 v_1^T + \cdots + \sigma_k u_k v_k^T$
- Introduces $A_k$ as a **low-rank approximation**.

##### Example (2D data matrix)
- Uses a 2D data set with $(x_1,x_2)$ stored as columns of a matrix $A\in\mathbb{R}^{N_{\text{points}}\times 2}$.
- Notes that $v_1,v_2$ give orthogonal axes for the data; recommends centering by subtracting the mean.

---

#### 2. Low Rank Approximation of an Image
- Treats an image as a matrix of pixel values (done per color channel).
- Computes SVD channel-by-channel for the test image **mandrill**.
- Plots singular values on a log scale to show rapid decay.

##### Example (image compression)
- Builds rank-$k$ reconstructions for $k=2,10,50$ and displays them alongside the original image.

---

#### 3. Principal Component Analysis
- Explains PCA using the SVD viewpoint:
  - $U$ spans $\mathscr{C}(A)$ with directions ranked by $\sigma_i$,
  - $V$ spans $\mathscr{R}(A)$ with directions ranked by $\sigma_i$.
- Uses a 2D Gaussian cloud; shows principal directions as singular vectors.
- Centers the data (subtracts sample means) before computing $A_c^T A_c$.

##### Theorem
Given $A\in\mathbb{R}^{M\times N}$ with reduced SVD $A=U_r\Sigma_r V_r^T$,  
$\qquad \sigma_1^2=\max_{\Vert q\Vert =1} q^T A^T A q,\quad v_1=\arg\max_{\Vert q\Vert =1} q^T A^T A q$  
$\qquad \sigma_2^2=\max_{\Vert q\Vert =1,\ q\perp v_1} q^T A^T A q,\quad v_2=\arg\max_{\Vert q\Vert =1,\ q\perp v_1} q^T A^T A q$  
$\qquad \dots$
- States the interpretation used in the notebook:
  - principal directions are the $v_i$,
  - singular values correspond to standard deviations along those directions (up to a $\sqrt{M-1}$ factor).

##### Examples
- 2D data cloud with overlaid singular-vector directions before and after centering.
- Projection onto a chosen unit direction $q$ (points projected onto a line through the origin).

---

#### 4. Some Web Resources
- Concludes with a curated table of links on PCA, SVD geometry, image compression, and related notes/videos.

____
</details>

____
<details><summary><a href="ConditionNumber.ipynb" style="display:inline-block; width:9cm;">ConditionNumber.ipynb</a>
Conditioning of linear systems; sensitivity of solutions; norms and amplification factors
</summary>

### Contents

#### 1. Some Comments and Definition
- Motivation from finite-precision arithmetic (loss of significance in addition of very different magnitudes).
- Condition number as sensitivity of outputs to small input perturbations.
- Matrix condition number emphasized in the SVD/spectral viewpoint:  
  $\qquad \kappa(A)=\dfrac{\sigma_{\max}(A)}{\sigma_{\min}(A)}$
- Notes on norm-dependence and practical cost of computing $\kappa(A)$.

---

#### 2. Examples

##### 2.1 **2 × 2 Examples**
- Small explicit matrices used to illustrate how $\kappa(A)$ changes with near-dependence / near-singularity.

##### 2.2 **3 × 4 Example, Product of Matrices**
- Focuses on conditioning of $L^T L$ for a rectangular factor $L$.
- Compares “theoretical” eigenvalue reasoning for $L^T L$ with the value returned by `cond()`.
- Explains the discrepancy: `cond()` computes the condition number using the SVD.

---

#### 3. Take Away
- Large condition number indicates numerical difficulty.
- Prefer algorithms based on $A$ rather than $A^T A$ (e.g., regression/least squares).
- Mentions mitigation ideas:
  - damping/regularization,
  - alternative representations to reduce $\kappa$,
  - preconditioning $Ax=b \Leftrightarrow (AP)\tilde{x}=b$, $x=P\tilde{x}$.

____
</details>


<details><summary><a href="30_VectorAndMatrixNorms.ipynb" style="display:inline-block; width:9cm;">30_VectorAndMatrixNorms.ipynb</a>
Vector norms; induced matrix norms; spectral and Frobenius norm; geometric and inequality properties
</summary>

### Contents

#### 1. Introduction
- Norm axioms on a vector space $V$ over $\mathbb{F}$:
  - homogeneity,
  - triangle inequality,
  - positivity (with the “$\Vert v\Vert =0$ iff $v=0$” condition).

---

#### 2. Vector Norms

##### 2.1 $l^p$ norms on $\mathbb{F}^n$
- Defines $l^2$, $l^1$, and $l^\infty$ norms (table).
- Remarks:
  - for $p<1$, triangle inequality fails,
  - $l^0$ (“number of nonzeros”) is not a norm but is important.

##### 2.2 Vector length versus $p$
- Compares $\Vert v\Vert _p$ as a function of $p$ (illustration/plotting section).

##### 2.3 Unit balls
- Displays unit balls for different $p$ (geometric comparison).

##### 2.4 $l^1$ minimization and sparsity
- Notes: minimizing with $l^1$ promotes sparse solutions (discussion section).

---

#### 3. Matrix Norms
- Framing: construct matrix norms from vector norms.
- Definitions:
  - submultiplicative norm:
    $\qquad \Vert A B\Vert \le \Vert A\Vert \,\Vert B\Vert $
  - unitarily invariant norm:
    $\qquad \Vert UAV\Vert =\Vert A\Vert $ for orthogonal/unitary $U,V$.

---

#### 3.1 Entrywise vector norms: $\Vert vec(A)\Vert _p$
- Defines entrywise norms by vectorizing $A$.
- Highlights Frobenius norm and identity:
  $\qquad \Vert A\Vert _F=\sqrt{\operatorname{trace}(A^T A)}=\sqrt{\sum_i \sigma_i^2}$.
- States: Frobenius norm is unitarily invariant and submultiplicative.

---

#### 3.2 Schatten norms (vector norm of singular values)
- Definition: if $A$ has singular values $(\sigma_1,\dots,\sigma_r)$, then
  $\qquad \Vert A\Vert  = \Vert (\sigma_1,\dots,\sigma_r)\Vert $.
- Theorem: Schatten norms are unitarily invariant and submultiplicative.
- Special cases table includes:
  - nuclear/trace norm: $\sum_i \sigma_i$,
  - spectral norm: $\sigma_1$,
  - Frobenius: $\sqrt{\sum_i \sigma_i^2}$.

---

#### 3.3 Induced vector norms (operator norms)

##### 3.3.1 Definition and basic theorems
- Definition:
  $\qquad \Vert A\Vert =\sup_{x\ne 0}\frac{\Vert Ax\Vert }{\Vert x\Vert }$.
- Theorem: induced norms are submultiplicative.
- Theorem (operator bound):
  $\qquad \Vert Av\Vert \le \Vert A\Vert \,\Vert v\Vert $.

##### 3.3.2 Induced norms for $l^p$
- Table of standard induced norms:
  - $l^1$ induced norm = maximum absolute column sum,
  - $l^\infty$ induced norm = maximum absolute row sum,
  - $l^2$ induced norm = $\sigma_1$.
- Theorem: induced $p$-norms (except $p=2$) are not unitarily invariant.
- Remarks comparing overlaps:
  - entrywise $l^2$ and Schatten $l^2$ coincide (Frobenius),
  - induced $l^2$ coincides with Schatten $l^\infty$ (spectral norm).

---

#### 3.4 Submultiplicative norms and the spectral radius
- Theorem: for square $A$ with spectral radius $\rho(A)$ and any submultiplicative norm,  
  $\qquad \rho(A)\le \Vert A\Vert $
  and  
  $\qquad \rho(A)=\lim_{k\to\infty}\Vert A^k\Vert ^{1/k}$.
- Remark: $\rho(A)$ is not a matrix norm.

---

#### 3.5 Example (norm comparison on one matrix)
- Uses a specific $3\times 3$ matrix $A$ (with stated singular values $\sigma_1=\sqrt{22}$, $\sigma_2=\sqrt{12}$).
- Computes and compares:
  - entrywise norms ($l^2$, $l^1$, $l^\infty$),
  - Schatten norms ($l^2$, $l^1$, $l^\infty$),
  - induced norms ($l^2$, $l^1$, $l^\infty$).

---

#### 4. Takeaway
- Matrix norms here are derived from vector norms.
- Choice depends on application (ease of computation vs operator meaning; unitary invariance vs induced bounds).

____
</details>

____
<details><summary><a href="PCA_and_SVD.ipynb" style="display:inline-block; width:9cm;">PCA_and_SVD.ipynb</a>
Principal component analysis via SVD; covariance matrix; variance explained; dimensionality reduction
</summary>

### Contents

#### 1. Data Matrix and Centering
- Data organized as columns of a matrix $A$.
- Centered data:  
  $\qquad A_c = A - \mu \mathbf{1}^T$,
  where $\mu$ is the mean vector.

---

#### 2. Covariance Matrix
- Definition:  
  $\qquad C = \frac{1}{n-1} A_c A_c^T$.
- Covariance as a Gram matrix of centered data.

---

#### 3. PCA via Eigenvalues
- Principal directions are eigenvectors of $C$.
- Eigenvalues measure variance along each direction.

##### Example
- 2D data cloud:
  - compute covariance,
  - plot eigenvectors as principal axes.

---

#### 4. PCA via SVD
- Uses reduced SVD:
  $\qquad A_c = U\Sigma V^T$.
- Relationship:
  - columns of $U$ are principal directions,
  - $\sigma_i^2/(n-1)$ are variances.

##### Example
- Same data set analyzed via SVD instead of covariance.

---

#### 5. Interpretation
- Projection onto leading principal components.
- Dimension reduction by truncation.

---

### Take Away
- PCA is best understood as an SVD of centered data.
- SVD avoids explicit formation of the covariance matrix.

____
</details>



<details><summary><a href="SVD_RemoveForeground.ipynb" style="display:inline-block; width:9cm;">SVD_RemoveForeground.ipynb</a>
Foreground/background separation in images using low-rank SVD models; noise and residual structure
</summary>

### Contents

#### 1. Data Organization
- Video or image frames reshaped as column vectors.
- Data matrix $A$ constructed by stacking frames.

---

#### 2. SVD Decomposition
- Compute:  
  $\qquad A = U\Sigma V^T$.
- Large singular values correspond to dominant structures.

---

#### 3. Foreground–Background Separation
- Low-rank approximation:  
  $\qquad A_k = U_k \Sigma_k V_k^T$.
- Background modeled by leading singular components.
- Foreground obtained by subtraction:  
  $\qquad A - A_k$.

##### Examples
- Static camera video:
  - background captured by first singular mode(s),
  - moving objects isolated in residual.
- Image stack example illustrating the same idea.

---

#### 4. Visualization
- Display original frames, low-rank reconstruction, and residual.
- Demonstrates effectiveness of rank truncation.

---

### Take Away
- SVD separates dominant (low-rank) structure from transient features.
- Effective for background subtraction and signal separation.

____
</details>


<details><summary><a href="Eigenfaces.ipynb" style="display:inline-block; width:9cm;">Eigenfaces.ipynb</a>
Eigenfaces; PCA on face images; mean face; projection for dimensionality reduction and recognition
</summary>

### Contents

#### 1. Face Data Matrix
- Each face image reshaped into a vector.
- Faces stacked as columns of a data matrix $A$.

---

#### 2. Mean Face and Centering
- Compute average face.
- Center data by subtracting the mean face from each column.

---

#### 3. PCA / SVD of Face Data
- Apply SVD to centered matrix:  
  $\qquad A_c = U\Sigma V^T$.
- Columns of $U$ are **eigenfaces**.

##### Examples
- Display leading eigenfaces.
- Visual interpretation of dominant facial features.

---

#### 4. Projection and Reconstruction
- Project a face onto the eigenface basis.
- Reconstruct using a truncated expansion.

##### Example
- Reconstruction with increasing number of eigenfaces.

---

#### 5. Recognition Idea
- Face represented by its PCA coefficients.
- Distance in coefficient space used for comparison.

---

### Take Away
- Eigenfaces are PCA applied to image data.
- Dimensionality reduction enables efficient representation and comparison.

____
</details>

____
<details><summary><a href="NormalEquation_3_ways.ipynb" style="display:inline-block; width:9cm;">NormalEquation_3_ways.ipynb</a>
Solving the normal equations three ways:normal equation, QR, and pseudoinverse
</summary>

### Contents

#### 1. Least-Squares Problem
- Overdetermined system:  
  $\qquad Ax \approx b$.
- Objective:  
  $\qquad \min_x \Vert Ax-b\Vert_2$.

---

#### 2. Method 1: Normal Equations
- Solve:  
  $\qquad A^T A x = A^T b$.
- Geometric interpretation: residual orthogonal to $\mathscr{C}(A)$.

##### Example
- Explicit construction and solution of $A^T A x=A^T b$.

---

#### 3. Method 2: QR Decomposition
- Write $A=QR$ with $Q$ orthonormal.
- Reduced system:  
  $\qquad Rx = Q^T b$.

##### Example
- Solve the same problem using QR and compare results.

---

#### 4. Method 3: SVD
- Use $A=U\Sigma V^T$.
- Solution:  
  $\qquad x = A^\dagger b$.

##### Example
- Solve using the pseudoinverse and compare with previous methods.

---

#### 5. Comparison
- Normal equations: simple but potentially ill-conditioned.
- QR: stable and efficient.
- SVD: most robust and informative.

---

### Take Away
- All three methods yield the same least-squares solution.
- SVD provides the most numerical insight.

____
</details>

____
# 9. Randomized Algorithms, Iterative Methods

<details><summary><a href="rSVDintroduction_python.ipynb" style="display:inline-block; width:9cm;">rSVDintroduction_python.ipynb</a>
Randomized SVD; sketching; range finding; efficient low-rank approximation
</summary>

### Contents

#### 1. Images and Display of Images
##### 1.1 Routines to display Images
- Basic plotting/display helpers (Panel/Holoviews).

##### 1.2 Arrays as Images
- Interprets a 2D array as a grayscale image.

##### 1.3 Color Images are Arrays
- Loads an RGB image, and displays the three channels.
- Converts to grayscale for compression experiments.

---

#### 2. SVD Compression
- Uses the standard SVD idea for low-rank image approximation (conceptual bridge to randomized methods).

---

#### 3. Sampling The Column Space

##### 3.1 Random Vectors Tend to be Orthogonal
- Empirical/illustrative point: random samples spread across directions.

##### 3.2 Sampling Linear Combinations of the Columns
- Samples the column space by forming  
  $\qquad Z = A P$  
  where $P$ has random columns.
- Builds an orthonormal basis $Q$ from $Z$ (QR), and uses the projection  
  $\qquad QQ^T A$  
  as an approximation to $A$.

##### Example (interactive image projection)
- Implements  
  $\qquad \texttt{project}(A,k)=QQ^T A$  
  where $Q$ comes from a QR factorization of $A$ times random samples.
- Interactive slider over $k$ compares projected vs original grayscale image and reports matrix sizes.

##### 3.3 Idea: An approximate SVD of the Image
- If $Q^T A = U_r \Sigma_r V_r^T$, then  
  $\qquad QQ^T A = (Q U_r)\Sigma_r V_r^T$,  
  giving an approximate SVD of $A$ by computing the SVD of the smaller matrix $Q^T A$.
- Lists the randomized-SVD steps explicitly (sample $\to$ QR $\to$ small SVD $\to$ lift back).

____
</details>



<details><summary><a href="rSVDintroduction_julia.ipynb" style="display:inline-block; width:9cm;">rSVDintroduction_julia.ipynb</a>
Randomized SVD in Julia; numerical behavior; subspace refinement
</summary>

### Contents

#### 1. Images are Matrices

##### 1.1 Display a Matrix
- Basic routines to view a matrix as an image (grayscale casting).

##### 1.2 A Color Image
- Loads a test image.
- Displays **RGB channels** and a **grayscale** version.

##### Image size and singular values
- Reports image size and computes an SVD of the grayscale image.
- Plots **relative singular values** on a log scale.

---

#### 2. Approximate the Column Space $\mathscr{C}(A)$

##### 2.1 Random Vectors Tend to be Orthogonal
- Demonstration using a matrix of random unit vectors named **$\Omega$** in the code:  
  $\qquad \Omega = \texttt{randn}(\cdot)$ with columns normalized.
- Visualizes $\Vert \Omega^T\Omega \Vert$ for increasing ambient dimension.

##### 2.2 Random Samples of the Column Space
- Defines `approx_ColA(A,k)`:  
  $\qquad Z = A\,\texttt{randn}(\text{size}(A,2),k),\quad Z=QR\Rightarrow Q$
- Forms the projection approximation:  
  $\qquad QQ^T A$
- Uses `mosaicview` to compare approximations for several choices of $k$ (e.g. $10,25,100$).

---

#### 3. Matrix Factorizations
- Bridge from column-space approximation to randomized SVD:
  compute SVD of the smaller matrix $Q^T A$ and lift back.

---

#### 4. Randomized SVD

##### 4.1 Randomized SVD
- Implements `randomized_svd(A; k, may_transpose)`:
  - build $Q$ from `approx_ColA`,
  - compute `svd(QtA)` with $Q^T A$,
  - lift left singular vectors.
- Includes an option to transpose when the input is “wide” (`may_transpose`).
- Defines an explicit error function:  
  $\qquad \Vert U\,\mathrm{diag}(S)\,V^T - A\Vert $,
  and evaluates it for a chosen $k$.

##### 4.2 Randomized SVD with Power
- Demonstrates power iteration effects on singular values by forming  
  $\qquad Z \leftarrow A(A^T Z)$ repeatedly (loop over $p$),  
  and plotting the relative singular values for several $p$.
- Implements power-based range finder `approxCol_Ap(A,p,k)` using  
  $\qquad Z = (A A^T)^p A\,\texttt{randn}(\cdot)$,  
  then QR to get $Q$.
- Implements `randomized_svd_Ap(A; p, k)` and plots rSVD error versus power $p$.

____
</details>


<details><summary><a href="rSVD.ipynb" style="display:inline-block; width:9cm;">rSVD.ipynb</a>
Randomized SVD algorithms; accuracy guarantees; influence of singular value decay
</summary>

### Contents

#### 1. Get Data
- Loads a grayscale image as a matrix.
- Provides helper routines to:
  - display approximations,
  - display absolute error images,
  - interactively compare rank-$r$ reconstructions.

---

#### 2. Approximating a Matrix

##### 2.1 Review: SVD Facts Used Later
- Left multiplication by an orthogonal matrix rotates left singular vectors but preserves singular values.
- $(A A^T)^p A$
  has the same singular vectors as $A$ and singular values $\sigma_i^{2p+1}$.
- Motivation: power iteration amplifies gaps between singular values.

---

#### 3. Randomized Range Finder

##### 3.1 Basic Range Approximation
- Forms random test vectors and computes  
  $\qquad Z = A\,G$  
  where $G$ is a random Gaussian matrix.
- Uses QR factorization of $Z$ to obtain an orthonormal basis $Q$ for an approximate column space.

##### 3.2 Oversampling
- Uses $k+\ell$ samples (with $\ell$ small) to improve robustness.
- Notes empirical improvement in approximation quality.

---

#### 4. Randomized SVD Algorithm

##### Algorithm (as implemented)
1. **Sampling / range finding**  
   $\qquad Z = (A A^T)^p A\,G$  (optional power $p\ge 0$)
2. **Orthonormal basis**  
   $\qquad Z = QR \Rightarrow Q$
3. **Compression**  
   $\qquad B = Q^T A$
4. **Small SVD**  
   $\qquad B = \tilde{U}\Sigma V^T$
5. **Lift**  
   $\qquad U = Q\tilde{U}$

- Parameters exposed:
  - target rank $k$,
  - oversampling $\ell$,
  - power parameter $p$.

---

#### 5. Synthetic Experiments

##### 5.1 Prescribed Singular Values
- Constructs a matrix with known singular values.
- Compares true singular values with those recovered by randomized SVD.
- Plots error versus:
  - rank $k$,
  - power $p$,
  - oversampling $\ell$.

---

#### 6. Image Compression Experiments

##### Example
- Applies randomized SVD to the test image.
- Interactive controls for:
  - rank $r$,
  - power $p$,
  - oversampling.
- Displays:
  - reconstructed image,
  - absolute error image.

---

#### 7. Diagnostics
- Computes and displays Gram matrices:  
  $\qquad A^T A \quad \text{and} \quad A A^T$  
  for inspection and discussion.

---

### Take Away
- Randomized SVD approximates the column space efficiently using random sampling.
- Power iteration significantly improves accuracy when singular values decay slowly.
- Accuracy–cost tradeoffs are controlled by $(k,\ell,p)$.

____
</details>

____
# 9. Randomized Algorithms, Iterative Methods
<details><summary><a href="rSVDintroduction_python.ipynb" style="display:inline-block; width:9cm;">rSVDintroduction_python.ipynb</a>
Randomized SVD; sketching; range finding; efficient low-rank approximation
</summary>

### Contents

#### 1. Images and Display of Images
##### 1.1 Routines to display Images
- Basic plotting/display helpers (Panel/Holoviews).

##### 1.2 Arrays as Images
- Interprets a 2D array as a grayscale image.

##### 1.3 Color Images are Arrays
- Loads an RGB image, and displays the three channels.
- Converts to grayscale for compression experiments.

---

#### 2. SVD Compression
- Uses the standard SVD idea for low-rank image approximation (conceptual bridge to randomized methods).

---

#### 3. Sampling The Column Space

##### 3.1 Random Vectors Tend to be Orthogonal
- Empirical/illustrative point: random samples spread across directions.

##### 3.2 Sampling Linear Combinations of the Columns
- Samples the column space by forming  
  $\qquad Z = A P$  
  where $P$ has random columns.
- Builds an orthonormal basis $Q$ from $Z$ (QR), and uses the projection  
  $\qquad QQ^T A$  
  as an approximation to $A$.

##### Example (interactive image projection)
- Implements  
  $\qquad \texttt{project}(A,k)=QQ^T A$  
  where $Q$ comes from a QR factorization of $A$ times random samples.
- Interactive slider over $k$ compares projected vs original grayscale image and reports matrix sizes.

##### 3.3 Idea: An approximate SVD of the Image
- If $Q^T A = U_r \Sigma_r V_r^T$, then  
  $\qquad QQ^T A = (Q U_r)\Sigma_r V_r^T$,  
  giving an approximate SVD of $A$ by computing the SVD of the smaller matrix $Q^T A$.
- Lists the randomized-SVD steps explicitly (sample $\to$ QR $\to$ small SVD $\to$ lift back).

____
</details>



<details><summary><a href="rSVDintroduction_julia.ipynb" style="display:inline-block; width:9cm;">rSVDintroduction_julia.ipynb</a>
Randomized SVD in Julia; numerical behavior; subspace refinement
</summary>

### Contents

#### 1. Images are Matrices

##### 1.1 Display a Matrix
- Basic routines to view a matrix as an image (grayscale casting).

##### 1.2 A Color Image
- Loads a test image.
- Displays **RGB channels** and a **grayscale** version.

##### Image size and singular values
- Reports image size and computes an SVD of the grayscale image.
- Plots **relative singular values** on a log scale.

---

#### 2. Approximate the Column Space $\mathscr{C}(A)$

##### 2.1 Random Vectors Tend to be Orthogonal
- Demonstration using a matrix of random unit vectors named **$\Omega$** in the code:  
  $\qquad \Omega = \texttt{randn}(\cdot)$ with columns normalized.
- Visualizes $\Vert \Omega^T\Omega \Vert$ for increasing ambient dimension.

##### 2.2 Random Samples of the Column Space
- Defines `approx_ColA(A,k)`:  
  $\qquad Z = A\,\texttt{randn}(\text{size}(A,2),k),\quad Z=QR\Rightarrow Q$
- Forms the projection approximation:  
  $\qquad QQ^T A$
- Uses `mosaicview` to compare approximations for several choices of $k$ (e.g. $10,25,100$).

---

#### 3. Matrix Factorizations
- Bridge from column-space approximation to randomized SVD:
  compute SVD of the smaller matrix $Q^T A$ and lift back.

---

#### 4. Randomized SVD

##### 4.1 Randomized SVD
- Implements `randomized_svd(A; k, may_transpose)`:
  - build $Q$ from `approx_ColA`,
  - compute `svd(QtA)` with $Q^T A$,
  - lift left singular vectors.
- Includes an option to transpose when the input is “wide” (`may_transpose`).
- Defines an explicit error function:  
  $\qquad \Vert U\,\mathrm{diag}(S)\,V^T - A\Vert $,
  and evaluates it for a chosen $k$.

##### 4.2 Randomized SVD with Power
- Demonstrates power iteration effects on singular values by forming  
  $\qquad Z \leftarrow A(A^T Z)$ repeatedly (loop over $p$),  
  and plotting the relative singular values for several $p$.
- Implements power-based range finder `approxCol_Ap(A,p,k)` using  
  $\qquad Z = (A A^T)^p A\,\texttt{randn}(\cdot)$,  
  then QR to get $Q$.
- Implements `randomized_svd_Ap(A; p, k)` and plots rSVD error versus power $p$.

____
</details>


<details><summary><a href="rSVD.ipynb" style="display:inline-block; width:9cm;">rSVD.ipynb</a>
Randomized SVD algorithms; accuracy guarantees; influence of singular value decay
</summary>

### Contents

#### 1. Get Data
- Loads a grayscale image as a matrix.
- Provides helper routines to:
  - display approximations,
  - display absolute error images,
  - interactively compare rank-$r$ reconstructions.

---

#### 2. Approximating a Matrix

##### 2.1 Review: SVD Facts Used Later
- Left multiplication by an orthogonal matrix rotates left singular vectors but preserves singular values.
- $(A A^T)^p A$
  has the same singular vectors as $A$ and singular values $\sigma_i^{2p+1}$.
- Motivation: power iteration amplifies gaps between singular values.

---

#### 3. Randomized Range Finder

##### 3.1 Basic Range Approximation
- Forms random test vectors and computes  
  $\qquad Z = A\,G$  
  where $G$ is a random Gaussian matrix.
- Uses QR factorization of $Z$ to obtain an orthonormal basis $Q$ for an approximate column space.

##### 3.2 Oversampling
- Uses $k+\ell$ samples (with $\ell$ small) to improve robustness.
- Notes empirical improvement in approximation quality.

---

#### 4. Randomized SVD Algorithm

##### Algorithm (as implemented)
1. **Sampling / range finding**  
   $\qquad Z = (A A^T)^p A\,G$  (optional power $p\ge 0$)
2. **Orthonormal basis**  
   $\qquad Z = QR \Rightarrow Q$
3. **Compression**  
   $\qquad B = Q^T A$
4. **Small SVD**  
   $\qquad B = \tilde{U}\Sigma V^T$
5. **Lift**  
   $\qquad U = Q\tilde{U}$

- Parameters exposed:
  - target rank $k$,
  - oversampling $\ell$,
  - power parameter $p$.

---

#### 5. Synthetic Experiments

##### 5.1 Prescribed Singular Values
- Constructs a matrix with known singular values.
- Compares true singular values with those recovered by randomized SVD.
- Plots error versus:
  - rank $k$,
  - power $p$,
  - oversampling $\ell$.

---

#### 6. Image Compression Experiments

##### Example
- Applies randomized SVD to the test image.
- Interactive controls for:
  - rank $r$,
  - power $p$,
  - oversampling.
- Displays:
  - reconstructed image,
  - absolute error image.

---

#### 7. Diagnostics
- Computes and displays Gram matrices:  
  $\qquad A^T A \quad \text{and} \quad A A^T$  
  for inspection and discussion.

---

### Take Away
- Randomized SVD approximates the column space efficiently using random sampling.
- Power iteration significantly improves accuracy when singular values decay slowly.
- Accuracy–cost tradeoffs are controlled by $(k,\ell,p)$.

____
</details>


---

<details><summary><a href="IterativeMethods_julia.ipynb" style="display:inline-block; width:9cm;">IterativeMethods_julia.ipynb</a>
Iterative solvers for linear systems; fixed-point iterations; convergence criteria
</summary>

### Contents

#### 1. Jacobi Method
- Starts from a splitting  
  $\qquad A = S - T,\ \ S\ \text{invertible}$
  giving the fixed-point form  
  $\qquad x = S^{-1}Tx + S^{-1}b$.
- **Jacobi choice:** $S=\operatorname{Diagonal}(A)$.
- Explicit warning: the iteration **need not converge**.

##### Example (code)
- Builds $\tilde A=S^{-1}T$ and $\tilde b=S^{-1}b$, iterates  
  $\qquad x_{n}=\tilde A x_{n-1}+\tilde b$,
  and records $\Vert x_n-x_{n-1}\Vert$.
- Plots error vs iteration on a log scale.

---

#### 2. Gauss Seidel
- **Idea:** update components as soon as available.
- Implements this by choosing $S$ as the **lower-triangular part** of $A$ (including the diagonal).

##### Example (code)
- Constructs $S=\operatorname{LowerTriangular}(A)$, forms $\tilde A,\tilde b$, runs the iteration.
- Compares Jacobi vs GS error curves; reports a residual norm $\Vert A x_N-b\Vert$.

---

#### 3. Successive Overrelaxation (SOR)
- Improves GS by relaxing the step:  
  $\qquad \tilde x_n = x_{n-1} + \alpha\,(x_n-x_{n-1}),\quad \alpha\ne 1$.
- Prints the **spectral radius** of the iteration matrix (from eigenvalues) as a convergence indicator.

##### Example (code)
- Runs SOR for chosen $\alpha$ and compares convergence behavior to Jacobi/GS.

____
</details>


<details><summary><a href="IterativeMethods_python.ipynb" style="display:inline-block; width:9cm;">IterativeMethods_python.ipynb</a>
Iterative solvers in Python; convergence monitoring; numerical behavior under perturbations
</summary>


### Contents

#### 1. Code: Monitor the Evolution of an Iterative Scheme
- Implements monitors/visualizers for iterative updates (including a 3D monitor used in examples).

---

#### 2. Iterative Solutions of $\mathbf{Ax=b}$

##### 2.1 Idea: Set up a Fixed Point
- Splits $A=S-T$ with $S$ invertible and derives  
  $\qquad x=\tilde A x+\tilde b,\quad \tilde A=S^{-1}T,\ \tilde b=S^{-1}b$,  
  then iterates  
  $\qquad x_n=\tilde A x_{n-1}+\tilde b$.
- Defines the step difference $e_n=x_n-x_{n-1}$ and derives  
  $\qquad e_{n+1}=\tilde A\,e_n=\tilde A^{\,n}e_1$.

##### 2.2 Convergence via Spectral Radius
- Uses diagonalization $A=S\Lambda S^{-1}$ to show convergence iff  
  $\qquad |Vert lambda_i<1\ \text{for all eigenvalues of }\tilde A$.
- **Definition:** spectral radius $\rho(A)=\ | \lambda_i |$.

##### 2.3 Examples
- **2D example:** explicit $2\times2$ fixed-point iteration matrix and vector.
- **3D example:** runs and visualizes an iterative scheme in $\mathbb{R}^3$.

##### 2.4 Gauss Seidel Iteration (GS)
- Presents Gauss–Seidel as “use updated entries immediately” and rewrites a 3-variable iteration to show the update order.

---

#### 3. Iterative Methods for $\mathbf{Ax=\lambda x}$

##### 3.1 Power Method
- Implemented as a streaming pipeline (Streamz) that repeatedly applies $A$, normalizes, and monitors convergence of the eigenvalue estimate.

##### 3.2 Inverse Power Method
- Streaming implementation of inverse iteration (solve step + normalization) to target small/shifted eigenvalues (as coded in the notebook).

____
</details>

# 10. Optimization
<details><summary><a href="MatrixDerivatives.ipynb" style="display:inline-block; width:9cm;">MatrixDerivatives.ipynb</a>
Matrix calculus; derivatives; gradients of matrix-valued functions
</summary>


### Contents

#### 1. Introduction

##### 1.1 Einstein Summation Convention
- Rewrites matrix/vector expressions entrywise without explicit summation symbols.
- Includes the Kronecker delta and Levi–Civita density as index tools.

##### 1.2 Derivatives and Differentials
- Establishes derivative types by shape:
  - vector-by-scalar, scalar-by-vector,
  - vector-by-vector,
  - matrix-by-scalar, scalar-by-matrix.
- Defines the differential of a matrix-valued function.
- Worked example illustrating “compute by entries” versus “compute by differentials”.

---

#### 2. Basic Formulae

##### 2.1 Sums and Products
- Differentiation rules for sums/products in index form and differential form.

##### 2.2 The Chain Rule
- Chain rule for maps  
  $\qquad g:\mathbb{R}^n\to\mathbb{R}^m$
  and  
  $\qquad g:\mathbb{R}^{m\times n}\to\mathbb{R}^{k\times \ell}$.
- A detailed chain-rule example is computed two ways:
  - direct index computation,
  - chain-rule computation,
  with commentary on index proliferation.

##### 2.3 Some Common Derivatives
- A table of frequently used gradients/Jacobians (as listed in the notebook).

##### 2.4 Differentials
- Recasts derivatives using differentials to streamline computation.

---

#### 3. Examples

##### 3.1 Neural Network Weight Updates
- Derivative structure used for gradient-based weight updates.

##### 3.2 Least Mean Squares Objective Function
- Derives the gradient of a least-squares objective (matrix form).

##### 3.3 The Rayleigh Quotient
- Computes derivative/gradient for  
  $\qquad R(x)=\dfrac{x^T A x}{x^T x}$
  (as formulated in the notebook).

____
</details>


<details><summary><a href="GradientDescent.ipynb" style="display:inline-block; width:9cm;">GradientDescent.ipynb</a>
Gradient descent for quadratic and nonlinear objectives; convergence geometry
</summary>

### Contents

#### 1. Find a Minimum

##### 1.1 The Idea of the Gradient Descent Algorithm
- Goal: minimize a differentiable scalar objective  
  $\qquad f:\mathbb{R}^n\to\mathbb{R}$.
- Steepest-descent direction is the gradient.
- Update rule (learning rate $\mu$):  
  $\qquad x_{k+1}=x_k-\mu\,\nabla f(x_k)$.
- Notes that differentiability is required.

##### 1.2 Two Scalar Function Examples
- Two 1D examples illustrate:
  - step sizes naturally shrink as slope approaches 0,
  - sensitivity to $\mu$ (too small stalls; too large overshoots),
  - dependence on initial guess for multi-well landscapes.
- Machine-learning vocabulary: $\mu$ as “learning rate”.

##### 1.3 What about the Cusp Function?
- Discusses failure/limitations when the objective is not differentiable (cusp).

##### 1.4 Convex Functions
- Convexity definition via chord inequality on an interval (and remark on $\mathbb{R}^n$ generalization).
- Convexity as a structural condition supporting well-behaved minimization.

---

#### 2. Least Mean Squares Example
- Reconnects least squares to minimization:  
  $\qquad x^*=\arg\min_x \Vert Ax-b\Vert^2$.
- Uses the chain rule to obtain the gradient:  
  $\qquad \nabla f(x)=A^T(Ax-b)$.
- Sets up gradient descent for least-squares fitting.

____
</details>



<details><summary><a href="GradientDescentExample.ipynb" style="display:inline-block; width:9cm;">GradientDescentExample.ipynb</a>
Worked examples of gradient descent; geometric visualization
</summary>


### Contents

#### 1. Objective Function
- Studies the quadratic family (Boyd–Vandenberghe reference):  
  $\qquad F(x)=\dfrac12\bigl(x_1^2+b\,x_2^2\bigr),\quad 0\le b\le 1$,
  equivalently  
  $\qquad F(x)=x^T A x,\quad A=\dfrac12\begin{pmatrix}1&0\\0&b\end{pmatrix}$.
- Geometric observation: as $b$ decreases, the valley becomes narrower/flatter.

---

#### 2. Gradient Descent
- Computes  
  $\qquad \nabla F(x)=\begin{pmatrix}x_1\\ b x_2\end{pmatrix}$,  
  and iterates the gradient descent update explicitly for this quadratic.
- Tracks the sequence of iterates and illustrates the path toward the minimizer at the origin.

##### Examples
- Trajectories for different values of $b$ (conditioning effect on zig-zagging).
- Demonstrations of step-size effects on convergence.

---

#### 3. Improved Algorithm

##### 3.1 Exact Line Search
- Chooses the step length that minimizes $F(x-\alpha\nabla F(x))$ along the descent direction.
- Compares the resulting trajectory/convergence to fixed-step gradient descent.

##### 3.2 Accelerated Descent: Momentum
- Introduces a momentum term to accelerate progress along flat directions.
- Compares momentum trajectories to plain gradient descent for the same $b$.

____
</details>


<details><summary><a href="GMRES.ipynb" style="display:inline-block; width:9cm;">GMRES.ipynb</a>
GMRES method; Krylov-subspace iteration; residual minimization
</summary>

### Contents

#### 1. Solving $\mathbf{A x = b}$ as an Optimization Problem
- Motivation: direct solvers (GE/QR/SVD) cost $\mathcal{O}(n^3)$ for dense $n\times n$ problems.
- Recasts solving as minimizing the residual norm:  
  $\qquad x=\arg\min_x \Vert Ax-b\Vert$.
- Restricts the search to a Krylov subspace  
  $\qquad \mathcal{K}_k(b)=\operatorname{span}\{b,Ab,\dots,A^{k-1}b\}$.

##### 1.1 Idea
- Use a low-dimensional Krylov constraint to reduce cost while improving the approximation iteratively.

##### 1.2 Derivation of the Algorithm
- Uses Arnoldi to produce $Q_k$ (orthonormal basis) and $H_k$ with  
  $\qquad A Q_k = Q_{k+1} H_k$,  
  where $H_k$ has size $(k+1)\times k$.
- With $x=Q_k y$ and $\beta=\Vert b\Vert$, derives the reduced least-squares problem:  
  $\qquad y=\arg\min_y \Vert H_k y-\beta e_1\Vert$,  
  then  
  $\qquad x_k=Q_k y$.
- Notes: in exact arithmetic, GMRES is exact at $k=n$; practical use stops with $k\ll n$.

---

#### 2. Basic Implementation and Example
- Implements the Arnoldi/GMRES loop and solves the reduced least-squares subproblem.
- Demonstrates convergence behavior on a concrete test system.

____
</details>

____
<details><summary><a href="BackPropagation.ipynb" style="display:inline-block; width:9cm;">BackPropagation.ipynb</a>
Neural-network backpropagation; gradient computation; chain rule structure
</summary>

### Topics
Backpropagation algorithm; linear and nonlinear layers; Jacobian structure; gradient flow through affine maps.

### Computation
Layer-wise derivative propagation; assembling gradients for weights and biases; example computations.

____
</details>

---

# 11. Principal Angles, Grassmannian
<details><summary><a href="KplanesPrincipalAngles.ipynb" style="display:inline-block; width:9cm;">KplanesPrincipalAngles.ipynb</a>
Principal angles between subspaces; computation using the SVD
</summary>

### Contents

#### 1. Foundations: Orthogonal Projections in Practice

##### Computation
- Implements projection onto a subspace represented by an orthonormal basis $U$:  
  $\qquad P_U = U U^T,\quad P_U x = U U^T x$.
- Uses these routines as building blocks for angles and principal-angle computations.

---

#### 2. From Vectors to Vectors and Subspaces: Defining Angles

##### 2.1 Angle Between Two Vectors
- Defines the angle via inner products and normalization.

##### 2.2 Angle Between a Vector and a Subspace
- Defines the angle between $x$ and $\mathscr{C}(U)$ using the projection $P_U x$ (and its orthogonal residual).

---

#### 3. Angles Between Subspaces

##### 3.1 Principal Angles: Conceptual Introduction
- Defines principal angles $\theta_1\le\cdots\le \theta_r$ for subspaces $\mathscr{C}(U)$ and $\mathscr{C}(V)$ (with $r=\min(k,\ell)$).
- Defines principal vectors as the “most aligned” directions realizing the angles.

##### 3.2 Principal Angles via Projections
- Studies the product of projection operators:  
  $\qquad P_U P_V$,  
  and the symmetric operator  
  $\qquad P_V P_U P_V$.
- Connects the action of these operators to the geometry of “project-then-project again”.

###### 3.2.2–3.2.4 Example (simple 2D case)
- A fully worked low-dimensional example illustrating:
  - how $P_U P_V$ acts on vectors,
  - how $P_V P_U P_V$ isolates principal directions.

##### 3.2.5 Principal Angles and the SVD of $U^T V$
- Main theorem: with orthonormal bases $U,V$,
  singular values of  
  $\qquad M=U^T V$  
  satisfy  
  $\qquad \sigma_i = \cos(\theta_i)$.
- Includes a multi-step proof (as written) linking angles, singular values, and principal vectors.
- Notes symmetry of principal angles (swapping $U$ and $V$ gives the same angle list).

##### 3.3 Computation of Principal Angles and Principal Vectors
- Computes principal vectors from the SVD factors and maps them back into $\mathscr{C}(U)$ and $\mathscr{C}(V)$.

###### Examples
- Subspaces with a shared direction and an orthogonal direction (one angle $0$, one angle $\pi/2$ behavior).
- Partial overlap where some singular values are zero (principal angles hitting $\pi/2$).

---

### Take Away
- Principal angles are computed from the SVD of $U^T V$ once bases are orthonormal.
- Projection operators explain the geometry and the meaning of principal vectors.

____
</details>


<details><summary><a href="KplaneDistances.ipynb" style="display:inline-block; width:9cm;">KplaneDistances.ipynb</a>
Distances between subspaces; metrics induced by principal angles
</summary>


### Contents

#### 1. Measuring Distance Between Subspaces

##### 1.1 Introduction
- Motivation: quantify separation/overlap between two subspaces beyond “intersect / don’t intersect”.

##### 1.2 Review: Principal Angles
- Recalls principal angles $\theta_i$ as the primary invariants used to define distances.

---

#### 2. Principal Angles Induce Distance Metrics
Defines multiple metrics built from the principal angles (each emphasized as capturing a different notion of dissimilarity):

##### 2.1 Spectral Distance
- Uses the largest principal angle as a single “worst-case alignment” measure.

##### 2.2 Chordal Distance
- Built from $\sin(\theta_i)$ (angle-to-chord conversion).

##### 2.3 Frobenius Distance
- A Frobenius-style aggregate of angle information (as stated in the notebook).

##### 2.4 Projection Distance
- Defined in terms of projection operators onto the subspaces (basis-independent).

##### 2.5 Geodesic Distance
- Uses the sum/aggregate of principal angles as a path-length notion on the Grassmannian (as presented).

##### 2.6 Summary
- Consolidates the definitions and how they relate qualitatively.

---

#### 3. Small Examples and Visual Comparisons

##### 3.1 Static Example: Two 2D Subspaces in $\mathbb{R}^3$
- Fully worked pipeline:
  1) choose/orthonormalize bases $U,V$ (Gram–Schmidt/QR),
  2) compute $U^T V$,
  3) compute an SVD of $U^T V$ (reduced),
  4) extract principal angles (and optionally principal vectors),
  5) compute the distances listed in Section 2.

###### Major notebook emphasis
- Warns that careless orthonormalization (near-dependence) can distort the computed subspace and thus the distances.
- Notes basis-independence via projection matrices:  
  $\qquad P_U=U U^T$.

---

### Take Away
- A single set of principal angles supports several legitimate “distance” notions.
- Practical computation depends critically on stable orthonormalization.

____
</details>

<details><summary><a href="KplaneDistanceComputations.ipynb" style="display:inline-block; width:9cm;">KplaneDistanceComputations.ipynb</a>
Computing principal angles in practice: orthonormalization choices (QR vs SVD), numerical rank pitfalls, and a PCA/subspace-drift application
</summary>

### Contents

#### 1. Review: Principal Angles Between Subspaces
- Restates the principal-angle setup and the $U^T V$ SVD computation route.

---

#### 2. Algorithmic Choices in Computing Principal Angles

##### 2.1 Orthonormalization
Compares orthonormalization strategies before forming $U^T V$:

###### 2.1.1 Option 1: QR Decomposition
- Standard QR-based orthonormal basis extraction.

###### 2.1.2 Option 2: SVD-Based Orthonormalization
- Uses SVD as an orthonormalization mechanism (especially when numerical rank is ambiguous).

###### 2.1.3 Numerical Rank and QR Pitfalls
- Emphasizes failure modes when input vectors are redundant or nearly dependent.

###### Example: Redundant vectors in 3D
- A concrete example where redundant/near-redundant generating vectors cause QR to produce a misleading basis unless numerical rank is handled carefully.

---

##### 2.2 Principal Angle Computation (continued example)
- Continues the redundancy example to show how orthonormalization choice changes the computed principal angles.
- Ends with an explicit recommendation consistent with the numerical-rank discussion.

---

#### 2.4 Theoretical Behavior of a 2D Example
- Analyzes a simple low-dimensional configuration to explain the expected principal-angle behavior.

---

#### 3. Application: Subspace Drift via PCA
- Constructs a toy “time-evolving data” setting:
  - compute a PCA subspace $U_t$ at each time,
  - measure change via principal angles (or angle-derived distances) between $U_t$ and $U_{t+1}$.
- Interprets small/large angles as stability/drift of dominant directions.

##### Example
- A rotating/slowly changing data distribution demonstrating how principal angles track drift over time.

---

### Take Away
- The principal-angle formula is simple; the hard part is robust orthonormalization under numerical rank issues.
- Principal angles are a practical tool for monitoring PCA subspace change in streaming data.

____
</details>

____
<details><summary><a href="GrassmannianIntro.ipynb" style="display:inline-block; width:9cm;">GrassmannianIntro.ipynb</a>
Introduction to the Grassmann manifold; structure of $k$-dimensional subspaces
</summary>

### Contents

#### 1. Motivation
- Many problems depend only on a **subspace**, not on a particular basis.
- Examples recalled from earlier notebooks:
  - PCA subspaces,
  - Krylov subspaces,
  - dominant singular subspaces.
- Leads to the need for a space whose points are $k$-dimensional subspaces of $\mathbb{R}^n$.

---

#### 2. Definition of the Grassmannian

##### Definition
- The Grassmannian $\mathrm{Gr}(k,n)$ is the set of all $k$-dimensional linear subspaces of $\mathbb{R}^n$.

##### Representation by Bases
- A subspace is represented by any full-rank matrix $U\in\mathbb{R}^{n\times k}$.
- Identifications:  
  $\qquad U \sim UQ \quad$ for any orthogonal $Q\in\mathbb{R}^{k\times k}$.
- Emphasizes: the Grassmannian is a **quotient space**.

---

#### 3. Projection-Matrix Representation
- Each subspace corresponds uniquely to an orthogonal projector:  
  $\qquad P = UU^T$.
- Properties:
  - $P^2=P$,
  - $P^T=P$,
  - $\operatorname{rank}(P)=k$.
- Basis-independence is immediate in this representation.

##### Example
- Explicit computation of $P$ from different bases spanning the same subspace.

---

#### 4. Local Coordinates and Dimension
- Uses a graph representation of nearby subspaces.
- Dimension of $\mathrm{Gr}(k,n)$:  
  $\qquad \dim = k(n-k)$.
- Interprets this dimension geometrically.

---

### Take Away
- The Grassmannian is the natural configuration space of $k$-planes.
- Projection matrices provide a clean, coordinate-free representation.

____
</details>


<details><summary><a href="GrassmannianGeodesicsOptimization.ipynb" style="display:inline-block; width:9cm;">GrassmannianGeodesicsOptimization.ipynb</a>
Geodesics on the Grassmannian; optimization paths; interpolation of subspaces
</summary>

### Contents

#### 1. Tangent Space of the Grassmannian
- Tangent vectors at a point $U$ characterized as:  
  $\qquad \Delta \in \mathbb{R}^{n\times k}$ with $U^T\Delta=0$.
- Interpretation: infinitesimal motion orthogonal to the current subspace.

---

#### 2. Riemannian Metric
- Uses the Frobenius inner product on tangent vectors.
- Metric is invariant under choice of orthonormal basis.

---

#### 3. Geodesics on $\mathrm{Gr}(k,n)$

##### 3.1 Exponential Map
- Given a tangent vector $\Delta$, constructs a geodesic  
  $\qquad U(t)$
  via an SVD of $\Delta$.
- Explicit formula using matrix sine and cosine blocks (as derived in the notebook).

##### Example
- Computes and plots a geodesic between two nearby subspaces.

---

#### 4. Distance on the Grassmannian
- Distance expressed in terms of **principal angles**:  
  $\qquad d(U,V)=\bigl(\sum_i \theta_i^2\bigr)^{1/2}$.
- Connects back to earlier principal-angle notebooks.

---

#### 5. Optimization on the Grassmannian

##### 5.1 Problem Setup
- Minimize a smooth function  
  $\qquad f(U)$  
  subject to $U^TU=I$ (subspace constraint).

##### 5.2 Riemannian Gradient
- Euclidean gradient projected onto the tangent space.

##### 5.3 Gradient Flow / Descent
- Iterative update along geodesics:  
  $\qquad U_{k+1}=\exp_{U_k}(-\alpha\,\mathrm{grad} f(U_k))$.

##### Example
- Minimization of a Rayleigh-quotient–type objective on $\mathrm{Gr}(k,n)$.

---

### Take Away
- The Grassmannian is a smooth Riemannian manifold.
- Optimization requires respecting the subspace constraint via geodesics.

____
</details>

<details><summary><a href="GrassmannianApplications.ipynb" style="display:inline-block; width:9cm;">GrassmannianApplications.ipynb</a>
Applications of Grassmannian geometry: PCA tracking; subspace averaging; interpolation; dynamical data analysis
</summary>

### Contents

#### 1. Example: Subspace Averaging
- Problem: given several subspaces $U_1,\dots,U_m$, define a “mean” subspace.
- Formulated as minimizing a sum of squared Grassmannian distances.

- Compute a Karcher (intrinsic) mean of multiple $k$-planes.

---

#### 2. Example: PCA Tracking / Subspace Drift
- Time-indexed data sets produce a sequence of PCA subspaces.
- Grassmannian distance used to quantify change over time.

- Simulated data with slowly rotating dominant directions.
- Plots principal angles or distances versus time.

---

#### 3. Example: Subspace Interpolation
- Given two subspaces $U_0$ and $U_1$, interpolate smoothly along the geodesic.
- Produces a continuous family of intermediate subspaces.

- Visual interpolation between two PCA subspaces.

---

#### 4. Relation to Earlier Topics
- Explicit links to:
  - principal angles,
  - projection operators,
  - SVD and PCA,
  - Krylov subspaces.

---

### Take Away
- Grassmannian geometry provides principled tools for comparing, interpolating, and optimizing subspaces.
- Applications naturally arise in data analysis and dynamical systems.

____
</details>

____
# Chapter 12 Generalized Eigendecomposition, Generalized SVD
<details><summary><a href="GEP_intro.ipynb" style="display:inline-block; width:9cm;">GEP_intro.ipynb</a>
Introduction to the generalized eigenvalue problem $A x = \lambda B x$; geometry, scaling, and structure
</summary>

### Contents

#### 1. Generalized Eigenproblem and Matrix Pencils

##### 1.1 Motivation
- Introduces eigenvalue problems of the form  
  $\qquad Ax=\lambda Bx$  
  through the **matrix pencil** $A-\lambda B$.

##### 1.2 Definitions
- Defines a matrix pencil and the generalized eigenvalue concept.
- Distinguishes **regular** versus **singular** pencils (as developed in the examples).

##### 1.3 Examples

###### 1.3.1 Regular Pencil Examples
- Three short examples illustrating when a pencil is regular and how generalized eigenvalues arise.

###### 1.3.2 Singular Pencil Examples
- Two short examples illustrating singular pencils and what breaks/changes in the eigenvalue interpretation.

###### 1.3.3 Application: Two-Mass Spring System Example
- Builds a concrete second-order mechanical model and expresses it as a generalized eigenproblem (mass/stiffness structure).

##### 1.4 Variants
- Notes common variants of the pencil/GEP formulation used in applications.

---

#### 2. The Generalized Rayleigh Quotient

##### 2.1 Definition
- Defines the generalized Rayleigh quotient  
  $\qquad \displaystyle{R_{A,B}(x)=\dfrac{x^T A x}{x^T B x}}$  
  (with attention to singular $B$ in later examples).

##### 2.2 Connection to Eigenvalues
- Shows the stationary/eigenvalue link in the symmetric–definite setting.
- Includes two contrasting examples:
  - $A$ symmetric, $B$ positive definite,
  - $B$ singular.

##### 2.3 Variational Characterization (symmetric–definite case)
- States the extremal characterization of generalized eigenvalues via constrained optimization.
- Includes an explicit example emphasizing **$B$-orthonormality** of eigenvectors.

---

### Take Away
- Matrix pencils unify many eigenvalue models.
- The generalized Rayleigh quotient provides the variational viewpoint, with extra care needed when $B$ is singular.

____
</details>



<details><summary><a href="GEP_computation.ipynb" style="display:inline-block; width:9cm;">GEP_computation.ipynb</a>
Algorithms for computing solutions to the GEP; QR- and Cholesky-based reductions, QZ algorithm
</summary>

### Contents

#### 1. Introduction
- Sets the computational goal: compute generalized eigenvalues/eigenvectors for $(A,B)$.

---

#### 2. Symmetric–Definite Case (Algorithm 1)
- Assumes $A$ symmetric and $B$ symmetric positive definite.

##### **Algorithm Summary**
- Uses the standard SPD reduction:  
  $\qquad B=R^T R$  
  $\qquad R^{-T}AR^{-1}y=\lambda y,\quad x=R^{-1}y$
- Emphasizes symmetry preservation and real spectrum in this setting.

##### **Example Implementation and Test**
- Implements the symmetric–definite algorithm and verifies  
  $\qquad Ax\approx \lambda Bx$  
  together with the normalization/orthogonality checks used in the notebook.

---

#### 3. General Case (Algorithm 2: QZ / Generalized Schur)
- Moves to arbitrary square $A,B$ (no symmetry/SPD assumptions).

##### 3.1 Matrices in Generalized Schur Form
- Introduces the generalized Schur form (upper triangular pair) and how eigen-information is read from it.
- Includes an explicit example: extracting eigenvalues/eigenvectors from a pair already in generalized Schur form.

##### 3.2 The $A=RQ$ and $A=QR$ Factorizations
- Builds the factorization tools used in reduction/iteration:
  - Householder reflections,
  - constructing QR (column-wise) and RQ (row-wise).
- Includes an example implementing QR_step / RQ_step (“introduce zeros in a column/row”).

##### 3.3 Reducing a Pencil to Hessenberg–Triangular Form
- Describes the preprocessing that accelerates/structures QZ:

###### 3.3.1 Hessenberg–Triangular Reduction
- **Step 1.** Reduce $B$ to upper triangular via a left orthogonal factor.
- **Step 2.** (Optional) form a Hessenberg–triangular pair.

###### 3.3.2 QZ Iteration
- Presents the QZ iteration on the reduced pair.

##### 3.4 Eigenvalue and Eigenvector Computation
- Separates the extraction steps:
  - eigenvalues from the triangular pair,
  - eigenvectors via back-substitution-style solves (as described).

###### Limitations: Degeneracy and Defectiveness
- Discusses what can fail when $(A,B)$ is defective and how this appears computationally.

##### 3.5 Diagonalization
- Connects generalized Schur output to diagonalization when possible.

---

#### 4. Detecting $\lambda=\infty$ in practice
- Explains the $\lambda=\infty$ case (singular $B$ effects) and how it is detected in computations.

---

#### 5. Take Away
- Two distinct regimes:
  - symmetric–definite: reduce to a standard symmetric eigenproblem,
  - general: QZ/generalized Schur with Hessenberg–triangular reduction.
- Practical computation hinges on stable reductions and careful eigenvector recovery.

____
</details>



<details><summary><a href="GEP_examples.ipynb" style="display:inline-block; width:9cm;">GEP_examples.ipynb</a>
Applications of the GEP in circuits, multibody systems, and canonical correlations
</summary>

### Contents

#### 1. Introduction
- Frames the notebook as a set of application-driven generalized eigenproblems.

---

#### 2. Case Study: RLC Circuit Analogue

##### 2.1 Circuit Description
- Presents an RLC-style model and the associated generalized eigen-structure.

##### 2.2 Visual Exploration
- Plots/visual tools to interpret the modes/eigen-information.

---

#### 3. Case Study: Canonical Correlation Analysis

##### 3.1 Problem Description
- Develops the CCA objective and its geometry.

###### Canonical Correlation Geometry
- Alternating viewpoint (as organized in the notebook):
  - fixing $v$ and optimizing over $u$,
  - fixing $u$ and optimizing over $v$,
  - eliminating $v$ to obtain a reduced formulation.

##### 3.2 Visual Exploration
- Visual diagnostics for the canonical directions / correlation structure.

---

#### 4. Case Study: Lightly Constrained Robot Arm (Ill-Conditioned GEP)

##### 4.1 Robot Arm Motion
- Builds the mechanical/mode-shape interpretation.

##### 4.2 System Characteristics and Plots
- Structured visual sections:
  - modal structure,
  - geometric visualization of mode shapes,
  - conditioning and singular perturbation,
  - time response under free vibration,
  - summary visuals.

##### 4.3 Practical Notes on Ill-Conditioned GEPs
- Practical guidance tied to what is observed in the robot-arm example.

---

#### 5. Take Away
- GEPs arise naturally in circuits, statistics (CCA), and mechanics.
- Ill-conditioning can dominate both interpretation and computation.

____
</details>


<details><summary><a href="GEP_RayleighQuotient.ipynb" style="display:inline-block; width:9cm;">GEP_RayleighQuotient.ipynb</a>
Generalized Rayleigh quotients; regularized least squares and $B$-inner-product eigenproblems
</summary>

### Contents

#### Initialization
- **Regularized least squares** and its connection to the **generalized eigenvalue problem**.
- Emphasizes that the resulting GEP may be **positive semidefinite but not definite**.

---

#### 1. Preliminaries and Notation
- Introduces matrices  
  $\qquad A \in \mathbb{R}^{m\times n},\quad B \in \mathbb{R}^{p\times n}$  
  with possible rank deficiency.
- Frames the **regularized least squares problem**:  
  $\qquad
  \operatorname{argmin}_x \;\Vert Ax-b\Vert^2 + \lambda\Vert B x\Vert^2
  $
- Interprets the two terms as:
  - data fidelity ($A$),
  - directional penalty ($B$).

---

#### 2. Variational Formulation

##### 2.1 Normal Equation
- Expands the objective function and computes its gradient explicitly.
- Derives the **normal equation**:  
  $\qquad
  (A^T A + \lambda B^T B)\,x = A^T b
  $
- Emphasizes the role of $A^TA$ versus $B^TB$ in shaping the solution.

###### Observations
- Notes that both $A^TA$ and $B^TB$ are **symmetric positive semidefinite**.
- Highlights that $B^TB$ may be **singular**, even when $B\neq 0$.

---

##### 2.2 Generalized Rayleigh Coefficient
- Introduces the **generalized Rayleigh quotient**  
  $\qquad\displaystyle{
  \rho(x)=\frac{\Vert Ax\Vert^2}{\Vert Bx\Vert^2}
  }$
- Shows that stationary values of $\rho(x)$ satisfy the **generalized eigenvalue problem**  
  $\qquad
  A^T A x = \mu\, B^T B x
  $
- Identifies $(A^TA,\;B^TB)$ as a **symmetric positive-semidefinite pencil**, not necessarily symmetric-definite.

###### Key distinction
- Explicitly discusses what changes when $B^TB$ is singular:
  - existence of **infinite generalized eigenvalues**,
  - breakdown of standard extremal interpretations,
  - sensitivity to near-null directions of $B$.

---

#### Example (central to the notebook)
- Fixes a concrete matrix $A$ and a **parameter-dependent penalty**  
  $\qquad B_\alpha$  
  interpolating from:
  - full rank ($\alpha=1$),
  - rank-deficient ($\alpha=0$).
- Evaluates  
  $\qquad
  \rho(x)=\rho(\cos\theta,\sin\theta)
  $
  over $\theta\in[0,\pi]$.
- Plots $\rho(x)$ and marks stationary values corresponding to generalized eigenvalues.

##### Visual and numerical diagnostics
- Tracks:
  - peaks in $\rho(x)$ as $B_\alpha$ approaches singularity,
  - appearance of unstable / infinite eigenvalues,
  - singular values and condition number of $B_\alpha$.
- Uses sliders to demonstrate how **near-singularity in $B$ destabilizes the GEP**.

---

#### 3. Take Away
- Regularized least squares leads naturally to a **generalized eigenvalue problem**.
- The associated Rayleigh quotient explains:
  - stationary directions,
  - instability from weak or singular penalties.
- Positive-semidefinite pencils behave fundamentally differently from definite ones, both analytically and numerically.

____
</details>

____
<details><summary><a href="GSVD_intro.ipynb" style="display:inline-block; width:9cm;">GSVD_intro.ipynb</a>
Geometric introduction to the GSVD; relation to SVD, whitening, and joint diagonalization
</summary>

### Contents

#### Initialization
- Introduces the **Generalized Singular Value Decomposition (GSVD)** as a unifying framework
  extending:
  - the generalized eigenvalue problem (GEP),
  - the standard SVD,

  to **rectangular matrix pairs** $(A,B)$ acting on the same parameter vector $x$.

---

#### 1. Introduction

##### Motivation
- Considers pairs of matrices  
  $\qquad A\in\mathbb{R}^{m_A\times n},\quad B\in\mathbb{R}^{m_B\times n}$  
  acting on the same $x\in\mathbb{R}^n$.
- Emphasizes that many problems depend on **comparative action** of $A$ and $B$, not on either alone.

##### Applications discussed
- **Regularized least squares**  
  $\qquad \min_x \Vert A x-b\Vert^2 + \lambda^2\Vert B x\Vert^2$
- **Two-view / multiview learning** (shared vs private directions).
- **Quotient and balance problems** involving ratios  
  $\qquad \Vert A x \Vert/\ \Vert B x\Vert$.

---

#### 2. GSVD: Structural Form

##### 2.1 Definition and Shape
- The GSVD reduces $(A,B)$ to  
  $\qquad A = U\,C\,X^{-1}, \qquad B = V\,S\,X^{-1}$
  where:
  - $U$ and $V$ are orthogonal,
  - $X$ is invertible,
  - $C$ and $S$ are structured diagonal / block-diagonal matrices.
- Introduces **generalized singular values** as pairs $(c_i,s_i)$ satisfying  
  $\qquad c_i^2 + s_i^2 = 1$.

---

##### 2.2 Classification of Directions
Each column of $X$ defines a direction $x$ that falls into one of **four canonical categories**:

1. **Pure-A directions**  
   $\qquad (c_i,s_i)=(1,0)$  
   directions seen by $A$ but annihilated by $B$.

2. **Mixed directions**  
   $\qquad 0<c_i<1,\;0<s_i<1$  
   directions where both $A$ and $B$ act nontrivially.

3. **Pure-B directions**  
   $\qquad (c_i,s_i)=(0,1)$  
   directions seen by $B$ but annihilated by $A$.

4. **Common nullspace directions**  
   $\qquad (c_i,s_i)=(0,0)$  
   directions annihilated by both $A$ and $B$.

---

##### 2.3 Canonical Ordering and Block Structure
- The GSVD orders these directions **canonically**:
  1. pure-A,
  2. mixed,
  3. pure-B,
  4. common nullspace.
- Presents explicit **block diagrams** for  
  $\qquad A X = U C,\quad B X = V S$
  showing how the four classes appear as diagonal blocks.
- Includes a table mapping:
  - blocks of $C$ and $S$,
  - domain/codomain bases,
  - subspace interpretations.

---

##### 2.4 Visualizing the GSVD Basis $X$
- Discusses how columns of $X$ encode directions ordered by the balance between $A$ and $B$.
- Interprets generalized singular values as cosine/sine of a “balance angle”.

---

#### 3. Take Away
- The GSVD decomposes $\mathbb{R}^n$ into directions where:
  - only $A$ matters,
  - only $B$ matters,
  - both matter,
  - neither matters.
- It provides a geometric and algebraic language for understanding **trade-offs between two operators**.

____
</details>


<details><summary><a href="GSVD_computations.ipynb" style="display:inline-block; width:9cm;">GSVD_computations.ipynb</a>
Algorithms for computing the GSVD; QR- and Golub–Van Loan–type methods
</summary>

### Contents

#### Initialization
- Positions this notebook as the **algorithmic companion** to `GSVD_intro.ipynb`.

---

#### 1. Introduction
- Restates the GSVD factorization  
  $\qquad A = U\,C\,X^{-1},\quad B = V\,S\,X^{-1}$  
  and emphasizes that **both matrices share the same right basis $X$**.
- Notes that $A$ and $B$ may have different row dimensions but must share column dimension.

---

#### 2. Computational Strategy Overview
- GSVD computation is framed as:
  - reducing a pair $(A,B)$ to structured form,
  - using orthogonal transformations on the left,
  - using invertible transformations on the right.
- Emphasizes structure preservation and numerical stability.

---

#### 3. Reduction Steps (Conceptual)
- Discusses how the GSVD relates to:
  - QR factorizations,
  - RQ factorizations,
  - and generalized eigenvalue computations on reduced blocks.
- Explains why **two separate orthogonal bases** $U$ and $V$ are required for $A$ and $B$.

---

#### 4. Relation to Other Decompositions
- Connects GSVD computation to:
  - GEP algorithms (when $A^TA$ and $B^TB$ are square),
  - SVD (as a special case when $B=I$),
  - nullspace computations.
- Clarifies which components are computed directly and which are inferred.

---

#### 5. Practical Remarks
- Notes sensitivity to rank deficiencies and near-null directions.
- Emphasizes that GSVD computation reveals **structural information**, not just numerical values.

---

#### 6. Take Away
- GSVD algorithms generalize ideas from QR, SVD, and GEP.
- The computational goal is to expose the four canonical direction types identified in the theory.

____
</details>

---
# Appendices
<details><summary><a href="A1_Analytic.ipynb" style="display:inline-block; width:9cm;">A1_Analytic.ipynb</a>
Analytic geometry in $\mathbb{R}^2$; vectors and coordinates; Euler’s formula; reflection and orthogonal projections
</summary>

### Contents

#### 1. Vectors
- Translates geometric statements into algebra using coordinates.
- Introduces vectors and vector operations in $\mathbb{R}^2$.
- Emphasizes vectors anchored at the origin and representation in a coordinate system.

---

#### 2. Formulae from Trigonometry

##### 2.1 Euler’s Formula
- Uses complex numbers and Euler’s formula to encode rotations.

##### 2.2 Formulae based on Euler’s Formula and Complex Multiplication
- Develops angle-sum style identities via complex multiplication.
- Includes a unit-circle discussion to interpret $\cos$ and $\sin$ geometrically.
- Provides a mnemnonic to remember sine and cosine values for commonly used angles.

---

#### 3. Example

##### 3.1 Reflection With Respect To a Line
- Studies reflection of a point $A$ across the line  
  $\qquad y = x\,\tan\phi$  
  using congruent-triangle geometry.
- Derives the reflection map as a **linear transformation** with an explicit $2\times2$ matrix depending on $\phi$.

###### Example
- Mirror image of a point for the specific line  
  $\qquad y = x\,\tan 30^\circ$.

##### 3.2 Orthogonal Projection Onto a Line
- Derives the orthogonal projection of a point onto the same line  
  $\qquad y = x\,\tan\phi$  
  and expresses it as multiplication by a $2\times2$ projection matrix.

###### Example
- Orthogonal projection onto  
  $\qquad y = x\,\tan 30^\circ$.

---

#### 4. Take Away
- Key tools: vectors and coordinates, Euler/trigonometric identities, and two explicit linear maps:  
  reflection through a line and orthogonal projection onto a line.

____
</details>



<details><summary><a href="A2_Matrix_Layout_Displays.ipynb" style="display:inline-block; width:9cm;">A2_Matrix_Layout_Displays.ipynb</a>
Visualization of matrices, block structure, and linear transformations
</summary>


### Contents

#### 0. Problems with Docker Images
- Notes rendering issues for SVG toolchains when running under Docker.
- Gives a workaround using a writable `keep_file` directory.

---

#### 1. Gaussian Elimination and Gauss–Jordan Elimination Examples

##### 1.1 Stack of Matrices
- Builds displays that stack matrices (or stages of an algorithm) into a single visual layout.

##### 1.2 Decorating a Matrix
- Demonstrates annotation/decoration of matrix entries.
- Includes sections on:
  - default formatting,
  - inserting symbols.

##### 1.3 Gaussian Elimination Example
- Shows a worked elimination display using the layout/decoration tools.

##### 1.4 Lower Code Level
- Exposes lower-level display construction to customize the layout.

---

#### 2. QR Examples

##### 2.1 Sympy Format Example
- Demonstrates rendering in a symbolic/pretty (SymPy-style) format.

##### 2.2 Floating Point Format Example
- Demonstrates formatting choices for floating-point display.

---

#### 3. Eigenproblem Tables

##### 3.1 Basic Eigenproblem Table
- Constructs a table-style display for eigenvalue/eigenvector computations.

##### 3.2 Spectral Theorem Table
- Constructs a display table tailored to the spectral theorem workflow.

##### 3.3 SVD Table
- Constructs a display table for SVD components and relationships.

---

### Role in the Notes
- This notebook is primarily about **visual layout and display functions** used by the algorithm notebooks.

____
</details>


<details><summary><a href="A3_SymbolicVariables.ipynb" style="display:inline-block; width:9cm;">A3_SymbolicVariables.ipynb</a>
Symbolic computation of matrices, determinants, eigenvalues
</summary>

### Contents

#### 1. Setup
- Imports/uses Julia packages for symbolic math and formatted display (SymPy via PyCall, plus table/LaTeX helpers).
- Includes an (inactive-by-default) cell to install required libraries.

---

#### 2. Symbolic variables
- Shows how to typeset symbols in markdown.
- Shows how to type Greek-letter identifiers in code (LaTeX name + tab completion).
- Declares symbolic variables using both:
  - `@syms ...` (Julia SymPy macro),
  - `symbols(...)` (SymPy constructor),

including examples with assumptions (e.g., `real=true`, `integer=true`, positivity).

---

#### 3. Matrix of Symbolic and Numeric Variables and Expressions
- Builds matrices containing symbolic variables and derived expressions.
- Demonstrates converting symbolic output into nicely formatted tables / LaTeX  
(including exporting expression output to a markdown cell, as shown in the notebook).

---

#### 4. Substitutions and Solutions
- Uses substitution into symbolic expressions.
- Uses `solve(...)` on simple symbolic equations, including examples where assumptions (e.g. positivity) change what solutions are returned.

---

### Role in the Notes
- Appendix aims to show how to use and display **symbolic variables**

____
</details>


<details><summary><a href="A4_GE_layout_display.ipynb" style="display:inline-block; width:9cm;">A4_GE_layout_display.ipynb</a>
Gaussian elimination layout display and animation; highlight pivots
</summary>

### Contents

#### 1. Display a Layout of the Gaussian Elimination Algorithm

##### 1.1 Basic Display Function: build a table from the matrices (DEPRECATED)
- Introduces an older display routine for presenting elimination stages.

##### 1.2 Gaussian Elimination for a given matrix $A$
- Constructs a staged layout of the elimination process for a specific input matrix.

##### 1.3 Modify `ge_layout` to highlight the pivots
- Extends the display to mark pivot locations explicitly.

##### 1.4 Add a slider to animate the computation
- Adds an interactive slider to animate through the elimination stages.

---

#### 2. Coding Assignment

##### 2.1 Some code building blocks
- 2.1.1 Submatrices
- 2.1.2 Conditional statements
- 2.1.3 Loop statements (`for` loops)

##### 2.2 Needed functionality: code snippets you will need to write
- Lists the specific helper snippets the assignment requires (as enumerated in the notebook).

---

#### 3. Having fun: what if we have errors in $A$?
- Explores perturbations and their qualitative effect on elimination/solutions.

##### 3.1 Errors in the matrix
##### 3.2 Errors in the right hand side
##### 3.3 Errors in both the matrix and the right hand side
##### 3.4 What if the system is almost inconsistent
- Uses these scenarios to illustrate sensitivity and near-inconsistency behavior.

---

### Role in the Notes
- Appendix focused on **visualizing GE** and giving a **coding exercise** tied to the visualization.

____
</details>

____
<details><summary><a href="A5_DrawingVectorsAndPlanes.ipynb" style="display:inline-block; width:9cm;">A5_DrawingVectorsAndPlanes.ipynb</a>
Drawing vectors, planes, and intersections in 2D/3D
</summary>

### Contents

#### 1. Basic Drawing Routines

##### 1.1 Implementation
- Implements Plotly-based primitives for 3D linear algebra figures, including:
  - a figure constructor with camera/range controls,
  - conversion of 2D vectors to 3D vectors (embedding in the $z=0$ plane),
  - vector arrows and line segments in $\mathbb{R}^3$,
  - coordinate-axis traces,
  - a plane trace spanned by two given basis vectors (with optional basis-vector arrows).

##### 1.2 Example
- Builds a scene from coordinate axes and several vectors/planes to demonstrate the routines and their parameters (scale, colors, camera position).

---

#### 2. Fundamental Theorem Example
- Uses a concrete $1\times 3$ matrix $A$ to visualize subspaces in $\mathbb{R}^3$:
  - a 2D plane representing a null-space basis (two spanning vectors),
  - a 1D line representing the row space direction (a spanning vector and its line extension).
- The visualization is presented as a Plotly pane inside a Panel layout.

##### Example
- A single-row matrix $A$ with:
  - a displayed null-space plane (two explicit basis vectors),
  - a displayed row-space line (the row vector direction).

____
</details>


<details><summary><a href="A6_GenerateProblems.ipynb" style="display:inline-block; width:9cm;">A6_GenerateProblems.ipynb</a>
Automatic generation of linear algebra practice problems
</summary>

### Contents

#### 1. GE Problems

##### 1.1 GE and GJ Problem with Layout
- Generates elimination problems (with options controlling pivots, zeros, multiple right-hand sides).
- Reduces augmented systems and displays intermediate matrices in a formatted “layout” style.

##### 1.2 GE with a Complex Matrix
- Generates and reduces a Gaussian elimination problem with complex entries.

##### 1.3 Inverse Problem with Layout
- Generates an inverse-computation problem presented in a step/layout display format.

##### 1.4 PLU Problem
- Generates a matrix factorization problem of PLU type and displays associated steps.

##### 1.5 Julia Wrapper Class for `ShowGE`
- Defines a wrapper/interface intended to streamline calling the elimination workflow and producing displays.

---

#### 2. Normal Equation Problems

##### 2.1 Solve the Normal Equation
- Generates least-squares/normal-equation style problems and checks solutions numerically.

---

#### 3. QR Problems
- Generates QR-related problems and demonstrates the associated computations/displays.

---

#### 4. Eigenproblems

##### 4.1 Eigenproblem for a Square Matrix
- Generates eigenvalue problems and compares computed results with symbolic/structured expectations where relevant.

##### 4.2 Eigenproblem for a Symmetrix Matrix
- Symmetric eigenproblem generation and computation.

##### 4.3 SVD
- Generates SVD problems (including rational/integer factoring for display) and produces an SVD “table” style layout.
- Includes the notebook’s explicit note that, with real floating point arithmetic, roundoff can change algebraic multiplicity behavior in ways that look qualitatively different.

---

#### Quick Tests
- Short verification cells that sanity-check generator outputs and computations.

#### Live Demos
- Interactive/demo-style cells using the generator and layout tools.

____
</details>


<details><summary><a href="A7_PythonWithJavascript.ipynb" style="display:inline-block; width:9cm;">A7_PythonWithJavascript.ipynb</a>
Integrating Python with JavaScript (Panel JSComponent)
</summary>

### Contents

#### 1. Javascript Sends Array to Python
- Implements a custom `JSComponent` that generates arrays in JavaScript and sends them into a Python-side parameter.
- Demonstrates repeated updates (with a stop condition) and Python-side receipt/inspection of the data.

---

#### 2. Python Sends Array to Two Javascript Loggers
- Implements a Python-side component that emits an array to JavaScript.
- Uses two JavaScript “logger” views to show the same transmitted data in separate panels.

---

#### 3. Draw Moving Objects with P5.js
- Embeds a p5.js sketch inside a Panel component.
- Demonstrates animation control/state (start/stop style logic) and dynamic drawing.

---

#### 4. Geometrical Construction with JSXgraph
- Embeds a JSXGraph board as a custom JS component.
- Demonstrates constructing and rendering geometric objects and math text inside the JSXGraph canvas.

____
</details>


<details><summary><a href="A8_Julia_LaTeX_Utilities.ipynb" style="display:inline-block; width:9cm;">A8_Julia_LaTeX_Utilities.ipynb</a>
Julia utilities for generating LaTeX expressions from julia objects and rendering these in jupyter notebooks
</summary>

### Contents

#### 1. HTML Functions
- Defines small HTML helpers for consistent styled output (titles, subtitles, colored/justified text blocks).
- Demonstrates side-by-side display of outputs from multiple functions for teaching/worksheet layouts.

---

#### 2. LaTeX Rendering Function

- Introduces `l_show` utilities that display Julia objects together with a LaTeX representation suitable for copying into notes.

##### Supported objects (as exercised in the notebook)
- Scalars (integers, floats, rationals, complex numbers).
- Vectors and matrices (including formatting controls).
- SymPy objects and LaTeXStrings.

##### Support functions
- Formatter hooks used to customize per-entry rendering (e.g., bold/italic formatting functions and cell-wise formatters).

---

#### 2.1 Scalars
- Demonstrates `l_show` output for multiple scalar types (including rational and complex variants).

#### 2.2 Vectors
- Demonstrates `l_show` for vectors, including formatting/rounding behaviors.

#### 2.3 Matrices
- Demonstrates `l_show` for matrices, including structured formatting suitable for algorithm tables.

---

#### Additional Tests
- A large test suite calling `test_L_show(...)` across many numeric and symbolic types to validate coverage and formatting consistency.

____
</details>
