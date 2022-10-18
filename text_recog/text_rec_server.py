import flask, os
from flask_cors import CORS
from text_rec import predict_text


app = flask.Flask(__name__)
CORS(app)
app.config["DEBUG"] = True

@app.route('/', methods=['GET'])
def home():
    return "<h1>ASE Pi007</h1><p>This site is a prototype API for text recognition for ASE Pi007.</p>"

# Text recognition API: Receive an HTTP request with an image from the Android device,
# run the Tesseract model to detect the text in the image, return the result back to the Android device via a HTTP response
@app.route('/textrec', methods=['POST'])
def text_rec():
    # Save the uploaded image to the FromAndroid folder
    image = flask.request.files['image']
    image_name = image.filename
    image.save(os.path.join('FromAndroid', image_name))

    # Text Rec
    result = predict_text(image_name)
    return flask.jsonify(result)

if __name__ == '__main__':
    app.run()