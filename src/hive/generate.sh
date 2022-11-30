echo -en "DROP TABLE external_${HNAME};\n

	CREATE EXTERNAL TABLE external_${HNAME} (Day int, TickTime int, Speed double)\n
	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'\n
	LOCATION '/data/${HNAME}/user_logs/${USER}'\n
	TBLPROPERTIES (\"skip.header.line.count\"=\"1\");\n
        
	INSERT INTO userlog_o PARTITION(UserId='${USER}', HValue='${HNAME}') select * from external_${HNAME};\n	
	INSERT INTO userlog_p PARTITION(UserId='${USER}', HValue='${HNAME}') select * from external_${HNAME};\n

	SELECT * FROM userlog_o LIMIT 10;\n

	DROP TABLE external_${HNAME};" > /root/hw6/docker-hadoop/hive/hive.sql
