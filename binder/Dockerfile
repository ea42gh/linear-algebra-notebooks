# ============================================================
# Binder Teaching Image (la_image)
# Pulls infrastructure from prebuilt multi-arch base image.
# ============================================================
FROM ea42gh/base_image:latest

LABEL org.opencontainers.image.title="ea42gh/la_image"

# Julia depot in a stable location
ENV JULIA_DEPOT_PATH=/home/jovyan/.julia
ENV JULIA_PKG_PRECOMPILE_AUTO=0
ENV JULIA_NUM_THREADS=auto

# ------------------------------------------------------------
USER jovyan
WORKDIR /home/jovyan

# ------------------------------------------------------------
# Clone teaching repositories (correct URLs)
# ------------------------------------------------------------
RUN git clone https://gitlab.com/ea42gh/elementary-linear-algebra.git && \
    git clone https://github.com/ea42gh/itikz.git

#COPY --chown=jovyan:jovyan pyproject.toml .
#RUN pixi install

# ------------------------------------------------------------
#WORKDIR /home/jovyan/elementary-linear-algebra/GenLinAlgProblems
ENV PYTHON=/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/python

# Instantiate GenLinAlgProblems (per-arch safe)
RUN julia --startup-file=no -e '\
    using Pkg; \
    Pkg.activate("/home/jovyan/elementary-linear-algebra/GenLinAlgProblems"); \
    Pkg.instantiate(); \
    haskey(Pkg.project().dependencies, "PythonCall") || \
        error("PythonCall not declared in GenLinAlgProblems"); \
    using PythonCall; \
    sys = pyimport("sys"); \
    python = pyconvert(String, sys.executable); \
    isfile(python) || error("Python executable missing: $python"); \
    root = normpath("/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg"); \
    startswith(normpath(python), root) || error("Python not under .CondaPkg: $python"); \
    println("Active project: ", Base.active_project()); \
    println("Python executable: ", python); \
'
# Ensure Jupyter is actually installed in the pinned CondaPkg/Pixi Python
RUN /home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/python -c "import jupyter" \
 || /home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/pip install --no-cache-dir jupyter jupyterlab


ENV PATH=/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin:$PATH

RUN mkdir -p /home/jovyan/.julia/environments/la_core /home/jovyan/.julia/environments/la_gui
COPY binder/la_image-notebooks/la_core/Project.toml \
     /home/jovyan/.julia/environments/la_core/Project.toml

COPY binder/la_image-notebooks/la_gui/Project.toml \
     /home/jovyan/.julia/environments/la_gui/Project.toml

ENV JULIA_PROJECT=/home/jovyan/.julia/environments/la_core
RUN julia --startup-file=no -e '\
    using Pkg; \
    Pkg.activate(ENV["JULIA_PROJECT"]); \
    Pkg.develop(path="/home/jovyan/elementary-linear-algebra/GenLinAlgProblems"); \
    Pkg.instantiate(); \
    Pkg.precompile(); \
'
ENV JULIA_PROJECT=/home/jovyan/.julia/environments/la_gui
RUN julia --startup-file=no -e '\
    using Pkg; \
    Pkg.activate(ENV["JULIA_PROJECT"]); \
    Pkg.instantiate(); \
'
# ✅ Runtime default
ENV JULIA_PROJECT=/home/jovyan/.julia/environments/la_core

# ------------------------------------------------------------
# Final step: install Julia kernel (architecture-independent)
# ------------------------------------------------------------
RUN julia --startup-file=no -e '\
    using Pkg; \
    Pkg.activate("/home/jovyan/.julia/environments/la_core"); \
    using IJulia; \
    \
    ENV["JUPYTER"] = "/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/jupyter"; \
    \
    IJulia.installkernel( \
        "Julia (core)", \
        env = Dict( \
            "JULIA_PROJECT" => "/home/jovyan/.julia/environments/la_core", \
            "PYTHON" => "/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/python" \
        ) \
    ); \
    \
    IJulia.installkernel( \
        "Julia (gui)", \
        env = Dict( \
            "JULIA_PROJECT" => "/home/jovyan/.julia/environments/la_gui", \
            "PYTHON" => "/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/python" \
        ) \
    ); \
'

# Install itikz via pip into the CondaPkg Python (Python 3.12)
RUN /home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/python \
    -m pip install --no-cache-dir /home/jovyan/itikz

# Enable %%julia magic for all Python notebooks
RUN mkdir -p /home/jovyan/.ipython/profile_default/startup
#COPY binder/10-julia-magic.py /home/jovyan/.ipython/profile_default/startup/10-julia-magic.py
COPY binder/10-julia-magic.py /usr/local/etc/jupyter/jupyter_notebook_config.d/10-julia-magic.py

# ------------------------------------------------------------
# Jupyter: run from the SAME pinned Python 3.12 (CondaPkg/Pixi)
# This ensures python notebooks and Julia↔python interop are coherent.
ENV PATH=/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin:/usr/local/julia/bin:$PATH
#------------------------------------------------------------

EXPOSE 8888
CMD ["/home/jovyan/elementary-linear-algebra/GenLinAlgProblems/.CondaPkg/.pixi/envs/default/bin/python", "-m", "jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
