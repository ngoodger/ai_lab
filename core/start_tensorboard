#!/bin/bash
TENSORBOARD_PORT=8890
DOCKER_NOTEBOOK_PORT=6006
LOCAL_NOTEBOOK_PORT=8890
LOGS_DIRECTORY=/logs

NOTEBOOK_IP=${NOTEBOOK_IP:-0.0.0.0}

HOST_FQN=$(python3 -c 'import socket; print(socket.getfqdn())')
SSH_FORWARDING_COMMAND="ssh -N -L localhost:${LOCAL_NOTEBOOK_PORT}:127.0.0.1:${TENSORBOARD_PORT} ${HOST_FQN}"

echo "Notebook server will run on the 127.0.0.1 interface of the host ${HOST_FQN}, on port ${TENSORBOARD_PORT}"
printf "\n\n"
echo "INFO: If the user wants to setup local port forwarding on her local machine, they should run something like the following:"
echo "INFO: Run on your local machine ----> ${SSH_FORWARDING_COMMAND}"
printf "\n\n"

docker run -it -p $TENSORBOARD_PORT:${DOCKER_NOTEBOOK_PORT} \
-v $(pwd)/workspace/logs:${LOGS_DIRECTORY} \
--user=`id -u`:`id -g` --env USER=$USER \
-v /etc/passwd:/etc/passwd \
-v /etc/group:/etc/group --rm gcr.io/serious-timer-256620/ai_lab:latest /bin/bash -c \
"tensorboard --logdir=/logs"
