/* Assignment - Midterm

Patricia Antlitz's City - due on November 2nd, 2020 at 11:59 PM

ID: 00318934
Student Name: Patricia Antlitz
Professor: Ethel Schuster
Date: 2 November 2020
Class: CIS-140

I have used other sources, as detailed in my submitted source file.

Glowing object:
https://forum.processing.org/one/topic/how-to-make-the-outline-glowing.html

Tree:
https://www.youtube.com/watch?v=M4eSb3F9dVY

Gradient:
https://processing.org/examples/lineargradient.html

Stars:
https://www.openprocessing.org/sketch/188203

*/

// set variables for all colors used in the program
int lightGreen = color(81, 188, 5); // grass and trees
int green = color(61, 145, 1); // grass and trees
int night = color(30, 30, 50); // night sky color
int horizonBlue = color(0, 52, 183); // gradient color for the sky
int day = color(137, 202, 255); // day sky color
int yellow = color(250, 220, 130); // sun and lights
int white = color(255); // lamps, cloud, moon
int black = color(0); // night landscape
int mustard = color(252, 203, 10); // traffic lights, building
int gray = color(99); // pavement, day time windows, building
int lightGray = color(195); // lamp posts, building
int orange = color(255, 118, 7); // building
int lightPink = color(255, 196, 240); // building
int red = color(150, 0, 0); // building, stop sign
int water = color(1, 78, 84); // color for water (lake) during day time
int moonGray = color(240); // moon color
int nightGreen = color(30, 73, 0); // grass at night time
int brown = color(137, 84, 11); // trees day time

//variable Y_AXIS sets the location of y to be used for glow
int Y_AXIS = 1;
// variables PImage sets the name jeep and sedan to the png images imported
PImage jeep;
PImage sedan;

// variable stars gives the total of stars that will be displayes
int stars = 300;
// flaot xlocS and ylocS gives x and y location of stars
float[] xlocS = new float[stars];
float[] ylocS = new float[stars];

// create screen of at least 600x600
void setup(){
  size(700, 700);
  // call variables created with PImage and load images on file for both cars
  jeep = loadImage("car1.png");
  sedan = loadImage("car2.png");
  // make shapes smooth
  smooth();
  // removes border
  noStroke();
  // for loop generated stars at random coordinates
  for(int i = 0; i < stars; i++){
    //add randomness to variables xlocS and ylocS
    xlocS[i] = random(width);
    ylocS[i] = random(height);
  }
}

// function draw created the main scene (day)
void draw() {
  // add background as gray which is also used as the "pavement"
  background(gray);
  /* Function setGradient create the gradient effect for the sky, refer to 
  the function on line for more information*/
  setGradient(0, 0, width, height/2, horizonBlue, day, Y_AXIS);
  // Function drawScene draws the main day scene, function on line
  drawScene();
}

/*Function drawStars will draw the actual stars on the screen, this function is 
called inside of the built-in function keyPressed on line */
void drawStars(){
  // for loop creates stars
  for(int i = 0; i < stars; i++){
    // calls function drawCircle on line to create circles on the sky
    drawCircle(white, xlocS[i], ylocS[i], 2, 2);
   }
}

void draS(){
}


/*Function drawRect creates all rectangles on the page, it calls for 5 params,
c of type integer for the color of the rectangle, x and y of type float for the
location of the rectangle and wide and tall for the size*/
void drawRect(int c, float x, float y, float wide, float tall){
  // removed the border
  noStroke();
  // fills the rectangle with the color selected
  fill(c);
  // pass params to draw rectangle
  rect(x, y, wide, tall); 
}

/*Function drawCircle creates all circles on the page, it calls for 5 params,
c of type integer for the color of the circle or ellipse, x and y of type float for 
the location of the rectangle and wide and tall for the size*/
void drawCircle(int c, float x, float y, float wide, float tall){
  noStroke();
  fill(c);
  ellipse(x, y, wide, tall); 
}

