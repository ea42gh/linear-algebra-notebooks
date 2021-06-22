# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

FROM ubuntu:20.10

USER root
# ================================================================================= USER
ARG NB_USER=user
ARG NB_UID=1000
ARG NB_GID=100
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

ENV JUPYTER_ENABLE_LAB 'yes'

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]


# =====================================================================   base notebook
ARG conda_version="4.10.1"
ARG miniforge_patch_number="0"
ARG miniforge_arch="x86_64"
ARG miniforge_python="Mambaforge"

ARG miniforge_version="${conda_version}-${miniforge_patch_number}"
ARG miniforge_installer="${miniforge_python}-${miniforge_version}-Linux-${miniforge_arch}.sh"
ARG miniforge_checksum="d4065b376f81b83cfef0c7316f97bb83337e4ae27eb988828363a578226e3a62"

# Install all OS dependencies for notebook server that starts but lacks all features (e.g., download as all possible file formats)
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    tini \
    wget \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    software-properties-common \
    run-one && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Configure environment
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    NB_USER=$NB_USER \
    NB_UID=$NB_UID \
    NB_GID=$NB_GID \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8
ENV PATH=$CONDA_DIR/bin:$PATH \
    HOME=/home/$NB_USER \
    CONDA_VERSION="${conda_version}" \
    MINIFORGE_VERSION="${miniforge_version}"

# Copy a script that we will use to correct permissions after running certain commands
COPY binder/fix-permissions /usr/local/bin/fix-permissions
RUN chmod a+rx /usr/local/bin/fix-permissions

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
# hadolint ignore=SC2016
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc && \
   # Add call to conda init script see https://stackoverflow.com/a/58081608/4413446
   echo 'eval "$(command conda shell.bash hook 2> /dev/null)"' >> /etc/skel/.bashrc

# Create NB_USER with name jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -l -m -s /bin/bash -N -g users -u $NB_UID $NB_USER

RUN mkdir -p $CONDA_DIR && \
    chown $NB_USER:$NB_GID $CONDA_DIR && \
    chmod g+w /etc/passwd && \
    fix-permissions "${HOME}" && \
    fix-permissions "${CONDA_DIR}"

USER $NB_UID
ARG PYTHON_VERSION="3.8"

# Setup work directory for backward-compatibility
RUN mkdir "/home/$NB_USER/work" && \
    fix-permissions "/home/${NB_USER}"

# Install conda as jovyan and check the sha256 sum provided on the download site
WORKDIR /tmp

# Prerequisites installation: conda, mamba, pip, tini
RUN wget --quiet "https://github.com/conda-forge/miniforge/releases/download/${miniforge_version}/${miniforge_installer}" && \
    echo "${miniforge_checksum} *${miniforge_installer}" | sha256sum --check && \
    /bin/bash "${miniforge_installer}" -f -b -p $CONDA_DIR && \
    rm "${miniforge_installer}" && \
    # Conda configuration see https://conda.io/projects/conda/en/latest/configuration.html
    echo "conda ${CONDA_VERSION}" >> $CONDA_DIR/conda-meta/pinned && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true && \
    if [ ! $PYTHON_VERSION = 'default' ]; then conda install --yes python=$PYTHON_VERSION; fi && \
    conda list python | grep '^python ' | tr -s ' ' | cut -d '.' -f 1,2 | sed 's/$/.*/' >> $CONDA_DIR/conda-meta/pinned && \
    conda install --quiet --yes \
    "conda=${CONDA_VERSION}" \
    'pip' && \
    conda update --all --quiet --yes && \
    conda clean --all -f -y && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install Jupyter Notebook, Lab, and Hub
#     Generate a notebook server config
#     Cleanup temporary files
#     Correct permissions
#     Do all this in a single RUN command to avoid duplicating all of the files across image layers when the permissions change
RUN conda install --quiet --yes \
    'notebook' \
    'jupyterhub' \
    'jupyterlab' && \
    conda clean --all -f -y && \
    npm cache clean --force && \
    jupyter notebook --generate-config && \
    jupyter lab clean && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

EXPOSE 8888

# Copy local files as late as possible to avoid cache busting
COPY binder/start.sh binder/start-notebook.sh binder/start-singleuser.sh /usr/local/bin/
# Currently need to have both jupyter_notebook_config and jupyter_server_config to support classic and lab
COPY binder/jupyter_notebook_config.py /etc/jupyter/

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Fix permissions on /etc/jupyter as root
USER root

# Prepare upgrade to JupyterLab V3.0 #1205
RUN sed -re "s/c.NotebookApp/c.ServerApp/g" \
    /etc/jupyter/jupyter_notebook_config.py > /etc/jupyter/jupyter_server_config.py && \
    fix-permissions /etc/jupyter/


# =====================================================================   minimal notebook
# Install all OS dependencies for fully functional notebook server
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    build-essential \
    vim-tiny \
    git \
    inkscape \
    dvipng \
    dvisvgm \
    evince \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    # ---- nbconvert dependencies ----
    texlive-full \
    texlive-fonts-extra \
    # ----
    tzdata \
    unzip \
    nano-tiny && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create alternative for nano -> nano-tiny
RUN update-alternatives --install /usr/bin/nano nano /bin/nano-tiny 10

# =====================================================================   base notebook

# Julia installation
# Default values can be overridden at build time
# (ARGS are in lower case to distinguish them from ENV)
# Check https://julialang.org/downloads/
ARG julia_version="1.6.1"

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
    fix-permissions "${JULIA_PKGDIR}"

USER $NB_UID

