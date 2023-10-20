FROM jupyter/base-notebook:lab-4.0.5

USER root
WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y \
    pip \
    git \
    wget \
    openssh-client \
    nano-tiny \
    tzdata \
    unzip \
    vim-tiny \
    openssh-client \
    fonts-dejavu fonts-hack \
    build-essential \
    pdf2svg \
    xclip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10
RUN chpasswd <<<"jovyan:password"

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# ==============================================================================
RUN apt-get update && \
    apt-get install -y \
    graphviz graphviz-dev \
    ffmpeg

RUN conda update --all -y
#RUN conda update --all -y && \
#    conda install -c conda-forge -y k3d pdf2svg sympy
#RUN conda install -c conda-forge -y graphviz python-graphviz ffmpeg
#RUN conda install -c conda-forge -y gcc

#RUN conda clean --all -f -y && \
#    fix-permissions /opt/conda

USER ${NB_UID}
RUN pip install sympy && \
    pip install numpy && \
    pip install numpy && \
    pip install k3d
RUN pip install pygraphviz

RUN pip install holoviews[recommended]
RUN pip install plotly
RUN pip install scipy
RUN pip install julia

USER root
# enable jupyter extensions
#RUN pip install jupyter_contrib_nbextensions
##RUN pip install jupyter_nbextensions_configurator
##_RUN jupyter contrib nbextension install --user

##_#RUN pip install -U jupyter_nbextensions_configurator
##_#RUN jupyter nbextensions_configurator enable --system
##_
##_RUN jupyter nbextension install --sys-prefix --py jupyter_nbextensions_configurator --overwrite  && \
##_    jupyter nbextension enable --sys-prefix --py jupyter_nbextensions_configurator && \
##_    jupyter serverextension enable --sys-prefix --py jupyter_nbextensions_configurator
##_

# turn on extensions
##_RUN jupyter nbextension enable collapsible_headings/main
##_RUN jupyter nbextension enable rubberband/main
##_RUN jupyter nbextension enable toc2/main
##_RUN jupyter nbextension enable codefolding/main
##_RUN jupyter nbextension enable scratchpad/main
##_RUN jupyter nbextension enable --py widgetsnbextension

RUN pip install --upgrade webio_jupyter_extension

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    sudo \
    locales \
    texlive-pstricks \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-publishers \
    texlive-science \
    texlive-pictures \
    latexmk \
    fonts-liberation \
    run-one \
    vim-tiny \
    inkscape \
    dvipng dvisvgm \
    && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Make NB_USER a sudoer
RUN usermod -aG sudo jovyan
RUN adduser $NB_USER sudo \
 && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN conda clean --all -f -y && \
    npm cache clean --force && \
    jupyter lab clean

# ============================================================================================================
# Julia installation
# Default values can be overridden at build time
# (ARGS are in lower case to distinguish them from ENV)
# Check https://julialang.org/downloads/
ARG julia_version="1.9.3"

# ============================================================================================================
# Julia dependencies
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_DEPOT_PATH=/opt/julia \
    JULIA_PKGDIR=/opt/julia \
    JULIA_VERSION="${julia_version}"

WORKDIR /tmp

# hadolint ignore=SC2046
RUN mkdir "/opt/julia-${JULIA_VERSION}" && \
    wget -q https://julialang-s3.julialang.org/bin/linux/x64/$(echo "${JULIA_VERSION}" | cut -d. -f 1,2)"/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" && \
    tar xzf "julia-${JULIA_VERSION}-linux-x86_64.tar.gz" -C "/opt/julia-${JULIA_VERSION}" --strip-components=1 && \
    rm "/tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz" && \
    ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia

# Show Julia where conda libraries are \
RUN mkdir /etc/julia && \
    echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir "${JULIA_PKGDIR}" && \
    chown "${NB_USER}" "${JULIA_PKGDIR}" && \
    fix-permissions "${JULIA_PKGDIR}" && \
    echo "========================================================================= HAVE julia"

RUN fix-permissions $HOME
USER ${NB_UID}
WORKDIR $HOME
RUN julia -e 'import Pkg; Pkg.update(); p = [ "IJulia", "AbstractAlgebra", "LinearAlgebra", "Hadamard", "Random", "RowEchelon", "Latexify", "LaTeXStrings", "Polynomials", "ImageView", "Colors", "Plots", "Interact", "SymPy", "Distributions", "Images", "TestImages", "NearestNeighbors", "MosaicViews", "PrettyTables", "PyCall", "Revise", "CSV", "DataFrames", "RDatasets", "StatsBase", "StatsPlots", "PlotlyJS"]; Pkg.add.(p); Pkg.build.(p)'

RUN echo "PS1='-> '" >> .bashrc
RUN echo "PS2='->>  '" >> .bashrc

RUN pip install git+https://github.com/ea42gh/itikz.git
RUN git clone https://gitlab.com/ea42gh/elementary-linear-algebra.git

WORKDIR $HOME
RUN ln -s /tmp tmp && \
    mv elementary-linear-algebra/* . && \
    rm -rf bin binder tasks .gitignore \
       README.md Makefile tex2svg textosvg.py xetex2svg \
       notebooks/WorkedExamples && \
    rm -rf elementary-linear-algebra

USER root
RUN rm /tmp/*
WORKDIR $HOME
RUN fix-permissions /opt/conda
RUN fix-permissions $HOME

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER $NB_USER
WORKDIR $HOME
