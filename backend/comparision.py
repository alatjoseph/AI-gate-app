import os
import sqlite3

import face_recognition
from flask import Flask, jsonify, request
from werkzeug.utils import secure_filename

app = Flask(__name__)

# Database setup
DATABASE = 'drivers.db'
UPLOAD_FOLDER = 'driver_photos'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

def init_db():
    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()
    c.execute("""
        CREATE TABLE IF NOT EXISTS drivers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            photo_path TEXT
        )
    """)
    conn.commit()
    conn.close()

init_db()

# Route: Register Driver
@app.route('/register-driver', methods=['POST'])
def register_driver():
    name = request.form.get('name')
    photo = request.files.get('photo')
    if not name or not photo:
        return jsonify({'error': 'Name and photo are required!'}), 400

    filename = secure_filename(photo.filename)
    filepath = os.path.join(UPLOAD_FOLDER, filename)
    photo.save(filepath)

    # Save to database
    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()
    c.execute("INSERT INTO drivers (name, photo_path) VALUES (?, ?)", (name, filepath))
    conn.commit()
    conn.close()

    return jsonify({'message': 'Driver registered successfully!'}), 200

# Route: Identify Driver
@app.route('/identify-driver', methods=['POST'])
def identify_driver():
    photo = request.files.get('photo')
    if not photo:
        return jsonify({'error': 'Photo is required!'}), 400

    filename = secure_filename(photo.filename)
    temp_filepath = os.path.join(UPLOAD_FOLDER, 'temp_' + filename)
    photo.save(temp_filepath)

    # Load known faces
    conn = sqlite3.connect(DATABASE)
    c = conn.cursor()
    c.execute("SELECT name, photo_path FROM drivers")
    known_faces = c.fetchall()
    conn.close()

    known_encodings = []
    known_names = []
    for name, path in known_faces:
        image = face_recognition.load_image_file(path)
        encoding = face_recognition.face_encodings(image)[0]
        known_encodings.append(encoding)
        known_names.append(name)

    # Compare with captured face
    captured_image = face_recognition.load_image_file(temp_filepath)
    captured_encoding = face_recognition.face_encodings(captured_image)[0]

    matches = face_recognition.compare_faces(known_encodings, captured_encoding)
    if True in matches:
        match_index = matches.index(True)
        return jsonify({'message': 'Access granted!', 'driver': known_names[match_index]}), 200
    else:
        return jsonify({'message': 'Access denied!'}), 403

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
