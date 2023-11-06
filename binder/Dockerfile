# original file from https://github.com/abelsiqueira/python-and-julia
#FROM ubuntu:23.10
FROM ubuntu:22.04

#ARG PYTHON_VERSION=3.12.0
ARG PYTHON_VERSION=3.11.4
ARG JULIA_VERSION=1.9.3

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

ENV container docker
ENV DEBIAN_FRONTEND noninteractive
#ENV LANG en_US.utf8
ENV MAKEFLAGS -j4

RUN mkdir /app
WORKDIR /app

# DEPENDENCIES
#===========================================
RUN apt-get update -y && \
    apt-get install -y gcc make wget libffi-dev \
        build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev \
        libncurses5-dev libncursesw5-dev xz-utils \
        git pdf2svg xclip ffmpeg \
        fonts-liberation fonts-dejavu fonts-hack \
        graphviz graphviz-dev vim-tiny


# INSTALL PYTHON
#===========================================
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz && \
    tar -zxf Python-$PYTHON_VERSION.tgz && \
    cd Python-$PYTHON_VERSION && \
    ./configure --with-ensurepip=install --enable-shared && make && make install && \
    ldconfig && \
    ln -sf python3 /usr/local/bin/python
RUN python -m pip install --upgrade pip setuptools wheel && \
    python -m pip install julia

# INSTALL JULIA
#====================================
RUN wget https://raw.githubusercontent.com/abelsiqueira/jill/main/jill.sh && \
    bash /app/jill.sh -y -v $JULIA_VERSION && \
    export PYTHON="python" && \
    julia -e 'using Pkg; Pkg.add("PyCall")' && \
    python -c 'import julia; julia.install()'

# CLEAN UP
#===========================================
RUN rm -rf /app/jill.sh \
    /opt/julias/*.tar.gz \
    /app/Python-$PYTHON_VERSION.tgz

RUN apt-get purge -y gcc make wget zlib1g-dev libffi-dev libssl-dev \
        libbz2-dev libreadline-dev \
        libncurses5-dev libncursesw5-dev xz-utils && \
    apt-get autoremove -y

RUN pip install jupyterlab notebook nbclassic

# ------------------------------------------------------------ local USER
# Configure environment
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER="${NB_USER}" \
    NB_UID=${NB_UID} \
    NB_GID=${NB_GID} \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH="${CONDA_DIR}/bin:/home/${NB_USER}/.local/bin:${PATH}" \
    HOME="/home/${NB_USER}"

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
# hadolint ignore=SC2016
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc && \
   # Add call to conda init script see https://stackoverflow.com/a/58081608/4413446
   echo 'eval "$(command conda shell.bash hook 2> /dev/null)"' >> /etc/skel/.bashrc

# Create NB_USER with name jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN apt-get install -y sudo && \
    echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd --no-log-init --create-home --shell /bin/bash --uid "${NB_UID}" --no-user-group "${NB_USER}" && \
    mkdir -p "${CONDA_DIR}" && \
    chown "${NB_USER}:${NB_GID}" "${CONDA_DIR}" && \
    chmod g+w /etc/passwd

RUN usermod -aG sudo jovyan && \
    adduser $NB_USER sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

RUN apt-get install -y nodejs npm && \
    npm install -g mystmd

RUN apt-get install ca-certificates
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install --yes --no-install-recommends \
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
    run-one \
    inkscape \
    dvipng dvisvgm 

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER $NB_USER
WORKDIR $HOME

RUN pip install sympy && \
    pip install numpy && \
    pip install pandas && \
    pip install k3d   && \
    pip install holoviews[recommended] && \
    pip install hvplot && \
    pip install plotly && \
    pip install streamz && \
    pip install scipy && \
    pip install jupyterlab_myst && \
    pip install --upgrade webio_jupyter_extension && \
    pip install pygraphviz && \
    pip install julia && \
    pip install git+https://github.com/ea42gh/itikz.git && \
    git clone https://gitlab.com/ea42gh/elementary-linear-algebra.git

RUN julia -e 'import Pkg; Pkg.update(); p = [ "IJulia", "AbstractAlgebra", "LinearAlgebra", "Hadamard", "Random", "RowEchelon", "Latexify", "LaTeXStrings", "Polynomials", "Colors", "Plots", "Interact", "SymPy", "Distributions", "Images", "TestImages", "NearestNeighbors", "MosaicViews", "PrettyTables", "PyCall", "Revise", "CSV", "DataFrames", "RDatasets", "StatsBase", "StatsPlots", "PlotlyJS"]; Pkg.add.(p);' && \
    julia -e 'import Pkg; Pkg.activate("elementary-linear-algebra/GenLinAlgProblems");Pkg.instantiate(); Pkg.resolve(); Pkg.precompile()'

RUN echo -e "\
export PS1='-> ' \n\
export PS2='->>  ' \n\
" > .bashrc

USER root
WORKDIR /tmp

RUN jupyter server --generate-config && \
    npm cache clean --force && \
    jupyter lab clean && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


ENV JUPYTER_PORT=8888
EXPOSE $JUPYTER_PORT

# Configure container startup
CMD ["start-notebook.py"]

# Copy local files as late as possible to avoid cache busting
WORKDIR $HOME/elementary-linear-algebra/binder
COPY start-notebook.py start-notebook.sh start-singleuser.py start-singleuser.sh /usr/local/bin/
COPY jupyter_server_config.py docker_healthcheck.py /etc/jupyter/
COPY run-hooks.sh start.sh /usr/local/bin/
COPY fix-permissions /usr/local/bin/fix-permissions
RUN chmod a+rx /usr/local/bin/fix-permissions && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}" && \
    fix-permissions /etc/jupyter

RUN mkdir /usr/local/bin/start-notebook.d && \
    mkdir /usr/local/bin/before-notebook.d

HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
    CMD /etc/jupyter/docker_healthcheck.py || exit 1

USER $NB_USER
WORKDIR $HOME

RUN ln -s /tmp tmp && \
    mv elementary-linear-algebra/* . && \
    rm -rf bin binder tasks .gitignore \
       README.md Makefile tex2svg textosvg.py xetex2svg \
       notebooks/WorkedExamples && \
    rm -rf elementary-linear-algebra

