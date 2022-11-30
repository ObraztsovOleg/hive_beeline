DROP TABLE external_h31;


	CREATE EXTERNAL TABLE external_h31 (Day int, TickTime int, Speed double)

	ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'

	LOCATION '/data/h31/user_logs/u5'

	TBLPROPERTIES ("skip.header.line.count"="1");

        
	INSERT INTO userlog_o PARTITION(UserId='u5', HValue='h31') select * from external_h31;
	
	INSERT INTO userlog_p PARTITION(UserId='u5', HValue='h31') select * from external_h31;


	SELECT * FROM userlog_o LIMIT 10;


	DROP TABLE external_h31;