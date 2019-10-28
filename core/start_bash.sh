#!/bin/bash
NOTEBOOK_DIRECTORY=/notebooks
LOGS_DIRECTORY=/logs

docker run -it \
-v $(pwd)/notebooks:${NOTEBOOK_DIRECTORY} -v $(pwd)/logs:${LOGS_DIRECTORY} \
--user=`id -u`:`id -g` --env USER=$USER \
-v /etc/passwd:/etc/passwd \
-v /etc/group:/etc/group --rm gcr.io/serious-timer-256620/ai_lab:latest /bin/bash
