c = get_config()

c.ServerApp.mathjax_config = {
    "tex": {
        "packages": {"[+]": ["ams", "textmacros"]}
    }
}

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
