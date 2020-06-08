class DraggingPic {
  float x;
  float y;
  PImage sample; 
  boolean hold; // controls whether we are dragging (holding the mouse)
  float scale_img =1;

  DraggingPic(float posx, float posy, String imageNameAsString) {  // constructor
    x=posx;
    y=posy;
    sample = loadImage(imageNameAsString);
    sample.resize(100, 0);
  }
  
  void display() {
    image(sample, x, y);
  }

  void draggingpicMousePressed() {
    if (mouseX>x && mouseY>y && mouseX<x+sample.width && mouseY<y+sample.height) {
      hold=true;
    }
  }

  void draggingpicMouseReleased() {
    hold=false;
  }

  void mouseDragged() {
    if (hold) {
      x=x+(mouseX-pmouseX); 
      y=y+(mouseY-pmouseY);
    }
  }
}
