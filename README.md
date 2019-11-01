# Core Image and OpenCV

#### Module A 
Create an iOS application using the CoreImage template that:
- Reads and displays images from the camera in real time
- Highlights multiple faces in the scene using CoreImage filters
- Highlights eye and mouth position using CoreImage filters
	- hint: could use another filter for highlights
- an idea for exceptional work (<strong>required for 7000 level students</strong>): display if the user is smiling or blinking (and with which eye)

#### Module B
Create an iOS application using the OpenCV template that:
- Uses video of the user's finger (with flash on) to sense a single dimension stream indicating the "redness" of the finger
- Uses the redness to measure the heart rate of the individual (coarse estimate)
- An idea for exceptional work (<strong>required for 7000 level students</strong>): Display an estimate of the PPG signal
- An idea for exceptional work (<strong>can replace other 7000 level requirements</strong>): Use face detection to look at changes in color of a user's face to get heart rate (i.e., <a href="https://affect.media.mit.edu/pdfs/11.Poh-etal-SIGGRAPH.pdf">Poh's method</a>>)

### Turn in: 

1. The source code for your app in zipped format or GitHub Link. Use proper coding techniques and naming conventions for objective C and swift.
2. Your team member names and team name in the comments of the "main.m" files as well as in upload text. 
3. A video of your app working as intended

### Grading Rubric
|   Points      |     Feature    |
|      :---:    |      :---:     																	|
| 8 points 	| Proper Interface Design |
| 35 points		| Algorithm Design (Efficiency and Approach for each module) |
| 27 points		| Module A (faces highlighted, eyes, mouth, orientations, multiple faces) |
| 20 points		| Module B (heart rate accuracy) |
| 10 points		| Exceptional (free reign to make updates, perhaps on the interface side) |
