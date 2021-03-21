// hold x to depixelate and z to pixelate
int numPixelRows = 8;
float sideLength;
PImage photo;
void setup() {
  size(1,1);
  rectMode(CORNER);
  noStroke();
  photo = loadImage("image.jpg");
  surface.setResizable(true);
  surface.setSize(photo.height, photo.height + 30);
  photo.loadPixels();
  calcSideLength();
  redraw();
  fill(255, 255, 255);
  text("hold x to depixelate and z to pixelate", width / 2, height / 2); 
  textAlign(CENTER, BOTTOM);
  textSize(22);
  noLoop();
}

void draw() {
  fill(0, 0, 0);
  rect(-100, -100, height + 100, width + 100);
  float numPixelCols = width / sideLength;
  for(int row=0; row < numPixelRows; row++){
    for(int col=0; col < numPixelCols; col++){
      int x = round(row * sideLength);
      int y = round(col * sideLength);
      color pixelColor = calculateColor(x, y);
      fill(pixelColor);
      rect(x, y, sideLength, sideLength);
    }
  }
}


private color calculateColor(int x, int y) {
    // Accumulated r, g, b values 
    float r = 0;
    float g = 0;
    float b = 0;

    for (int i = 0; i < sideLength; i++) {
      for (int j = 0; j < sideLength; j++) {
        // photo.get(0,0) is the top left corner
        r += red(photo.get(x + i, y + j));
        g += green(photo.get(x + i, y + j));
        b += blue(photo.get(x + i, y + j));
      }
    }
    // Take mean.
    int numIterations = (int) sq((int) sideLength);
    r /= numIterations;
    g /= numIterations;
    b /= numIterations;
    return color(r, g, b);
  }
  
void keyPressed() {
  if (key == 'x') {
    numPixelRows++;
    calcSideLength();
    redraw();
  } else if (key == 'z') {
    if (numPixelRows > 1) {
      numPixelRows--;
      calcSideLength();
    } 
    redraw();
  } else if (key == ' ' || key == 's') {
    saveFrame("pixelization-##.png");
  }
}

void calcSideLength() {
    sideLength = ceil(((float) width) / numPixelRows);
}
