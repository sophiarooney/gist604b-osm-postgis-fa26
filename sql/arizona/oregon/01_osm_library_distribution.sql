-- Query 1: Library Locations
-- Purpose: Extract library locations in Oregon for spatial distribution analysis.

SELECT
    geom
FROM
    pois
WHERE
    fclass = 'library';