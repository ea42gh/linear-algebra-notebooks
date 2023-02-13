FROM jupyter/base-notebook

USER root
WORKDIR /tmp

RUN apt-get update
RUN apt-get install -y \
    git \
    wget \
    openssh-client \
    nano-tiny \
    tzdata \
    unzip \
    vim-tiny \
    openssh-client \
    fonts-dejavu fonts-hack \
    xclip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10
RUN chpasswd <<<"jovyan:password"

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# ==============================================================================
RUN conda update --all -y && \
    conda install -c conda-forge -y k3d pdf2svg sympy \
    graphviz python-graphviz ffmpeg \
    gcc

RUN conda clean --all -f -y && \
    fix-permissions /opt/conda

USER ${NB_UID}
RUN pip install holoviews[recommended]

USER root
# enable jupyter extensions
RUN pip install -U jupyter_contrib_nbextensions
RUN pip install -U jupyter_nbextensions_configurator
RUN jupyter contrib nbextension install
RUN jupyter nbextensions_configurator enable
# turn on extensions
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable rubberband/main
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable scratchpad/main
RUN jupyter nbextension enable --py widgetsnbextension

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

RUN pip install git+https://github.com/ea42gh/itikz.git
RUN conda clean --all -f -y && \
    npm cache clean --force && \
    jupyter lab clean

# ============================================================================================================
# Julia installation
# Default values can be overridden at build time
# (ARGS are in lower case to distinguish them from ENV)
# Check https://julialang.org/downloads/
ARG julia_version="1.8.5"

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
RUN julia -e 'import Pkg; Pkg.update(); p = [ "IJulia", "LinearAlgebra", "Hadamard", "Random", "RowEchelon", "Latexify", "LaTeXStrings", "Plots", "Interact", "SymPy", "Distributions", "Images", "TestImages", "MosaicViews", "PrettyTables", "PyCall", "Revise"]; Pkg.add.(p); Pkg.build.(p)'

RUN echo "PS1='-> '" >> .bashrc
RUN echo "PS2='->>  '" >> .bashrc

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
