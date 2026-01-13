# Supermarket Product Clustering
Market Basket Analysis using the Apriori algorithm to identify product associations and optimize supermarket shelf placement and cross-selling strategies.

## 1 Business Understanding
### Business Objective
Determine products that are frequently purchased together.\
Provide actionable recommendations for shelf placement.
### Success Criteria
Identification of at least 10 high-confidence association rules.\
Actionable recommendations for at least 3 product categories.\
Creation of a visualization map (Network Graph) showing product relationships.

## 2 Data Understanding
**Source:** [Supermarket Sales Dataset](https://www.kaggle.com/datasets/faresashraf1001/supermarket-sales/data)\
**Dataset Size:** 1,000 transactions / 17 features.

### Describe the data
1. The gross margin for all products is 4.762. This indicates that the supermarket is operating with a healthy profit margin.

## 3 Data Preparation
1. Converted all column headers to snake_case for consistency.
2. Converted the string-based date column into a standardized ISO-8601 date format.
3. Extracted hour and weekday from the transaction timestamps. This allows the business to see if product associations change depending on the time of day
