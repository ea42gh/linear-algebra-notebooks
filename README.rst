=====
Elementary Linear Algebra
=====

Jupyter Notebooks used in class and with the youtube channel lectures

The channel is at https://www.youtube.com/playlist?list=PLBDUlnmEqyXD_llq6wETUqRkJGRiu8wFU

The notebooks use both Julia and Python. To use interactively,
you may have to install the libraries.

The itikz python library is used to generate figures of the matrix operations using LaTeX. Install from

.. code:: sh

    https://github.com/ea42gh/itikz
The itikz directory must be in your python path.

Some of the Julia Notebooks use a (mostly outdated) package LAcode.jl
To install it, run

.. code:: julia

   using Pkg
   Pkg.develop(path="location_of_the_directory/LAcode.jl")

