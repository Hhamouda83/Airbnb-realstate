-- step 2 create tables
-- hosts table
CREATE TABLE hosts (
    host_id INT PRIMARY KEY,
    host_name VARCHAR(255),
    calculated_host_listings_count INT
);

-- listings table
CREATE TABLE listings (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    host_id INT,
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    room_type VARCHAR(255),
    price INT,
    minimum_nights INT,
    FOREIGN KEY (host_id) REFERENCES hosts(host_id)
);

-- reviews table
CREATE TABLE reviews (
    listing_id INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month DECIMAL(3, 2),
    PRIMARY KEY (listing_id),
    FOREIGN KEY (listing_id) REFERENCES listings(id)
);

-- availability table(free days in the year)
CREATE TABLE availability (
    listing_id INT,
    availability_365 INT,
    PRIMARY KEY (listing_id),
    FOREIGN KEY (listing_id) REFERENCES listings(id)
);

-- step 2 insert data in tables

INSERT INTO hosts (host_id, host_name, calculated_host_listings_count)
SELECT DISTINCT host_id, host_name, calculated_host_listings_count
FROM cleaned_nyc_airbnb;

INSERT INTO listings (id, name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type, price, minimum_nights)
SELECT id, name, host_id, neighbourhood_group, neighbourhood, latitude, longitude, room_type, price, minimum_nights
FROM cleaned_nyc_airbnb;


INSERT INTO availability (listing_id, availability_365)
SELECT id, availability_365
FROM cleaned_nyc_airbnb;


UPDATE cleaned_nyc_airbnb 
SET last_review = @latest_date
WHERE last_review IS NULL OR last_review = '';

INSERT INTO reviews (listing_id, number_of_reviews, last_review, reviews_per_month)
SELECT id, number_of_reviews, last_review, reviews_per_month
FROM cleaned_nyc_airbnb;


   
   





