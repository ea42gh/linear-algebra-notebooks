# https://github.com/jupyter/docker-stacks/blob/main/images/datascience-notebook/README.md
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
ARG REGISTRY=quay.io
ARG OWNER=jupyter
ARG BASE_IMAGE=$REGISTRY/$OWNER/scipy-notebook
FROM $BASE_IMAGE

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
# enable sudo for jovyan
RUN usermod -aG sudo jovyan && \
    echo "jovyan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# itikz related requirements
RUN apt-get update -y && \
    apt-get install --yes --no-install-recommends \
    git pdf2svg xclip ffmpeg \
    fonts-liberation fonts-dejavu fonts-hack \
    graphviz graphviz-dev vim-tiny \
    latexmk \
    run-one \
    inkscape \
    dvipng dvisvgm 

# make sure all of the following CTAN packages are installed
RUN apt-get install --upgrade --yes --no-install-recommends \
    texlive-pstricks \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-publishers \
    texlive-science \
    texlive-pictures

# Julia dependencies
# install Julia packages in /opt/julia instead of ${HOME}
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia

# Setup Julia
RUN /opt/setup-scripts/setup_julia.py

USER ${NB_UID}

# Add additional Python libraries

RUN python -m pip install git+https://github.com/ea42gh/itikz.git && \
    git clone https://gitlab.com/ea42gh/elementary-linear-algebra.git && \
    git clone https://github.com/ea42gh/itikz.git

RUN \
    python -m pip install k3d && \
    python -m pip install holoviews[recommended] && \
    python -m pip install hvplot && \
    python -m pip install streamz && \
    python -m pip install networkx && \
    python -m pip install --upgrade webio_jupyter_extension && \
    python -m pip install streamz && \
    python -m pip install graphviz


RUN python -m pip install pygraphviz && \
    python -m pip install julia

# Setup IJulia kernel & other packages
RUN /opt/setup-scripts/setup-julia-packages.bash

# Add additional Julia Packages
RUN julia -e 'import Pkg; Pkg.update(); p = [ "AbstractAlgebra", "LinearAlgebra", "Hadamard", "Random", "RowEchelon", "Latexify", "LaTeXStrings", "QuadGK"]; Pkg.add.(p);'
RUN julia -e 'import Pkg; Pkg.update(); p = [ "Polynomials", "Colors", "Plots", "Interact", "SymPy", "Distributions", "Images", "ImageView", "TestImages"]; Pkg.add.(p);'
RUN julia -e 'import Pkg; Pkg.update(); p = [ "NearestNeighbors", "MosaicViews", "PrettyTables", "PyCall", "Revise", "CSV", "DataFrames", "RDatasets", "StatsBase", "StatsPlots", "PlotlyJS"]; Pkg.add.(p);'
RUN julia -e 'import Pkg; Pkg.activate("elementary-linear-algebra/GenLinAlgProblems");Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'
RUN julia -e 'import Pkg; Pkg.update()'

# final tweaks
RUN echo -e "\
export PS1='-> ' \n\
export PS2='->>  ' \n\
" > .bashrc

RUN git config --global credential.helper store

#RUN mkdir ${HOME}/work

USER root
WORKDIR $HOME
#RUN patch /usr/bin/latexmk < itikz/patch.latexmk

VOLUME ${HOME}/work

USER ${NB_UID}
WORKDIR $HOME/elementary-linear-algebra

# keep itikz and elementary-linear-algebra so we can use git to update them
RUN ln -s /tmp tmp && \
    ln -s ../work work && \
    rm -rf bin binder tasks .gitignore \
       README.md Makefile tex2svg textosvg.py xetex2svg \
       notebooks/WorkedExamples

RUN fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
