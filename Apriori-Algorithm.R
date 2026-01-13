# Invoke libraries ----
library(RKaggle)
library(dplyr)
library(lubridate)
library(ggplot2)
library(arules)
library(arulesViz)

# Import dataset ----
supermarket_sales <- get_dataset("faresashraf1001/supermarket-sales")
names(supermarket_sales) <- tolower(gsub("\\.| ", "_", names(supermarket_sales)))

if (!dir.exists("images")) {
  dir.create("images")
}
supermarket_sales <- supermarket_sales |> 
  mutate(across(c(branch, city, customer_type, gender, product_line, payment), as.factor),
         date = mdy(date),
         hour = as.factor(hour(hms(as.character(time)))),
         weekday = wday(date, label = TRUE)) |> 
  select(-gross_margin_percentage)

# Explore dataset ----
str(supermarket_sales)
summary(supermarket_sales)

hour_plot <- ggplot(supermarket_sales, aes(x = hour, y = gross_income)) +
  geom_boxplot(outlier.colour = "darkred", outlier.shape = 16, fill = "steelblue") +
  labs(title = "Gross Income Distribution by Hour",
       x = "Hour", y = "Gross Income (USD)")

ggsave("images/gross_income_by_hour.png", plot = hour_plot, width = 10, height = 6)

anova_hour <- aov(gross_income ~ hour, data = supermarket_sales)
summary(anova_hour)
# With a p-value of 0.378, we fail to reject the null hypothesis.

# Modeling ----
enriched_data <- supermarket_sales |> 
  select(branch, customer_type, gender, product_line, payment)

transactions <- as(enriched_data, "transactions")
summary(transactions)

rules <- apriori(transactions, 
                 parameter = list(supp = 0.05, conf = 0.4, minlen = 2))
sorted_rules <- sort(rules, by = "lift", decreasing = TRUE)
final_rules <- sorted_rules[!is.redundant(sorted_rules)]
summary(final_rules)
# A lift of 1.1 means the association is 10% stronger than random chance
interesting_rules <- subset(final_rules, lift > 1.2)

marketing_rules <- subset(interesting_rules, lift < 2.5)
inspect(head(marketing_rules, 15))
plot(marketing_rules, method = "graph", engine = "htmlwidget")