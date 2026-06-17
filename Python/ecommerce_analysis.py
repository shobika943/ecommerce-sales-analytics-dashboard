import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# ---------------------------
# Database Connection
# ---------------------------

connection_url = URL.create(
    drivername="mysql+mysqlconnector",
    username="root",
    password="yoursqlpassword",
    host="localhost",
    port=3306,
    database="ecommerce_analytics"
)

engine = create_engine(connection_url)

# ---------------------------
# Import Tables
# ---------------------------

orders = pd.read_sql(
    "SELECT * FROM orders",
    engine
)

customers = pd.read_sql(
    "SELECT * FROM customers",
    engine
)

products = pd.read_sql(
    "SELECT * FROM products",
    engine
)

# ---------------------------
# Merge Tables
# ---------------------------

df = (
    orders
    .merge(customers, on="customer_id")
    .merge(products, on="product_id")
)

# ---------------------------
# Revenue Column
# ---------------------------

df["total_price"] = (
    df["quantity"] *
    df["price"]
)

# ---------------------------
# NumPy Analysis
# ---------------------------

total_sales = np.sum(
    df["total_price"]
)

average_sales = np.mean(
    df["total_price"]
)

highest_sale = np.max(
    df["total_price"]
)

print("\nNUMPY ANALYSIS")
print("Total Sales:", total_sales)
print("Average Sale:", average_sales)
print("Highest Sale:", highest_sale)

# ---------------------------
# Pandas Analysis
# ---------------------------

sales_by_city = (
    df.groupby("city")["total_price"]
      .sum()
)

sales_by_product = (
    df.groupby("product_name")["total_price"]
      .sum()
)

top_customer = (
    df.groupby("customer_name")["total_price"]
      .sum()
      .sort_values(ascending=False)
)

print("\nSALES BY CITY")
print(sales_by_city)

print("\nSALES BY PRODUCT")
print(sales_by_product)

print("\nTOP CUSTOMER")
print(top_customer)

# ---------------------------
# Charts
# ---------------------------

plt.figure(figsize=(8, 5))

sales_by_city.plot(kind="bar")
plt.title("Sales By City")
plt.ylabel("Revenue")
plt.tight_layout()

plt.savefig("../Charts/sales_by_city.png")
plt.show()

plt.figure(figsize=(8, 5))

sales_by_product.plot(kind="bar")
plt.title("Sales By Product")
plt.ylabel("Revenue")
plt.tight_layout()

plt.savefig("../Charts/sales_by_product.png")
plt.show()

# ---------------------------
# Export Reports
# ---------------------------

df.to_csv(
    "../Reports/final_sales_data.csv",
    index=False
)

df.to_excel(
    "../Reports/final_sales_report.xlsx",
    index=False
)

# ---------------------------
# Business Insights
# ---------------------------

print("\nBUSINESS INSIGHTS")

print(
    "Top City:",
    sales_by_city.idxmax()
)

print(
    "Top Product:",
    sales_by_product.idxmax()
)

print(
    "Top Customer:",
    top_customer.index[0]
)

print("\nReports exported successfully.")
