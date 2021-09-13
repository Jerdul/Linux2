import mysql.connector

# This file will be used only ONCE! and commented out or deleted after run first time

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="password",
)

my_cursor = mydb.cursor()

#my_cursor.execute("CREATE DATABASE our_users")

# To Inform if Database is actually created!
my_cursor.execute("SHOW DATABASES")
for db in my_cursor:
    print(db)


