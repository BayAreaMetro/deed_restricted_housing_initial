create table deed_restricted_nearest as
select d.index, p.parcel_id, p.geom_id, d.units, ST_Distance(p.geom, d.geom) as dist
from deed_restricted_06_14_2016 d, parcel as p 
where ST_DWithin(p.geom, d.geom, 200);

create table deed_restricted_developments_by_parcel as
select parcel_id, k.index, units, dist from
deed_restricted_nearest k,
(select index, min(dist) as mindist from 
deed_restricted_nearest
group by index) q
where q.index=k.index
and q.mindist=dist;