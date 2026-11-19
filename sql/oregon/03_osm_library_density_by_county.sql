-- Query 4: Library Density by County
-- Purpose: Calculate library density (libraries per sq km) in each county


WITH county_metrics AS (
    SELECT
        aa.name AS county_name,
        COUNT(l.*) AS library_count,
        ST_Area(aa.geom::geography) / 1000000 AS county_area_sq_km,
        aa.geom
    FROM
        adminareas_a AS aa
    LEFT JOIN
        pois AS l ON ST_Intersects(aa.geom, l.geom) AND l.fclass = 'library'
    WHERE
        aa.fclass = 'admin_level6'
    GROUP BY
        aa.name, aa.geom
)

SELECT
    county_name,
    library_count,
    county_area_sq_km,
    library_count / county_area_sq_km AS library_density_per_sq_km,
    geom
FROM
    county_metrics
ORDER BY
    library_density_per_sq_km DESC;