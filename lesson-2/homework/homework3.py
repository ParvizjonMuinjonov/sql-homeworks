import pyodbc
import os

conn_str = (
    "DRIVER={SQL Server};"
    "SERVER=DESKTOP-F6NCVFH\SQLEXPRESS;"  
    "DATABASE=class1;"
    "Trusted_Connection=yes;"   
)
conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

# Retrieve the image
cursor.execute("SELECT image_data FROM photos WHERE id = 1")
row = cursor.fetchone()
image_data = row[0]  


output_path = "D:\\SQL\\sql-homeworks\\lesson-2\\homework\\retrieved_image.jpg"
with open(output_path, "wb") as file:
    file.write(image_data)

print(f"Image saved to {output_path}")

cursor.close()
conn.close()