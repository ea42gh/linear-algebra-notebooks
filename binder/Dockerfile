FROM ea42gh/base_image

# =================================================
# 1) Multi-arch build
# 2) One python 3.12 and on Julia 1.12  that are known to work together
# 3) headless precompile strategy for julia packages

# =================================================
# System dependencies (Python + Julia ecosystem)
# =================================================
USER root

# ---- build deps for Python ----
RUN apt-get update && apt-get install -y \
    tk-dev \
 && rm -rf /var/lib/apt/lists/*

# =================================================
USER jovyan

# =================================================
# Environment: force PythonCall to system Python
# =================================================
ENV HOME=/home/jovyan
ENV JULIA_DEPOT_PATH=/home/jovyan/.julia

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
ENV PATH=/usr/jovyan/.local/bin:$PATH

COPY binder/install_julia_packages.jl /tmp/install_julia_packages.jl
ENV JULIA_PKG_PRECOMPILE_AUTO=0
RUN julia --startup-file=no /tmp/install_julia_packages.jl

# =================================================
# Python → Julia bridge (python-julia)
# =================================================
ENV JULIA=/usr/local/bin/julia

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

