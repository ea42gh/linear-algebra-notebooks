# Elementary Linear Algebra

Jupyter Notebooks illustrating Elementary Linear Algebra Concepts and Algorithms
[YouTube Playlist](https://www.youtube.com/playlist?list=PLBDUlnmEqyXD_llq6wETUqRkJGRiu8wFU)

The notebooks can be accessed directly from binder:
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/HEAD?urlpath=lab)

The languages used are Julia and Python. The binder environment creates the following directory structure:
* notebooks  : readonly: the Jupyter notebooks used for the YouTube channel lectures
* work : writable directory used to create notebooks and do computations
* tmp :  a link to the /tmp directory used for temporary file storage

In addition to the julia and python languages, a number of packages are installed:<br>
The **itikz** python library is used to generate figures of the matrix operations using **LaTeX**.<br>
When installing these files locally, the itikz directory of this library must be in your python path.<br>
Itikz is located at:
*   https://github.com/ea42gh/itikz

Some of the Julia Notebooks use a (mostly outdated) package LAcode.jl<br>
To use, execute the following in Julia:
>   using Pkg<br>
>   Pkg.develop(path="location_of_the_directory/LAcode.jl")


Other software used:
* Holoviews, Panel from http://holoviz.org/
