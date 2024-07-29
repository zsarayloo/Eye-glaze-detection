# Project Title :  Eye glaze detection
# Year : 2017
# Author : Zahra Sarayloo

## Description
This project implements an eye gaze detection system using a particle filter and a neural network. The system captures video from a webcam, detects eyes using a Haar cascade classifier, and estimates the gaze direction by tracking particles around the detected eyes.

I did this project in MATLAB language, using particle filter and neural network techniques. The MATLAB code is located in the `matlab` folder. Additionally, a Python version of the project is provided in the `python` folder.

## Features
- Real-time eye detection using Haar cascades
- Particle filter-based gaze direction estimation
- Visualization of detected eyes and gaze direction

## Requirements
- Python 3.x
- OpenCV
- NumPy
- Matplotlib (optional, for visualization)

You can install the required Python libraries using pip:

!pip install opencv-python numpy matplotlib

## How to Run
1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/eye-gaze-detection.git
   ```

2. **Navigate to the Python project directory:**

   ```bash
   cd eye-gaze-detection/python
   ```

3. **Run the Python script:**

   ```bash
   python eye_gaze_detection.py
   ```

4. **View the video feed:**
   - The video feed will open in a window displaying detected eyes and the estimated gaze direction. 
   - Press 'q' to exit the video feed window.

## Folder Structure
- `matlab/`: Contains the MATLAB code for the project.
- `python/`: Contains the Python code for the project, including `eye_gaze_detection.py`.


## Particle Filter Parameters
- `NUM_PARTICLES`: Number of particles used in the particle filter.
- `PARTICLE_NOISE`: Standard deviation of noise added to particle positions.
- `PARTICLE_WEIGHT`: Weight factor for gaze direction simulation.

## Contact
For questions or feedback, please contact [zsarayloo@gmail.com](mailto:zsarayloo@gmail.com).


You can copy and paste this Markdown content into a `README.md` file for your project. This README includes a complete overview of your project, installation instructions, how to run the code, folder structure, particle filter parameters, and contact information.

