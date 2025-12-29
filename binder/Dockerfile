FROM ea42gh/base_image:1.0.2

# =================================================
# 1) Multi-arch build
# 2) One python 3.12 and on Julia 1.12  that are known to work together
# 3) headless precompile strategy for julia packages

# =================================================
# System dependencies (Python + Julia ecosystem)
# =================================================
USER root

# ---- build deps for Python, xterm ----
RUN apt-get update && apt-get install -y \
    tk-dev \
    readline-common \
    ncurses-term \
 && rm -rf /var/lib/apt/lists/*

# =================================================
USER jovyan

SHELL ["/bin/bash", "-lc"]
ENV TERM=xterm-256color
ENV HISTFILE=/home/jovyan/work/.bash_history
RUN echo '\
export EDITOR=vi \n\
export VISUAL=vi \n\
set -o vi  \n\
' >> /home/jovyan/.bashrc
COPY binder/inputrc /home/jovyan/.inputrc

# =================================================
# Environment: force PythonCall to system Python
# =================================================
ENV HOME=/home/jovyan
ENV JULIA_DEPOT_PATH=/home/jovyan/.julia

ENV JULIA_BINDIR=/usr/local/julia/bin
ENV JULIA_CONDAPKG_BACKEND=Null
ENV JULIA_PYTHONCALL_EXE=/usr/local/bin/python3

#ENV LD_LIBRARY_PATH=/usr/local/julia/lib
ENV PATH=/usr/local/julia/bin:$PATH

ENV JULIA_PROJECT=/home/jovyan/.julia_env
#ENV JULIA=/usr/local/julia/bin/julia
ENV PYTHON=/usr/local/bin/python3
RUN rm -rf /opt/julia_depot/environments/pyjuliapkg

ENV GDK_BACKEND=dummy

# ===================================================================
USER root
RUN echo 'export PATH=$JULIA_BINDIR:$PATH' > /etc/profile.d/julia.sh
RUN ln -s /usr/local/julia/bin/julia /usr/local/bin/julia

# ===================================================================
USER jovyan
WORKDIR /home/jovyan

# =================================================
# Clone repositories
# =================================================
RUN git clone https://gitlab.com/ea42gh/elementary-linear-algebra.git && \
    git clone https://github.com/ea42gh/itikz.git

WORKDIR /home/jovyan/elementary-linear-algebra

# =================================================
# Python: upgrade tooling
# =================================================
RUN /usr/local/bin/python3 -m pip install --no-cache-dir --upgrade \
    pip setuptools wheel

# =================================================
# Python: install ALL previously-available libraries
# =================================================

COPY binder/install_python_libraries.py /tmp/install_python_libraries.py
RUN /usr/local/bin/python3 /tmp/install_python_libraries.py

# =================================================
# Python: install local itikz (editable)
# =================================================
RUN /usr/local/bin/python3 -m pip install --no-cache-dir -e /home/jovyan/itikz

# =================================================
# Julia: GLOBAL teaching toolbox (restored in full)
# =================================================
RUN rm -rf /home/jovyan/.julia

# =================================================
# julia Packages not used by GenLinAlgProblems
# =================================================
ENV PATH=/home/jovyan/.local/bin:$JULIA_BINDIR:$PATH

COPY binder/install_julia_packages.jl /tmp/install_julia_packages.jl
ENV JULIA_PKG_PRECOMPILE_AUTO=0
RUN julia --startup-file=no /tmp/install_julia_packages.jl

RUN julia -e 'using PythonCall; pyimport("sympy"); println("PythonCall OK")'

# =================================================
# Python → Julia bridge (python-julia)
# =================================================
RUN julia --startup-file=no -e \
  'using IJulia; IJulia.installkernel("Julia", "--project=/home/jovyan/.julia_env")'

# =================================================
# Julia: GenLinAlgProblems project
# =================================================

#RUN julia --startup-file=no -e '\
#    using Pkg; \
#    Pkg.activate("/home/jovyan/.julia_env"); \
#    Pkg.develop(path="/home/jovyan/elementary-linear-algebra/GenLinAlgProblems"); \
#    Pkg.instantiate(); \
#    Pkg.precompile(strict=false); \
#'
RUN julia --startup-file=no --project=/home/jovyan/.julia_env -e '\
    using Pkg; \
    Pkg.develop(path="/home/jovyan/elementary-linear-algebra/GenLinAlgProblems"); \
    using GenLinAlgProblems; \
'

# =================================================
# Install JuliaMagic startup hook
# =================================================
RUN mkdir -p /home/jovyan/.ipython/profile_default/startup

COPY binder/10-julia-magic.py \
    /home/jovyan/.ipython/profile_default/startup/10-julia-magic.py

# =================================================
# Silence inkscape
# =================================================
COPY binder/inkscape /home/jovyan/.local/bin/inkscape
RUN chmod ugo+x /home/jovyan/.local/bin/inkscape

# =================================================
# Final tweaks
# =================================================
RUN ln -s /tmp /home/jovyan/tmp && \
    mkdir /home/jovyan/work

# =================================================
# JupyterLab startup
# =================================================
WORKDIR /home/jovyan/elementary-linear-algebra

EXPOSE 8888

CMD ["python3", "-m", "jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.default_url=/lab/tree/notebooks/notebooks/Index.ipynb"]

