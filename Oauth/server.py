from flask import Flask, request, jsonify

app = Flask(__name__)

# Mockowane dane logowania
users = {
    "testuser": "password123",
    "admin": "adminpass"
}

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if username in users and users[username] == password:
        return jsonify({"status": "success", "message": "Zalogowano pomyślnie"}), 200
    else:
        return jsonify({"status": "error", "message": "Nieprawidłowy login lub hasło"}), 401

if __name__ == '__main__':
    app.run(debug=True)
