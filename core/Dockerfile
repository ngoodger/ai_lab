FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04
RUN apt-get clean
RUN apt-get update
RUN apt-get -y install wget curl vim sudo libspatialindex-dev zlib1g-dev libffi-dev libsqlite3-dev libssl-dev
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get -y install nodejs

# Install python3.7
RUN wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
RUN tar -xvzf Python-3.7.4.tgz
WORKDIR "Python-3.7.4"
RUN ./configure --with-ensurepip=install && make install -j `nproc`
WORKDIR "/"

COPY ./requirements.txt /requirements.txt
# Use OAN artifactory for pip
RUN pip3 install --upgrade pip
RUN pip3 install -r /requirements.txt

# Workaround for installing line_profiler until new release after 2.1.2
RUN git clone https://github.com/rkern/line_profiler.git
RUN find line_profiler -name '*.pyx' -exec cython {} \;
WORKDIR "line_profiler"
RUN pip3 install . 
WORKDIR "/"

RUN jupyter labextension install jupyterlab_vim
RUN jupyter labextension install @jupyterlab/celltags
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
# Enable reconfiguration of jupyter-lab without sudo password.
RUN echo "%sudo ALL = NOPASSWD: /usr/local/bin/jupyter" >> /etc/sudoers

# Provide place for jupyterlab to write configuration.
RUN mkdir /.local; chmod 777 /.local
RUN mkdir /.jupyter; chmod 777 /.jupyter
