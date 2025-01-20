from flask import Flask, jsonify

app = Flask(__name__)

# Mockowane dane
categories = [
    {"id": 1, "name": "Elektronika"},
    {"id": 2, "name": "Książki"},
    {"id": 3, "name": "Odzież"},
]

products = [
    {"id": 1, "name": "Laptop", "category_id": 1, "price": 3000.0},
    {"id": 2, "name": "Smartfon", "category_id": 1, "price": 1500.0},
    {"id": 3, "name": "Bracia Karamazov", "category_id": 2, "price": 40.0},
    {"id": 4, "name": "Spodnie narciarskie", "category_id": 3, "price": 360.0},
    {"id": 5, "name": "Czapka", "category_id": 3, "price": 120.0},
]

@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify(categories)

@app.route('/products', methods=['GET'])
def get_products():
    return jsonify(products)

if __name__ == '__main__':
    app.run(debug=True)
