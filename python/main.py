import cv2
import numpy as np

# Particle filter parameters
NUM_PARTICLES = 100
PARTICLE_NOISE = 10
PARTICLE_WEIGHT = 0.5

# Initialize video capture from a file
video_path = '4_a.avi'  # Replace with your video file path
cap = cv2.VideoCapture(video_path)

# Load the Haar cascade for eye detection
eye_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_eye.xml')

# Function to initialize particles
def initialize_particles(x, y):
    particles = np.zeros((NUM_PARTICLES, 2))
    particles[:, 0] = x
    particles[:, 1] = y
    particles += np.random.randn(NUM_PARTICLES, 2) * PARTICLE_NOISE
    return particles

# Function to update particles
def update_particles(particles, dx, dy):
    particles += np.array([dx, dy]) + np.random.randn(NUM_PARTICLES, 2) * PARTICLE_NOISE
    return particles

# Function to estimate the gaze direction
def estimate_gaze(particles):
    return np.mean(particles, axis=0)

while True:
    # Read a frame from the video capture
    ret, frame = cap.read()
    if not ret:
        break
    
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    
    # Detect eyes
    eyes = eye_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
    
    for (ex, ey, ew, eh) in eyes:
        # Draw a rectangle around the eyes
        cv2.rectangle(frame, (ex, ey), (ex + ew, ey + eh), (0, 255, 0), 2)
        
        # Initialize or update particles for the eye
        particles = initialize_particles(ex + ew // 2, ey + eh // 2)
        
        # Simulate gaze direction changes (replace with actual gaze direction estimation if available)
        dx, dy = np.random.randn() * PARTICLE_WEIGHT, np.random.randn() * PARTICLE_WEIGHT
        particles = update_particles(particles, dx, dy)
        
        # Estimate the gaze direction
        gaze_x, gaze_y = estimate_gaze(particles).astype(int)
        
        # Ensure gaze coordinates are within frame bounds
        gaze_x = np.clip(gaze_x, 0, frame.shape[1] - 1)
        gaze_y = np.clip(gaze_y, 0, frame.shape[0] - 1)
        
        # Draw the gaze point
        cv2.circle(frame, (gaze_x, gaze_y), 5, (255, 0, 0), -1)
        
        # Draw an indicator for gaze direction
        direction_box_size = 100
        if gaze_x < frame.shape[1] // 3:
            x1, y1 = 0, 0
            x2, y2 = direction_box_size, direction_box_size
        elif gaze_x > 2 * frame.shape[1] // 3:
            x1, y1 = frame.shape[1] - direction_box_size, 0
            x2, y2 = frame.shape[1], direction_box_size
        else:
            x1, y1 = frame.shape[1] // 3, 0
            x2, y2 = 2 * frame.shape[1] // 3, direction_box_size
        
        if gaze_y < frame.shape[0] // 3:
            y1, y2 = 0, direction_box_size
        elif gaze_y > 2 * frame.shape[0] // 3:
            y1, y2 = frame.shape[0] - direction_box_size, frame.shape[0]
        else:
            y1, y2 = frame.shape[0] // 3, 2 * frame.shape[0] // 3
        
        # Draw the direction box
        cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 255), 2)
    
    # Display the frame with detected eyes and gaze point
    cv2.imshow('Eye Gaze Detection', frame)
    
    # Exit the loop when 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the video capture and close windows
cap.release()
cv2.destroyAllWindows()
