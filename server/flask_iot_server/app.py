from flask import Flask, request, jsonify, render_template
from matplotlib import pyplot as plt
from werkzeug.utils import secure_filename
from datetime import datetime
import os

from sklearn.preprocessing import LabelBinarizer
import tensorflow as tf
import cv2
import numpy as np

model = tf.keras.models.load_model("model/model_v1")
chars = ['N', '7', 'R', '2', 'B', 'I', 'F', 'H', '5', 'E', 'U', 'M', '8', 'X', '0', 
         'K', 'Q', 'Y', 'S', 'G', 'A', 'T', 'V', 'Z', '3', '1', 'C', '4', 'P', '9', 
         'L', '6', 'W', 'D', 'J']
LB = LabelBinarizer()
LB.fit_transform(chars)

app = Flask(__name__)

def sort_contours(cnts, method="left-to-right"):
    reverse = False
    i = 0
    if method == "right-to-left" or method == "bottom-to-top":
        reverse = True
    if method == "top-to-bottom" or method == "bottom-to-top":
        i = 1
    boundingBoxes = [cv2.boundingRect(c) for c in cnts]
    (cnts, boundingBoxes) = zip(*sorted(zip(cnts, boundingBoxes),
    key=lambda b:b[1][i], reverse=reverse))
    # return the list of sorted contours and bounding boxes
    return (cnts, boundingBoxes)

def get_letters(img):
    letters = []
    image = cv2.imread(img)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    ret,thresh1 = cv2.threshold(gray ,127,255,cv2.THRESH_BINARY_INV)
    dilated = cv2.dilate(thresh1, None, iterations=2)

    cnts = cv2.findContours(dilated.copy(), cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
    if len(cnts) == 2:
        cnts = cnts[0]
    elif len(cnts) == 3:
        cnts = cnts[1]
    cnts = sort_contours(cnts, method="left-to-right")[0]
    # loop over the contours
    for c in cnts:
        if cv2.contourArea(c) > 10:
            (x, y, w, h) = cv2.boundingRect(c)
            cv2.rectangle(image, (x, y), (x + w, y + h), (0, 255, 0), 2)
        roi = gray[y:y + h, x:x + w]
        thresh = cv2.threshold(roi, 0, 255,cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
        thresh = cv2.resize(thresh, (32, 32), interpolation = cv2.INTER_CUBIC)
        thresh = thresh.astype("float32") / 255.0
        thresh = np.expand_dims(thresh, axis=-1)
        thresh = thresh.reshape(1,32,32,1)
        ypred = model.predict(thresh)
        ypred = LB.inverse_transform(ypred)
        [x] = ypred
        letters.append(x)
    
    word = "".join(letters)
    return word

def get_word():
    return "Asume Result Here."

def prediction(path):
    result = get_letters(path)
    return result

def uploadHandler(imagefile):
        
    filename = secure_filename(imagefile.filename)
    path = './uploadimages/'+filename
    imagefile.save(os.path.join(path))
    results = prediction(path)
    plt.imsave(os.path.join('./resultimages/'+filename), img_result)
    return results

@app.route('/', methods =["GET"])
def homepage():
	return render_template("index.html")

@app.route('/', methods =["POST"])
def homepageUpload():
	imagefile = request.files['image']
	results = uploadHandler(imagefile)
	return render_template("index.html", prediction = results)

@app.route('/upload', methods = ["POST"])
def upload():
	imagefile = request.files['image']
	results = uploadHandler(imagefile)
	print("Received image and sending back predicted results.")
	return jsonify({
        "result": results
	})

if (__name__ == "__main__"):
	app.run(debug = True, host = '0.0.0.0')