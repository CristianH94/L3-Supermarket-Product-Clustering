# Invoke libraries ----
library(RKaggle)
library(dplyr)
library(lubridate)
library(ggplot2)

# Import dataset ----
supermarket_sales <- get_dataset("faresashraf1001/supermarket-sales")
names(supermarket_sales) <- tolower(gsub("\\.| ", "_", names(supermarket_sales)))

if (!dir.exists("images")) {
  dir.create("images")
}
supermarket_sales <- supermarket_sales |> 
  mutate(across(c(branch, city, customer_type, gender, product_line, payment), as.factor),
         date = mdy(date),
         hour = hour(hms(as.character(time))),
         weekday = wday(date, label = TRUE)) |> 
  select(-gross_margin_percentage)#, -cogs, -gross_income)
str(supermarket_sales)
summary(supermarket_sales)

hour_plot <- ggplot(supermarket_sales, aes(x = as.factor(hour), y = gross_income)) +
  geom_boxplot(outlier.colour = "darkred", outlier.shape = 16, fill = "steelblue") +
  labs(title = "Gross Income Distribution by Hour",
       x = "Hour", y = "Gross Income (USD)")

ggsave("images/gross_income_by_hour.png", plot = hour_plot, width = 10, height = 6)