/*Function drawTriangle creates all triangles on the page, it calls for 7 params,
c of type integer for the color of the rectangle, x's and y's of type float for the
location of each point of the triangle*/
void drawTriangle(int c, float x1, float y1, float x2, float y2, float x3, float y3){
  fill(c);
  triangle(x1, y1, x2, y2, x3, y3); 
}

/*Function drawLine creates all lines on the page, it calls for 6 params,
c of type integer for the color of the line, w of type integer for the weight
of the line, x's and y's of type float for the location of each point of the line */
void drawLine(int c, int w, float x1, float y1, float x2, float y2){
  stroke(c);
  strokeWeight(w);
  line(x1, y1, x2, y2); 
}

/*Function drawCloud uses the functions drawLine on line 134 and drawCircle on line
117 to create the cloud on the day sky, it calls for 5 params, "c" for the color
of the cloud, l1, l2, l3 and l4 are the location of each of the points of the
line, circles are placed in accordance with params l1 and l2 od the line*/
void drawCloud(int c, int l1, int l2, int l3, int l4){
  /* call function drawLine, give color c, to be chose, give it a line weight of 
  20px, pass params for line placement on the screen */
  drawLine(c, 20, l1, l2, l3, l4); 
  /* call funtion drawCircle, select color, place each circle at a specific distance
  from l1 and l2, give desired size*/
  drawCircle(c, l1+5, l2-5, 35, 30);
  drawCircle(c, l1+35, l2-20, 55, 50);
  drawCircle(c, l1+70, l2-15, 40, 35);
  drawCircle(c, l1+85, l2-5, 35, 30);
}

/*Function drawCelestial uses the functions drawCircle on line 117 to create the 
sun on the day sky, and the moon on the night sky, it calls for 7 params, "c" for 
the color of the star, x and y are the location of each cirlce, w, w2, t and t2
are the sizes of each circle. This function creates on circle inside of the other
and blurs the largest circle surrounding to give it an effect of glow*/
void drawCelestial(int c, int x, int y, int w, int t, int w2, int t2){
  noStroke();
  // smaller "inside" circle
  drawCircle(c, x, y, w, t);
  // filter with param BLUR will blur the edges
  filter(BLUR, 10);
  // outside circle
  drawCircle(c, x, y, w2, t2);
}

/* Function drawTree will draw a line of consecutive tree on the screen behind the
buildings, it calls functions drawLine, on line 134 to create the tree body and
function drawCircle on line 117 to create the tree "leafs" and it calls for three
params all for colors*/
void drawTree(int c, int c1, int c2){
  /* for loop will start at a specific width of the page as the value of i
  as long as i is equal and/or less than the width of the page, it will add
  100px to the original value of i, separating the trees*/
  for(int i = width/10; i <= width; i+=100){
    /* similar to function drawCloud, it will place each circle
    at a certain place on the screen in relation to the value of i.
    It will also allow each circle to have an specific color. */
  drawLine(c, 20, i, height/3+50, i, height/2);
  drawCircle(c1, i-20, height/3+50, 40, 40);
  drawCircle(c2, i, height/3+30, 50, 50);
  drawCircle(c2, i+25, height/3+50, 40, 40);
  drawCircle(c1, i+5, height/3+50, 50, 50);
  }
}

