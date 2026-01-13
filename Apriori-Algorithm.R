# Invoke libraries ----
library(RKaggle)
library(dplyr)
library(lubridate)

# Import dataset ----
supermarket_sales <- get_dataset("faresashraf1001/supermarket-sales")
names(supermarket_sales) <- tolower(gsub("\\.| ", "_", names(supermarket_sales)))

str(supermarket_sales)
summary(supermarket_sales)

supermarket_sales <- supermarket_sales |> 
  mutate(across(c(branch, city, customer_type, gender, product_line, payment), as.factor),
         date = mdy(date),
         hour = hour(hms(as.character(time))),
         weekday = wday(date, label = TRUE))
