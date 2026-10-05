INSTALL spatial;
LOAD spatial;

WITH cities(name, longitude, latitude) AS (
    VALUES
        ('Moscow', 37.6176, 55.7558),
        ('Kazan', 49.1064, 55.7961)
)
SELECT
    name,
    ST_Point(longitude, latitude) AS geometry,
    ST_AsText(ST_Point(longitude, latitude)) AS geometry_wkt
FROM cities;
