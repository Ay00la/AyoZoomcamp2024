--Question 1. Knowing docker tags
docker rm <container_name>



--Question 2. Understanding docker first run
docker run -it --entrypoint /bin/bash python:3.9
pip list


-- Question 3. Count records
select count(*)
from yellow_taxi_trips 
where lpep_pickup_datetime like '2019-09-18'


--Question 4. Largest trip for each day
select sum(trip_distance), cast(lpep_pickup_datetime as date)  
from yellow_taxi_trips
group by cast(lpep_pickup_datetime as date)
order by sum(trip_distance) desc


--Question 5. Three biggest pick up Boroughs
select sum(a.total_amount), cast(a.lpep_pickup_datetime as date)  aa
, b."Borough"
from yellow_taxi_trips a
join yellow_taxi_zones b
on a."PULocationID" = b."LocationID"
where a.lpep_pickup_datetime like '2019-09-18%'
group by cast(a.lpep_pickup_datetime as date), b."Borough"
having sum(a.total_amount) > 50000


--Question 6. Largest tip
select sum(a.tip_amount), c."Zone"
from yellow_taxi_trips a
join yellow_taxi_zones b
on a."PULocationID" = b."LocationID"
join yellow_taxi_zones c
on a."DOLocationID" = c."LocationID"
where a.lpep_pickup_datetime like '2019-09%'
and b."Zone" = 'Astoria'
group by c."Zone"
order by sum(a.tip_amount) desc


--Question 7. Creating Resources
terraform apply
