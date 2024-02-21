CREATE OR REPLACE EXTERNAL TABLE `ny_taxi.green_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://mage-zoomcamp-ayo-3/green_tripdata_2022/green_tripdata_2022-*.parquet']
);

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE ny_taxi.green_tripdata_non_partitoned AS
SELECT * FROM `ny_taxi.green_tripdata`;

-- Create a partitioned and clustered table from external table
CREATE OR REPLACE TABLE ny_taxi.green_tripdata_partitoned_clustered 
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID
AS
SELECT * FROM `ny_taxi.green_tripdata`;

/* What is count of records for the 2022 Green Taxi Data??
*/
select count(*) from `ny_taxi.green_tripdata`



/*Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?
*/
SELECT count (distinct PULocationID) as pu_count FROM `ny_taxi.green_tripdata`;

SELECT count (distinct PULocationID) as pu_count FROM `ny_taxi.green_tripdata_non_partitoned`;

--How many records have a fare_amount of 0?
SELECT count(*) as row_count FROM `ny_taxi.green_tripdata_non_partitoned`
where fare_amount = 0;

/*
What is the best strategy to make an optimized table in Big Query if your query will always order the results by PUlocationID and filter based on lpep_pickup_datetime? (Create a new table with this strategy)
*/
--Partition by lpep_pickup_datetime Cluster on PUlocationID


/* Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
*/
SELECT count (distinct PULocationID) as pu_count 
FROM `ny_taxi.green_tripdata_non_partitoned`
WHERE lpep_pickup_datetime 
between '2022-06-01' AND '2022-06-30'
;


SELECT count (distinct PULocationID) as pu_count 
FROM `ny_taxi.green_tripdata_partitoned_clustered`
WHERE lpep_pickup_datetime 
between '2022-06-01' AND '2022-06-30'
;

--Where is the data stored in the External Table you created?

--GCP Bucket

--It is best practice in Big Query to always cluster your data
--False