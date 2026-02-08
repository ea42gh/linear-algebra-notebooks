c = get_config()

# mathjax_config is deprecated on ServerApp; remove to avoid warnings.

c.ServerProxy.servers = {
    "pluto": {
        "command": ["/usr/local/bin/start-pluto"],
        "environment": {"PLUTO_PORT": "{port}"},
        "timeout": 60,
        "launcher_entry": {
            "title": "Pluto"
        },
    }
}

# Use bash login shell for Jupyter terminals (honors .bashrc and .inputrc)
c.ServerApp.terminado_settings = {
    "shell_command": ["/bin/bash", "-l"]
}
