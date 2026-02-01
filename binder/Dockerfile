FROM ea42gh/la-course:0.2

USER jovyan
WORKDIR /home/jovyan

EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--ServerApp.token=", "--ServerApp.password=", "--notebook-dir=/home/jovyan"]
