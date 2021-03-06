from flask import Flask,jsonify,request
import time
import os
from validator import validate
import json
app = Flask(__name__)
version = 1

UPLOAD_FOLDER = '/storage'

@app.route('/')
def hello_world():
    return "Hello World"

@app.route('/validate', methods=['POST'])
def validate_excel_file():
    f = request.files['file']
    filename = request.headers.get("filename")
    path = os.path.join(UPLOAD_FOLDER,filename)

    f.save(path)
    data = validate(path,filename.split('---')[0])
    if data['succeed'] == False:
        return jsonify(data)

    d = {'value': json.loads(data['value']),
            'report': data['report'],
            'succeed': data['succeed']
            }
    os.remove(path)
    return jsonify(d)
    

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