# Add Julia packages.
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.
RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("HDF5")' && \
    julia -e 'using Pkg; pkg"add IJulia"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add LinearAlgebra"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add RowEchelon"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add Latexify"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add LaTeXStrings"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add Plots"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add Pluto"; pkg"precompile"' && \
    julia -e 'using Pkg; pkg"add PyCall"; pkg"precompile"' && \
    # move kernelspec out of home \
    mv "${HOME}/.local/share/jupyter/kernels/julia"* "${CONDA_DIR}/share/jupyter/kernels/" && \
    chmod -R go+rx "${CONDA_DIR}/share/jupyter" && \
    rm -rf "${HOME}/.local" && \
    fix-permissions "${JULIA_PKGDIR}" "${CONDA_DIR}/share/jupyter"

### =====================================================================   scipy notebook
USER $NB_UID
WORKDIR $HOME

RUN conda install \
    altair \
    beautifulsoup4 \
    bokeh \
    bottleneck \
    cloudpickle \
    conda-forge::blas \
    curl \
    cython \
    dask \
    dill \
    h5py \
    ipympl\
    ipywidgets \
    jupyter_bokeh \
    jupyter-vscode-proxy \
    k3d \
    matplotlib-base \
    numba \
    numexpr \
    numpy \
    pandas \
    patsy \
    pdf2svg \
    pydeck \
    pyarrow \
    protobuf \
    pytables \
    scikit-image \
    scipy \
    seaborn \
    sqlalchemy \
    statsmodels \
    sympy \
    widgetsnbextension \
    xlrd && \
    conda update --all -y && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
#RUN \
#    jupyter nbextension enable codefolding/main
#    jupyter nbextension enable collapsible_headings/main
#    jupyter nbextension enable comment-uncomment/main
#    jupyter nbextension enable hide_input/main
#    jupyter nbextension enable scratchpad/main
#    jupyter nbextension enable init_cell/main
#    jupyter labextension install @jupyter-widgets/jupyterlab-manager
#    jupyter labextension install k3d

RUN conda install -c conda-forge jupyter_contrib_nbextensions
RUN pip3 install pycharts

RUN conda install -c conda-forge --yes \
    code-server \
    panel holoviews hvplot colorcet param datashader

USER root

# ffmpeg for matplotlib anim & dvipng+cm-super for latex labels
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends ffmpeg dvipng cm-super && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# =====================================================================   start
#USER root
#RUN curl https://static.geogebra.org/linux/office@geogebra.org.gpg.key | gpg --dearmor | sudo dd of=/usr/keyrings/riot-archive-keyring.gpg && \
#    apt-add-repository -u 'deb http://www.geogebra.net/linux/ stable main' && \
#    apt-get update --yes && \
#    apt install geogebra-classic && \
#    apt-get install --yes --no-install-recommends ffmpeg dvipng cm-super && \

RUN rm -rf /tmp/*

WORKDIR /tmp
RUN echo "======================================================= update nicematrix" && \
    curl -fL -o nicematrix.dtx  "http://mirrors.ctan.org/macros/latex/contrib/nicematrix/nicematrix.dtx" && \
    curl -fL -o nicematrix.ins  "http://mirrors.ctan.org/macros/latex/contrib/nicematrix/nicematrix.ins" && \
    latex nicematrix.ins && \
    cp nicematrix.sty /usr/share/texlive/texmf-dist/tex/latex/nicematrix

USER $NB_UID
WORKDIR $HOME

RUN mkdir notebooks
COPY notebooks notebooks
RUN ln -s /tmp tmp
#RUN jupyter trust $(find notebooks -name '*.ipynb')

#RUN echo "======================================================= update nicematrix"
#RUN mkdir -p texmf/tex/latex && \
#    mkdir NiceMatrix && \
#    cd NiceMatrix && \
#    curl -fL -o nicematrix.dtx  "http://mirrors.ctan.org/macros/latex/contrib/nicematrix/nicematrix.dtx" && \
#    curl -fL -o nicematrix.ins  "http://mirrors.ctan.org/macros/latex/contrib/nicematrix/nicematrix.ins" && \
#    latex nicematrix.ins && \
#    cp nicematrix.sty ../texmf/tex/latex && \
#    cd .. && \
#    rm -rf NiceMatrix && \
#    export TEXMFHOME=$PWD/texmf && \
#    texhash $PWD/texmf && \
#    echo $(ls texmf)

RUN echo "======================================================= enable nbextensions"
RUN \
    jupyter nbextension enable codefolding/main && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable comment-uncomment/main && \
    jupyter nbextension enable hide_input/main && \
    jupyter nbextension enable scratchpad/main && \
    jupyter nbextension enable init_cell/main && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install k3d

RUN echo "======================================================= install itikz"
RUN pip install git+https://github.com/ea42gh/itikz.git

RUN conda update --all

RUN code-server --install-extension ms-python.python && \
    SERVICE_URL=https://open-vsx.org/vscode/gallery ITEM_URL=https://open-vsx.org/vscode/item code-server --install-extension wesbos.theme-cobalt2 && \
    SERVICE_URL=https://open-vsx.org/vscode/gallery ITEM_URL=https://open-vsx.org/vscode/item code-server --install-extension RandomFractalsInc.vscode-data-preview && \
    SERVICE_URL=https://open-vsx.org/vscode/gallery ITEM_URL=https://open-vsx.org/vscode/item code-server --install-extension RandomFractalsInc.geo-data-viewer && \
    SERVICE_URL=https://open-vsx.org/vscode/gallery ITEM_URL=https://open-vsx.org/vscode/item code-server --install-extension ritwickdey.liveserver

WORKDIR $HOME
