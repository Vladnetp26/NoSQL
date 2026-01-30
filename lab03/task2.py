# Задание 2: Установить драйвер Mongo и подключиться к базе данных.
# Заполнить коллекцию через него и проиндексируйте одно из полей.

from pymongo import MongoClient
import random

client = MongoClient('example')
db = client.test_database
collection = db.python_collection

collection.drop()

docs = []
for i in range(100):
    docs.append({
        "name": f"User_{i}",
        "age": random.randint(18, 90),
        "active": random.choice([True, False])
    })

collection.insert_many(docs)
print(f"Inserted {collection.count_documents({})} documents.")

print("Creating index on 'age'...")
collection.create_index("age")

print("Querying users > 50 years old...")
count = collection.count_documents({"age": {"$gt": 50}})
print(f"Found {count} users.")
