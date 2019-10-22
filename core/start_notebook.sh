#!/bin/bash
NOTEBOOK_PORT=8870
DOCKER_NOTEBOOK_PORT=8888
LOCAL_NOTEBOOK_PORT=8870 
NOTEBOOK_DIRECTORY=/notebooks
LOGS_DIRECTORY=/logs

NOTEBOOK_IP=${NOTEBOOK_IP:-0.0.0.0}

HOST_FQN=$(python3 -c 'import socket; print(socket.getfqdn())')
SSH_FORWARDING_COMMAND="ssh -N -L localhost:${LOCAL_NOTEBOOK_PORT}:127.0.0.1:${NOTEBOOK_PORT} ${HOST_FQN}"

echo "Notebook server will run on the 127.0.0.1 interface of the host ${HOST_FQN}, on port ${NOTEBOOK_PORT}"
printf "\n\n"
echo "INFO: If the user wants to setup local port forwarding on her local machine, they should run something like the following:"
echo "INFO: Run on your local machine ----> ${SSH_FORWARDING_COMMAND}"
printf "\n\n"

docker run -p $NOTEBOOK_PORT:${DOCKER_NOTEBOOK_PORT} \
-v $(PWD)/notebooks:${NOTEBOOK_DIRECTORY} -v $(PWD)/logs:${LOGS_DIRECTORY} \
--user=`id -u`:`id -g` --env USER=$USER \
-v /etc/passwd:/etc/passwd \
-v /etc/group:/etc/group --rm ai_lab:latest /bin/bash -c \
"jupyter-lab \
--FileContentsManager.root_dir=${NOTEBOOK_DIRECTORY} \
--NotebookApp.open_browser=False \
--NotebookApp.ip=${NOTEBOOK_IP} \
--NotebookApp.port=${DOCKER_NOTEBOOK_PORT} \
--NotebookApp.token='' \
--NotebookApp.password=''"
