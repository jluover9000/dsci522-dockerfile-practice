# use the miniforge base, make sure you specify a verion
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# copy the lockfile into the container
COPY conda-linux-64.lock conda-linux-64.lock

# setup conda-lock and install packages from lockfile
RUN conda install -n base -c conda-forge conda-lock -y
RUN conda-lock install --no-validate-platform -n dockerlock conda-linux-64.lock

# expose JupyterLab port
EXPOSE 8888

# sets the default working directory
# this is also specified in the compose file
WORKDIR /workplace

# run JupyterLab on container start
# uses the jupyterlab from the install environment
CMD ["conda", "run", "--no-capture-output", "-n", "dockerlock", "jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--IdentityProvider.token=''", "--ServerApp.password=''"]
