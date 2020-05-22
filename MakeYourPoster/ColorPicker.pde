class ColorPicker {
  color c0 = #213A6F; //azul
  color c1 = #3B7149; //verde
  color c2 = #E9DA5F; //amarelo 
  color c3 = #EE7731; //lsranja
  color c4 = #EFE5E3; //beje
  color[] colors  = {c0, c1, c2, c3, c4};
  int xpos, ypos, c;
  int w = 50;
  int h = 100;
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
      rect(xpos, ypos+(i*h), w, h);
    }
  }

  public void mousePressed () {
    for (int i=0; i<6; i++) {
      if (mousePressed && mouseX >= xpos && mouseX <= xpos + w && mouseY >= ypos && mouseY <= ypos+(5*h) ) {
        c = get( mouseX, mouseY );
        print(c);
      }
      fill( c );
    }
  }
}  
