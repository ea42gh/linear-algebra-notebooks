# Elementary Linear Algebra

Jupyter Notebooks used in class and with the youtube channel lectures

The channel is at https://www.youtube.com/playlist?list=PLBDUlnmEqyXD_llq6wETUqRkJGRiu8wFU

The notebooks use both Julia and Python. To use interactively,
you may have to install the libraries.

The itikz python library is used to generate figures of the matrix operations using LaTeX.<br>
The itikz directory of this library must be in your python path.
Install from
*   https://github.com/ea42gh/itikz

Some of the Julia Notebooks use a (mostly outdated) package LAcode.jl
>   using Pkg
>   Pkg.develop(path="location_of_the_directory/LAcode.jl")


Jupyter Notebooks illustrating Elementary Linear Algebra Concepts and Algorithms

  | Notebook                        | Comment                          | 
  | ----------------------------    | -------------------------------- | 
  | 01_ScalarsVectorsMatrices.ipynb | Introduction                     | 
  | 02_AddScalarMultDotprod.ipynb   | Linear Combinations, Span        | 
  | 03_MatrixMultiplication.ipynb   | Dot Product, Matrix Product      | 
  | 04_RowEchelonForm_Systems.ipynb | Backsubstitution                 | 
  | 05_GE_Systems.ipynb             | Gaussian Elimination (Part I)    | 
  | ----------------------------    | -------------------------------- | 
  | SymbolicVariables.ipynb         | using sympy from Julia           | 
  | GE_layout_display.ipynb         | Matrix Multiplication display    | 
  | LAcodes.jl                      | Support Functions (Julia code)   | 
  | ----------------------------    | -------------------------------- | 

Software used:
1. holoviews, Panel from http://holoviz.org/
2. Julia Language with various packages, https://julialang.org/
3. a modified version of itikz,  https://github.com/ea42gh/itikz
