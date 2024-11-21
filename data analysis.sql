-- price average by area 
SELECT neighbourhood_group, AVG(price) AS avg_price
FROM listings
GROUP BY neighbourhood_group;

-- average price per room type and neighborhood
SELECT room_type, neighbourhood_group, AVG(price) AS average_price
FROM listings
GROUP BY room_type, neighbourhood_group
ORDER BY neighbourhood_group,room_type;

SELECT host_name, AVG(calculated_host_listings_count) AS host_hours
FROM hosts
GROUP BY host_name;

SELECT host_name, AVG(calculated_host_listings_count) AS host_hours
FROM hosts
GROUP BY host_name;

SELECT 
    room_type,
    neighbourhood_group,
    AVG(availability_365) AS avg_availability,
    AVG(price) AS avg_price,
    AVG(reviews_per_month) AS avg_reviews_per_month
FROM 
    cleaned_nyc_airbnb
GROUP BY 
    room_type, 
    neighbourhood_group;
-- Average Price per Room Type and Neighbourhood
SELECT 
    room_type,
    neighbourhood_group,
    AVG(price) AS avg_price
FROM 
    cleaned_nyc_airbnb
GROUP BY 
    room_type, 
    neighbourhood_group;
-- Average Reviews Per Month by Room Type and Neighbourhood Group
SELECT 
    room_type,
    neighbourhood_group,
    AVG(reviews_per_month) AS avg_reviews_per_month
FROM 
    cleaned_nyc_airbnb
GROUP BY 
    room_type, 
    neighbourhood_group;

