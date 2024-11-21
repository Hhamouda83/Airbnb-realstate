#install.packages("reshape2")


# Load libraries
library(ggplot2)
library(dplyr)
library(reshape2)


# Load data
df <- read.csv("C:/Users/aashrafa/Downloads/AB_NYC_2019.csv/AB_NYC_2019_1.csv")

# Exploring the data
str(df)
head(df)
summary(df)

# Data Cleaning (check for duplicates and missing values)
sum(duplicated(df))   # Check for duplicates
colSums(is.na(df))    # Check for missing values

# Drop irrelevant columns
df <- df %>% select(-name, -host_name, -last_review)

# Replace missing values in 'reviews_per_month' with 0
df$reviews_per_month[is.na(df$reviews_per_month)] <- 0

# Histograms for data distribution
hist(df$minimum_nights, main="Minimum Nights", xlab="Nights")
hist(df$availability_365, main="Availability 365", xlab="Days")
hist(df$price, main="Price", xlab="Price")

# Boxplot of multiple variables
boxplot(df$minimum_nights, df$availability_365, df$price, 
        names = c("Minimum Nights", "Availability 365", "Price"), 
        main = "Boxplot of Multiple Variables")

# Drop rows with price = 0
df <- df[df$price != 0,]

# Drop rows with minimum_nights > 365
df <- df[df$minimum_nights <= 365,]

# Drop rows with availability_365 < 1
df <- df[df$availability_365 > 0,]

# Correlation matrix
corr_vars <- df %>% select(id, price, host_id, minimum_nights, number_of_reviews, calculated_host_listings_count, availability_365, latitude, longitude, reviews_per_month)
corr_matrix <- cor(corr_vars, use="complete.obs")
corr_matrix

# Plot the correlation matrix
library(reshape2)
corr_melt <- melt(corr_matrix)
ggplot(corr_melt, aes(Var1, Var2, fill = value)) + 
  geom_tile() + 
  scale_fill_gradient2() + 
  geom_text(aes(label = round(value, 2)))

# Room Type Distribution
ggplot(df, aes(x=room_type)) + 
  geom_bar(aes(fill=room_type)) +
  ggtitle("Distribution of Room Types")

# Price Distribution by Room Type
ggplot(df, aes(x=room_type, y=price)) +
  geom_boxplot() +
  ggtitle("Price Distribution by Room Type")

# Average Price by Room Type
df %>% 
  group_by(room_type) %>%
  summarise(avg_price = mean(price)) %>%
  ggplot(aes(x=room_type, y=avg_price, fill=room_type)) +
  geom_bar(stat="identity") +
  ggtitle("Average Price by Room Type")

# Availability by Room Type
ggplot(df, aes(x=room_type, y=availability_365)) +
  geom_boxplot() +
  ggtitle("Availability by Room Type")

# Average Reviews per Month by Room Type
df %>%
  group_by(room_type) %>%
  summarise(avg_reviews = mean(reviews_per_month)) %>%
  ggplot(aes(x=room_type, y=avg_reviews)) +
  geom_bar(stat="identity") +
  ggtitle("Average Reviews per Month by Room Type")

# Number of Listings by Neighborhood Group
df %>%
  count(neighbourhood_group) %>%
  ggplot(aes(x=reorder(neighbourhood_group, n), y=n)) +
  geom_bar(stat="identity") +
  ggtitle("Number of Listings by Neighborhood Group")

# Price Distribution by Neighborhood Group
ggplot(df, aes(x=neighbourhood_group, y=price)) +
  geom_boxplot() +
  ggtitle("Price Distribution by Neighborhood Group")

# Average Reviews per Month by Neighborhood Group
df %>%
  group_by(neighbourhood_group) %>%
  summarise(avg_reviews = mean(reviews_per_month)) %>%
  ggplot(aes(x=neighbourhood_group, y=avg_reviews)) +
  geom_bar(stat="identity") +
  ggtitle("Average Reviews per Month by Neighborhood Group")

# Occupancy Rate and Estimated Revenue
df$occupancy_rate <- (365 - df$availability_365) / 365
df$estimated_revenue <- df$price * df$occupancy_rate * 365

# Average Revenue by Room Type and Neighborhood Group
df %>%
  group_by(neighbourhood_group, room_type) %>%
  summarise(avg_revenue = mean(estimated_revenue)) %>%
  ggplot(aes(x=neighbourhood_group, y=avg_revenue, fill=room_type)) +
  geom_bar(stat="identity") +
  ggtitle("Average Estimated Revenue by Room Type and Neighborhood Group")

# Average Reviews per Month by Neighborhood and Room Type
df %>%
  group_by(neighbourhood_group, room_type) %>%
  summarise(avg_reviews = mean(reviews_per_month)) %>%
  ggplot(aes(x=neighbourhood_group, y=avg_reviews, fill=room_type)) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle("Average Reviews per Month by Neighborhood and Room Type")

