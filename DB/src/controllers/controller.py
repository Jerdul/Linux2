# from flask import request, render_template, redirect
# from flask.views import MethodView
# from src.db import mysql

# class IndexController(MethodView):

#     def get(self):
#         with mysql.cursor() as cur:
#             cur.execute("SELECT * FROM Products")
#             data = cur.fetchall()
#             cur.execute("SELECT * FROM categories")
#             categories = cur.fetchall()
#             print(data)
#             return render_template('public/index.html', data = data, categories = categories)

#     def post(self):
#         code = request.form['code']
#         name = request.form['name']
#         stock = request.form['stock']
#         value = request.form['value']
#         category = request.form['category']

#         with mysql.cursor() as cur:
#             cur.execute("INSERT INTO Products VALUES(%s, %s, %s, %s, %s)", (code, name, stock, value, category))
#             cur.connection.commit()
#             return redirect('/')

#     class DeleteProductController(MethodView):
#         def post(self, code):
#             with mysql.cursor() as cur:
#                 cur.execute("DELETE FROM Products WHERE code = %s", (code))
#                 cur.connection.commit()
#                 return redirect('/')

#     class UpdateProductController(MethodView):
#         def get(self, code):
#             with mysql.cursor() as cur:
#                 cur.execute("SELECT * FROM Products WHERE code = %s", (code, ))
#                 product = cur.fetchone()
#                 print(product)
#                 return render_template('public/product_update.html', product=product)

#         def post(self, code):
#             productCode = request.form['code']
#             name = request.form['name']
#             stock = request.form['stock']
#             value = request.form['value']
#             with mysql.cursor() as cur:
#                cur.execute("UPDATE products SET code = %s, name = %s, stock = %s, value = %s WHERE code = %s", (productCode, name, stock, value, code))
#                cur.connection.commit()
#                return f"Editing product{code} works"

# class CreateCategoriesController(MethodView):
#     def get (self):
#         return render_template("puclic/categories.html")

#     def post(self):
#         id = request.form['id']
#         name = request.form['name']
#         description = request.form['description']

#         with mysql.cursor() as cur:
#             cur.execute("INSERT INTO categories VALUES(%s, %s, %s)", (id, name, description))
#             cur.connection.commit()
#             return "Succses!"