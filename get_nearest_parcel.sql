CREATE TABLE deed_restricted
(ID int, cluster_id int, index int, latitude double precision,
longitude double precision, units numeric);

\COPY deed_restricted FROM './deed_restricted_units_by_location.csv' DELIMITER ',' CSV HEADER;

ALTER TABLE deed_restricted ADD COLUMN geom geometry(POINT,4326);

UPDATE deed_restricted SET geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

ALTER TABLE deed_restricted
    ALTER COLUMN geom TYPE geometry(Point,26910) USING ST_Transform(geom,26910);

CREATE INDEX idx_deed_restricted_geom ON deed_restricted USING GIST(geom);

drop table if exists deed_restricted_nearest;
create table deed_restricted_nearest as
select d.index, p.parcel_id, p.geom_id, d.units, ST_Distance(p.geom, d.geom) as dist
from deed_restricted d, (select * from parcel where acres<10) as p
where ST_DWithin(p.geom, d.geom, 200);

drop table if exists deed_restricted_developments_by_parcel;
create table deed_restricted_developments_by_parcel as
select parcel_id, k.index, units, dist from
deed_restricted_nearest k,
(select index, min(dist) as mindist from 
deed_restricted_nearest
group by index) q
where q.index=k.index
and q.mindist=dist;

\COPY deed_restricted_developments_by_parcel TO './deed_restricted_developments_by_parcel.csv' DELIMITER ',' CSV HEADER;