/*Function drawBuilding will draw all the building on the screen by using the
function drawRect on line 105 and add windows to the buildings by using function
drawWindows. All params called on this function represents the colors of each
buiding and windowsc Param c1 to c9 are the color of the buildings, param wind is
the color of the windows*/
void drawBuilding(int c1, int c2, int c3, int c4, int c5, int c6, int c7,
int c8, int c9, int wind){
  // first three buildings
  // orange building #1 calling funtion drawRect
  drawRect(c1, 0, height/3, 70, 120); 
  /* calls funtion draWindows that places windows on this specific building by 
  by using a loop*/
  drawWindows(wind, 10, height/3+20, width/12, height/2, 10, 10, 20);
  
  //mustard building #2 calling funtion drawRect
  drawRect(c2, 80, height/4, 90, 180);
  drawWindows(wind, 90, height/4+20, width/5, height/2-30, 15, 15, 20);
  
  //pink building #3 calling funtion drawRect
  drawRect(c3, 175, height/3-20, 60, 143);
  drawWindows(wind, 180, height/3-10, width/3, height/2-30, 10, 20, 20);
  
  // middle three buildings
  // light gray building #4 calling funtion drawRect
  // line on top of the building
  drawLine(black, 3, 325, height/5, 325, height/5-30);
  drawPoint(red, 325, height/5-30);
  // read antenna "light"
  drawRect(c4, 290, height/5, 70, 215);
  drawWindows(wind, 295, height/5+20, width/2, height/2-30, 30, 20, 33);
  
  //red building #6 calling funtion drawRect
  drawRect(c6, 380, height/4, 50, 180);
  drawWindows(wind, 400, height/4+20, 9.4*width/16, height/2-30, 20, 10, 20);
  
  //light yellow building #5 calling funtion drawRect
  drawRect(c5, 340, height/3, 50, 125);
  drawWindows(wind, 345, height/3+20, 8.7*width/16, height/2-30, 20, 10, 20);
  
  //last three buildings
  //dark gray building #7 calling funtion drawRect
  drawRect(c7, 500, height/3+30, 50, 90);
  
  //dark blue building #8 calling funtion drawRect
  drawRect(c8, 550, height/3, 70, 120);
  drawWindows(wind, 555, height/3+20, 14*width/16, height/2-30, 20, 10, 20);  
  
  //black building #9 calling funtion drawRect
  drawRect(c9, 630, height/5-30, 50, 245);
  drawLine(black, 3, 655, height/5-55, 655, height/5-10);
  drawPoint(red, 655, height/5-55);
  drawWindows(wind, 640, height/5, 15.5*width/16, height/2-30, 10, 10, 20); 
 
}

/*Function drawWindows draws the windows on each of the building by creating
them at the same time on a loop. It takes 8 params, c for the color of the 
windows, xloc and yloc are the location of x and y, screenW and screenH are 
the total size to be looped, w and t the size of the windows and space the
space around the windows */
void drawWindows(int c, float xloc, float yloc, float screenW, float screenH,
int w, int t, int space){
  /*for loop will go over the x axis and the y axis to create lines of vertical
  and horizontal windows that will be placed inside of each building by specifying
  the xloc and yloc initial location of i and j and when to stop the loop by
  specifying screenW and screenH*/
  for(float i = xloc; i<=screenW; i+=space){
  for(float j = yloc; j<=screenH; j+=space){
    //calls function drawRect and pass params to draw the windows
    drawRect(c, i, j, w, t);
    }
  }
}

// function drawPoint draws the red point on top of the antennas
void drawPoint(int c, int x, int y){
  stroke(c);
  point(x, y);
}

