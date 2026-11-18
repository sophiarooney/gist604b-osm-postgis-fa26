-- Query 2: Railroad Length by County
-- Purpose: Calculate the total length of railroads in each county in Oregon including rialways, light rail lines,
-- and tram lines. 

SELECT
    aa.name AS county_name,
    SUM(ST_Length(ST_Intersection(r.geom, aa.geom)::geography)) / 1000.0 AS railroad_length_km,
    aa.geom
FROM
    adminareas_a AS aa
LEFT JOIN
    railways AS r ON ST_Intersects(aa.geom, r.geom)
    AND r.fclass IN('rail','light_rail','tram')
WHERE
    aa.fclass = 'admin_level6'
GROUP BY
    aa.name, aa.geom
ORDER BY
    railroad_length_km DESC;