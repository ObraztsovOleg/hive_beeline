DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t bde2020/hadoop-base:$(current_branch) ./base
	docker build -t bde2020/hadoop-base-with-tez:$(current_branch) ./base_with_tez
	docker build -t bde2020/hadoop-namenode:$(current_branch) ./namenode
	docker build -t bde2020/hadoop-datanode:$(current_branch) ./datanode
	docker build -t bde2020/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t bde2020/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t bde2020/hadoop-historyserver:$(current_branch) ./historyserver
	docker build -t bde2020/hadoop-submit:$(current_branch) ./submit
	docker build -t bde2020/hadoop-hiveserver:$(current_branch) ./hiveserver

change:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -chmod -R 777 /
tez_hdfs:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -mkdir -p /apps/tez-0.10.2/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -copyFromLocal -f /opt/tez/share/tez.tar.gz /apps/tez-0.10.2/
hive_bash:
	docker run --rm -it --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-hiveserver:$(current_branch) bash
hive_beeline:
	export HNAME=${HNAME}
	export USER=${USER}
	/bin/bash /root/hw6/docker-hadoop/hive/generate.sh
	docker run --rm -v /root/hw6/docker-hadoop/hive:/hive --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-hiveserver:$(current_branch) bash /opt/hive/bin/beeline -u jdbc:hive2://hiveserver:10000 -f /hive/hive.sql
move:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -mkdir -p /data/${HNAME}/user_logs/${USER}
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -mv /data/${HNAME}/user_logs/userlog.${HNAME}.${USER}.csv /data/${HNAME}/user_logs/${USER}/
wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.3.3/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base-with-tez:$(current_branch) hdfs dfs -rm -r /input
