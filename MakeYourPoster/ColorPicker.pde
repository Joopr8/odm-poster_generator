class ColorPicker {
  color c0 = #213A6F; //azul
  color c1 = #3B7149; //verde
  color c2 = #E9DA5F; //amarelo 
  color c3 = #EE7731; //lsranja
  color c4 = #EFE5E3; //beje
  color[] colors  = {c0, c1, c2, c3, c4};
  int xpos, ypos, c;
  int w = 80;
  int h = 50;
  PImage cpImage;

  ColorPicker(int xpos, int ypos) { //constructor
    this.xpos = xpos;
    this.ypos = ypos;
  }

  void display() {
    for (int i=0; i<5; i++) {
      noStroke();
      rectMode(CORNER); 
      fill(colors[i]);
      rect(xpos+(i*w), ypos, w, h);
    }
  }

  public void mousePressed () {
    for (int i=0; i<5; i++) {
      if (mousePressed && mouseX >= xpos && mouseX <= xpos+(i*w) + w && mouseY >= ypos && mouseY <= ypos+h) {
        c = get( mouseX, mouseY );
      }
      fill( c );
    }
  }
}  
