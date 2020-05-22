ArrayList<DraggingPic> pics = new ArrayList<DraggingPic>();
ColorPicker cp;
int drawingNum;
int ph = 800;
int pw = 400;
String state = "start";
PFont Tfont;
PFont Cfont;
float scaleImg = 1 ;

void setup() {
  //size(1500, 1000);
  fullScreen();
  Tfont = createFont("VoltaSteDEEBol", 32); 
  Cfont = createFont("VoltaT", 20);
  cp = new ColorPicker(width/2+pw/2+50, height/2 - ph/2);
  place_images();
}

void draw() {
  if (state == "start") { //Welcome page
    cp.c = 255; //coloca a cor do cartaz a branco
    background(238, 119, 49); 
    textFont(Tfont); 
    textAlign(CENTER); 
    fill(255); 
    text("Make your Dick Bruna poster!", width/2, height/2); 
    textFont(Cfont); 
    textAlign(CENTER); 
    text("Click to start", width/2, height/2+100); 
    if (mousePressed==true) {
      state = "doing";
    }
  } else if (state == "doing") { //Making the poster 
    background(36, 53, 66); 
    rectMode(CENTER); 
    stroke(255);
    fill(cp.c);
    rect(width/2, height/2, pw, ph); //POSTER
    cp.display();
    fill(255); 
    textFont(Cfont);
    textAlign(CENTER); 
    text("Press 's' to save", width/2, height-50);
    for (DraggingPic p : pics) {
      p.display();
      p.mouseDragged();
    }
    cp.mousePressed();
    if (key == 's') {
      state = "done";
    }
  } else if (state == "done") { //Poster Finished 
    background(59, 113, 73); 
    textFont(Tfont); 
    textAlign(CENTER); 
    fill(255); 
    text("Thanks! Your poster has been saved", width/2, height/2); 
    textFont(Cfont); 
    textAlign(CENTER); 
    text("Press 'r' to restart", width/2, height/2+50); 
    if (key == 'r') {
      state = "start";
    }
  }
}



void place_images() {
  File dir_with_imgs_left = new File(dataPath("WS"));
  File[] files_imgs = dir_with_imgs_left.listFiles(); //guardar as imagens como ficheiros
  float Ypos_r = 20;
  float Xpos_r = width - 300;

  for (File file_img : files_imgs) { //cada imagem passa a ser um file_img
    if (file_img.toString().endsWith(".png")) { // se o file_img terminar em png
      DraggingPic new_pic = new DraggingPic(Xpos_r, Ypos_r, file_img.toString());
      Ypos_r += new_pic.sample.height + 100;
      if (Ypos_r + new_pic.sample.height >= height) {
        Xpos_r += 150;
        Ypos_r = 20;
      }
      pics.add(new_pic);
    }
  }
  File dir_with_imgs2 = new File(dataPath("MD"));
  File[] files_imgs2 = dir_with_imgs2.listFiles();
  float cur_y = 20;
  float cur_x = 10;
  for (File file_img2 : files_imgs2) {
    if (file_img2.toString().endsWith(".png")) {
      //println("Loading image: " + file_img2.toString());
      DraggingPic new_pic2 = new DraggingPic(cur_x, cur_y, file_img2.toString());
      cur_y += new_pic2.sample.height + 100;
      if (cur_y + new_pic2.sample.height >= height) {
        cur_x += 100;
        cur_y = 20;
      }
      pics.add(new_pic2);
    }
  }
}

void mousePressed() {
  for (DraggingPic p : pics) {
    p.draggingpicMousePressed();
  }
}

void mouseReleased() {
  for (DraggingPic p : pics) {
    p.draggingpicMouseReleased();
  }
}

void keyPressed() {
  if (key == 's') {
    PImage drawingArea = get(width/2-pw/2, height/2-ph/2, pw, ph); 
    drawingArea.save("My Drawings/" + "My Drawing" + drawingNum + ".png"); 
    drawingNum ++;
  }
}

void reset () {
}