/* this funtion draws all the lamps the pavement area of the scene it calls for
two params c and c2 which represents the colors of the pole and the "bulb"*/
void drawLamps(int c, int c2){
  // top area inside of triangle
  // calls drawLine function to create the pole
  drawLine(c, 4, width/3, 9.3*height/16, width/3, 10.5*height/16);
  // calls drawRect to create the bulb
  drawRect(c2, width/3, 9.3*height/16, 15, 5);
  
  drawLine(c, 4, width/7, 9*height/16, width/7, 10.1*height/16);
  drawRect(c2, width/7, 9*height/16, 15, 5);
  
  drawLine(c, 4, 10*width/16, 9.3*height/16, 10*width/16, 10.5*height/16);
  drawRect(c2, 10*width/16, 9.3*height/16, 15, 5);
  
  drawLine(c, 4, 13*width/16, 9*height/16, 13*width/16, 10.1*height/16);
  drawRect(c2, 13*width/16, 9*height/16, 15, 5);
  
  //left side of the screen
  drawLine(c, 4, width/5, 10.5*height/16, width/5, 12*height/16);
  drawRect(c2, width/5, 10.5*height/16, 15, 5);
  
  drawLine(c, 4, width/15, 10*height/16, width/15, 11.5*height/16);
  drawRect(c2, width/15, 10*height/16, 15, 5);
  
  drawLine(c, 4, 20, 10.8*height/16, 20, 12.5*height/16);
  drawRect(c2, 20, 10.8*height/16, 15, 5);
  
  // right side of the screen
  drawLine(c, 4, 13*width/16, 10.5*height/16, 13*width/16, 12*height/16);
  drawRect(c2, 13*width/16, 10.5*height/16, 15, 5);
  
  drawLine(c, 4, 15*width/16, 10*height/16, 15*width/16, 11.5*height/16);
  drawRect(c2, 15*width/16, 10*height/16, 15, 5);
  
  drawLine(c, 4, 15.5*width/16, 10.8*height/16, 15.5*width/16, 12.5*height/16);
  drawRect(c2, 15.5*width/16, 10.8*height/16, 15, 5);

}

/* drawLightsLine creates the line of the light poles in front of the buildings*/
void drawLightsLine(int c, int c1){
  /*similar to the function created to draw trees, drawTree, it loops on the
  x axis to create a line to poles that will be separated by 100 px from each other
  */
  int i;
  for(i = 20; i<=width; i+=100){
    stroke(c);
    strokeWeight(4);
    line(i, height/2+15, i, height/2-40);
    drawRect(c1, i, height/2-40, 10, 5);
  }
}

/* Function drawStop draws the 4 stop signs in the scene, pole and plaque*/
void drawStop(){
  //top stop sign
  drawCircle(lightGray, width/2+2, 10*height/16, 15, 20);
  drawLine(black, 3, width/2, 10*height/16, width/2, 11*height/16);
  
  // bottom stop sign
  drawLine(black, 3, width/2, 13*height/16, width/2, 12*height/16);
  drawCircle(red, width/2, 12*height/16, 17, 20);
  
  //left stop sign
  drawCircle(lightGray, width/3, 11*height/16, 15, 20);
  drawLine(black, 3, width/3, 11*height/16, width/3, 12*height/16);
  
  // right stop sign
  drawLine(black, 3, 11*width/16, 11*height/16, 11*width/16, 12*height/16);
  drawCircle(red, 11*width/16, 11*height/16, 17, 20);
}

/* function drawLandscape puts together many of the previous functions to create
the main landscape of the page for both day and night scenes. That includes
the four triangle "grass area", the pavement lines, the grass circle "roundanout"
the grass area by the buildings and the lake */
void drawLandscape(int wC, int t1, int t2){
  // calls param wc for color
  drawRect(wC, 0, height/2+20, width, 67);
  drawRect(t1, 0, height/2, width, 30);
  
  // top triangle
  // params t1 color of the shade
  drawTriangle(t1, 0, 10*height/16, width/2, 11*height/16,
  width, 10*height/16);
  // param t2 color of the sun light
  drawTriangle(t2, width/2, 10*height/16, width/2, 11*height/16,
  width, 10*height/16);
  
  //bottom
  drawTriangle(t1, 0, height, width/2, 13*height/16,
  width, height);
  drawTriangle(t2, width/3, height, width/2, 13*height/16,
  width, height);
  
  //left
  drawTriangle(t1, 0, 11*height/16, width/3, 12*height/16,
  0, 13.5*height/16);
  
  //right
  drawTriangle(t2, width, 11*height/16, 11*width/16, 12*height/16,
  width, 13.5*height/16);
  
  //left bottom traffic line
  drawLine(mustard, 5, 0, 14.5*height/16, width/3, 12.8*height/16);
  //right bottom traffic line
  drawLine(mustard, 5, 11*width/16, 12.8*height/16, width, 14.5*height/16);
  //right top traffic line
  drawLine(mustard, 5, 10.5*width/16, 11.3*height/16, width, 10.4*height/16);
  //left top traffic line
  drawLine(mustard, 5, 0, 10.3*height/16, width/3+10, 11.2*height/16);
  // roundabout
  drawCircle(t1, width/2, 11.8*height/16, 120, 40);
}

