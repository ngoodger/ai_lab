#!/bin/bash
NOTEBOOK_DIRECTORY=/notebooks

docker run -it \
-v $(PWD)/notebooks:${NOTEBOOK_DIRECTORY} -v $(PWD)/logs:${LOGS_DIRECTORY} \
--user=`id -u`:`id -g` --env USER=$USER \
-v /etc/passwd:/etc/passwd \
-v /etc/group:/etc/group --rm lab:latest /bin/bash
