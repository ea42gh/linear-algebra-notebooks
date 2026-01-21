import os


os.environ.setdefault("JULIA_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("JULIACALL_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("PYJULIAPKG_PROJECT", "/home/jovyan/.julia_env")
os.environ.setdefault("JULIAPKG_PROJECT", "/home/jovyan/.julia_env")

try:
    from juliacall import Main as jl
    jl.seval('import Pkg; Pkg.activate("/home/jovyan/.julia_env")')
except Exception:
    pass
