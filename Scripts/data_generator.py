import csv
import random
from datetime import datetime, timedelta

# Set random seed for reproducibility
random.seed(42)

# Generate Dates
start_date = datetime(2023, 1, 1)
end_date = datetime(2024, 12, 31)
date_range = [start_date + timedelta(days=x) for x in range((end_date - start_date).days + 1)]

# Sample data categories
products = ['Laptop', 'Smartphone', 'Tablet', 'Monitor', 'Keyboard', 'Mouse', 'Headphones']
categories = ['Electronics', 'Accessories']
regions = ['North', 'South', 'East', 'West']
segments = ['Consumer', 'Corporate', 'Home Office']

# Generate dummy data
num_records = 5000

with open('sales_data.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['OrderID', 'OrderDate', 'ProductID', 'ProductName', 'Category', 'Region', 'Segment', 'Quantity', 'UnitPrice', 'Discount', 'SalesAmount', 'Cost', 'Profit'])
    
    for i in range(1, num_records + 1):
        order_id = f'ORD-{i:05d}'
        order_date = random.choice(date_range).strftime('%Y-%m-%d')
        product_id = f'PRD-{random.randint(100, 106)}'
        product_name = random.choice(products)
        category = random.choice(categories)
        region = random.choice(regions)
        segment = random.choice(segments)
        quantity = random.randint(1, 10)
        unit_price = round(random.uniform(10.0, 1500.0), 2)
        discount = round(random.uniform(0.0, 0.3), 2)
        
        sales_amount = round(quantity * unit_price * (1 - discount), 2)
        cost = round(quantity * unit_price * 0.6, 2)
        profit = round(sales_amount - cost, 2)
        
        writer.writerow([order_id, order_date, product_id, product_name, category, region, segment, quantity, unit_price, discount, sales_amount, cost, profit])

print("Data generated successfully: sales_data.csv")