/*This is the funtion called inside of draw the calls all previous function directly
or indirectly to build the entire day scene*/
void drawScene(){
  // draws the sun
  drawCelestial(yellow, 550, 100, 95, 95, 90, 90);
  // draws the cloud
  drawCloud(white, 150, 100, 250, 100);
  // draws tree line
  drawTree(brown, green, lightGreen);
  // draws the landscape, grass, water, pavement lines
  drawLandscape(water, green, lightGreen);
  // draws stop signs
  drawStop();
  // adds car images to the screen
  image(jeep, width/7, 10.2*height/16);
  image(sedan, 11*width/16, 12*height/16);
  // draw pavement lights
  drawLamps(lightGray, white);
  // draws all the buildings
  drawBuilding(orange, mustard, lightPink, lightGray, yellow, red, gray,
  horizonBlue, black, gray);
  // draw line of light poles in front of the buildings
  drawLightsLine(gray, white);
}

/*Function setGradient draws a gradient sky on the screen using a line
function. It calls param of time integer for x and y for the location of the
line on the x and y axis, params of type float for w and h for the width and 
height of the shape, params c1 and c2 of type color that determinates the 
color variation on the gradient and param axis of type integer used on if statement
which is passed as Y_AXIS*/
void setGradient(int x, int y, float wide, float tall, color c1, color c2,
int axis ) {
// removed the filling of the shape
  noFill();
// if statement checks if param axis is equal to variable Y_AXIS
  if (axis == Y_AXIS) { 
    /*if so, loop through i which is equal to param y, while i is less or/and
    equal to y location plus height, add 1 to i*/
    int i = y;
      while (i <= y+tall) {
      i++;
      // variable inter maps between the values
      float inter = map(i, y, y+tall, 0, 1);
      // select colors and map
      color c = lerpColor(c1, c2, inter);
      // and color c variable to the stroke
      stroke(c);
      // created the line passing the params
      line(x, i, x+wide, i);
    }
  }  
}

/* built-in function keyPressed will draw the scenarios based on the keys 
pressed on the keyboard*/
void keyPressed(){
  
  // if key "n" or "N" is pressed
  if(int(key) == 110 || int(key) == 70){
    // draws the night scene
  // Function setGradient draws the gradient sky for the night
  setGradient(0, 0, width, height/2, night, horizonBlue, Y_AXIS);
  //following functions are called to create the night scene
  // draws the moon
  drawCelestial(white, 150, 100, 75, 75, 70, 70);
  // draws all the stars
  drawStars();
  // draws the pavement
  drawRect(gray, 0, height/2, width, height/2);
  // draws the circles inside of the moon
  drawCircle(moonGray, 135, 95, 20, 20);
  drawCircle(moonGray, 160, 90, 25, 25);
  drawCircle(moonGray, 155, 115, 15, 15);
  // draws the tree in night colors
  drawTree(black, black, gray);
  // draws the landscape in night colors
  drawLandscape(black, nightGreen, nightGreen);
  // draws stop signs
  drawStop();
  // draws pavement lights
  drawLamps(lightGray, yellow);
  // draw all the building with windows
  drawBuilding(black, black, black, black, black, black, black, black, black, yellow);
  // draws the light poles in front of the buildings
  drawLightsLine(lightGray, white); 
  // remove the loop existing in function draw()
  noLoop();
  } // else if key "d" or "D" is pressed
  else if(int(key) == 100 || int(key) == 68){
    // add the loop for draw() back to draw day scene
  loop();
  }
}

// end.
