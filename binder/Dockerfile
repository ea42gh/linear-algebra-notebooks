FROM ea42gh/base_image

# =================================================
# 1) Multi-arch build
# 2) One python 3.12 and on Julia 1.12  that are known to work together
# 3) headless precompile strategy for julia packages

# =================================================
# System dependencies (Python + Julia ecosystem)
# =================================================
USER root
# ---- Julia isolation ----
ENV JULIA_DEPOT_PATH=/opt/julia_depot
RUN mkdir -p /opt/julia_depot \
 && chown -R jovyan:jovyan /opt/julia_depot

# ---- build deps for Python ----
RUN apt-get update && apt-get install -y \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libffi-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    wget \
    graphviz \
    graphviz-dev \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

# =================================================
# Compile the correct Python version
# =================================================

ARG PYTHON_VERSION=3.12.1

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
 && tar -xzf Python-${PYTHON_VERSION}.tgz \
 && cd Python-${PYTHON_VERSION} \
 && ./configure --enable-optimizations \
 && make -j$(nproc) \
 && make altinstall

RUN ln -sf /usr/local/bin/python3.12 /usr/local/bin/python3

RUN python3 -m ensurepip --upgrade
RUN python3 --version && python3 -m pip --version

# =================================================
# Environment: force PythonCall to system Python
# =================================================
ENV JULIA_BINDIR=/usr/local/julia/bin
ENV LD_LIBRARY_PATH=/usr/local/julia/lib
ENV PATH=/usr/local/julia/bin:$PATH

ENV JULIA_PROJECT=/home/jovyan/elementary-linear-algebra
ENV JULIA=/usr/local/julia/bin/julia
ENV PYTHON=/usr/local/bin/python3
ENV PYTHONCALL_USE_PYTHON=1
RUN rm -rf /opt/julia_depot/environments/pyjuliapkg

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
RUN python3 -m pip install --no-cache-dir --upgrade \
    pip setuptools wheel

# =================================================
# Python: install ALL previously-available libraries
# =================================================

COPY binder/install_python_libraries.py /tmp/install_python_libraries.py
RUN python3 /tmp/install_python_libraries.py

# =================================================
# Python: install local itikz (editable)
# =================================================
RUN python3 -m pip install --no-cache-dir -e /home/jovyan/itikz

# =================================================
# Julia: GLOBAL teaching toolbox (restored in full)
# =================================================
RUN rm -rf /home/jovyan/.julia

# =================================================
# julia Packages not used by GenLinAlgProblems
# =================================================
COPY binder/install_julia_packages.jl /tmp/install_julia_packages.jl
RUN julia --startup-file=no /tmp/install_julia_packages.jl

# =================================================
# Python → Julia bridge (python-julia)
# =================================================
ENV JULIA=/usr/local/bin/julia

RUN python3 - <<'EOF'
from juliacall import Main as jl
print("Julia:", jl.seval("string(VERSION)"))
print("Python seen by Julia:", jl.seval('import PythonCall; PythonCall.pyimport("sys").executable'))
EOF

# =================================================
# Julia: Pluto + IJulia (global)
# =================================================
RUN julia --startup-file=no -e '\
    using Pkg; \
    Pkg.add(["Pluto", "IJulia"]); \
    Pkg.precompile(); \
'

# =================================================
# Julia: GenLinAlgProblems project
# =================================================
RUN julia --startup-file=no -e '\
    using Pkg; \
    Pkg.activate("/home/jovyan/elementary-linear-algebra/GenLinAlgProblems"); \
    Pkg.instantiate(); \
    Pkg.precompile(); \
'

# =================================================
# Install JuliaMagic startup hook
# =================================================
RUN mkdir -p /home/jovyan/.ipython/profile_default/startup

COPY binder/10-julia-magic.py \
    /home/jovyan/.ipython/profile_default/startup/10-julia-magic.py

RUN chown -R jovyan:jovyan /home/jovyan/.ipython

# =================================================
# JupyterLab startup
# =================================================
WORKDIR /home/jovyan/elementary-linear-algebra

EXPOSE 8888

CMD ["python3", "-m", "jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root", "--NotebookApp.default_url=/lab/tree/notebooks/Index.ipynb"]

