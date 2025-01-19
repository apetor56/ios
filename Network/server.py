from flask import Flask, jsonify
from random import randint

app = Flask(__name__)

# Sample data for products and categories
sample_categories = [
    {"id": 1, "name": "Elektronika"},
    {"id": 2, "name": "Książki"},
    {"id": 3, "name": "Inne"}
]

sample_products = [
    {"id": 1, "name": "Smartfon", "desc": "Nowoczesny smartfon z dużym ekranem", "price": 2999.99, "count": 10, "category_id": 1},
    {"id": 2, "name": "Laptop", "desc": "Laptop do pracy", "price": 4999.99, "count": 5, "category_id": 1},
    {"id": 3, "name": "Powieść kryminalna", "desc": "Wciągająca książka", "price": 39.99, "count": 50, "category_id": 2},
]

# Route to get categories
@app.route('/api/categories', methods=['GET'])
def get_categories():
    return jsonify(sample_categories)

# Route to get products
@app.route('/api/products', methods=['GET'])
def get_products():
    return jsonify(sample_products)

# Run the Flask server
if __name__ == '__main__':
    app.run(debug=True)
