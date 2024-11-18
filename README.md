# Elementary Linear Algebra

Jupyter Notebooks illustrating Elementary Linear Algebra Concepts and Algorithms

Youtube channel for these notebooks:
[YouTube Playlist](https://www.youtube.com/playlist?list=PLBDUlnmEqyXD_llq6wETUqRkJGRiu8wFU)

Binder access to these notebooks:

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/master?urlpath=lab/tree/notebooks/Index.ipynb) opens Index.ipynb with jupyter lab

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/HEAD?urlpath=tree)   opens a directory view<br>
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gl/ea42gh%2Felementary-linear-algebra/master?filepath=notebooks/Index.ipynb) opens Index.ipynb with links to individual notebooks<br>
* The notebook **Index.ipynb** lists currently available notebooks.
* The Notes directory is an [obsidian](https://obsidian.md/) vault listing the headings found in each notebook<br>
It is intended as a starting point for individualized notes.

The languages used are Julia and Python. The binder environment creates the following directory structure:
* notebooks  : readonly: the Jupyter notebooks used for the YouTube channel lectures
* work : writable directory used to create notebooks and do computations
* tmp :  a link to the /tmp directory used for temporary file storage

In addition to the julia and python languages, a number of packages are installed:<br>
The **itikz** python library in particular is used to generate figures of the matrix operations using **LaTeX**.<br>
When installing these files locally, the itikz directory of this library must be in your python path.<br>
Itikz is located at:
*   https://github.com/ea42gh/itikz

Other software used:
* Holoviews, Panel from http://holoviz.org/
To see the commands used to install all relevant packages and libraries,
check out the binder/Dockerfile in this directory.
____
Rather than installing the notebooks and their dependencies locally, one may choose to create and run a docker image:<br>
Issue the following command in the binder subdirectory to create an image:<br>
> docker build . -t la_image

To update the notebooks, issue the following command in the elementary-linear-algebra file tree:
> git fetch --all
> git reset --hard origin/main
(Note: this will undo any local changes in all directories except the work directory.)
