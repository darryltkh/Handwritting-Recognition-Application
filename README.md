# Handwritting Recognition Application
This project is done for the Singapore NTU SCSE module CE4171 Internet of Things - Communication and Networking. 

Aim of the project: Explore offloading AI inference from IoT device to cloud. Develop an Android application that sends user input to the cloud and cloud will do model inferrence and send back the result.

How this project was conducted:
- Data used in model training is taken from the [EMNIST dataset](https://www.nist.gov/itl/products-and-services/emnist-dataset), only did training on the letters.
- A model was created from scratch and model hyperparameters were fine-tuned to produce the best result.
- The cloud computing platform used is the Google Cloud platform, with a virtual machine setup for this project.
- The best model parameters from training are taken and the model is downloaded and uploaded onto Google Cloud. A Flask application is also created on the same Google Cloud instance.
- An Android application is created using Flutter. The user can take a picture using camera on his/her smartphone and sends this picture to the Flask application in the cloud instance.
- The deep learning model will process the image and send back the result from the cloud to the smartphone through Flask.
- The result is shown on the Flutter application.

Details of the deep learning model used:
- 2 convolution layers with maxpooling and dropout
- 3 Fully Connected layers, each with its own dropout layer

You can watch a demonstration of the application [here](https://youtu.be/8vMar64Fdt4).

## Result
Achieved 96.5% accurracy in training and 93.6% accuracy in testing.

## Conclusion
I have learnt on how to work on Google Cloud and establish communication between smartphones and the Google Cloud instance through Flask.
