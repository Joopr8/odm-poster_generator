ArrayList<DraggingPic> pics = new ArrayList<DraggingPic>();
ColorPicker cp;
int drawingNum;
int ph = 800;
int pw = 400;
String state = "start";
PFont Tfont;
PFont Cfont;
PImage title, poster;


void setup() {
  //size(1500, 1000);
  fullScreen();
  Tfont = createFont("VoltaSteDEEBol", 32); 
  Cfont = createFont("VoltaT", 20);
  cp = new ColorPicker(width/2-pw/2, height/2 - ph/2 - 80);
  title = loadImage("title_beje.png");
}

void draw() {
  if (state == "start") { //Welcome page
    welcome_page();
    cp.c = 255;
    place_images();
  } 
  if (state == "doing") { //Making the poster
    doing_page();
    for (DraggingPic p : pics) {
      p.display();
      p.mouseDragged();
    }
    cp.mousePressed();
  }
  if (state == "done") { //Poster Finished 
    done_page();
    reset();
  }
}

void mousePressed() {
  if (state == "start" && mouseX >= width/2 - pw/2 && mouseX <= width/2 + pw/2 && mouseY >= (height/2 + 250) - 25 && mouseY <= (height/2 + 250) + 25) {
    state = "doing";
  }
  for (DraggingPic p : pics) {
    p.draggingpicMousePressed();
  }

  if ( state == "doing" && mouseX >= width/2 - pw/2 && mouseX <= width/2 + pw/2 && mouseY >= height - 75 && mouseY <= height - 25) {
    state = "done";
    PImage drawingArea = get(width/2-pw/2, height/2-ph/2, pw, ph); 
    drawingArea.save("data/my_drawings/" + "My Drawing" + drawingNum + ".png");
  }
  drawingNum ++;
  if ( state == "done" && mouseX >= width/2 - pw/2 && mouseX <= width/2 + pw/2 && mouseY >= (height/2 + 100) - 25 && mouseY <= (height/2 + 100) + 25) {
    state = "start";
  }
}

void mouseReleased() {
  if (state == "doing") {
    for (DraggingPic p : pics) {
      p.draggingpicMouseReleased();
      p.display();
    }
  }
}

void place_images() {
  File dir_with_imgs2 = new File(dataPath("WS"));
  File[] files_imgs2 = dir_with_imgs2.listFiles();
  float cur_y = 30;
  float cur_x = 10;
  for (File file_img2 : files_imgs2) {
    if (file_img2.toString().endsWith(".png")) {
      DraggingPic new_pic2 = new DraggingPic(cur_x, cur_y, file_img2.toString());
      cur_y += new_pic2.sample.height + 10;
      if (cur_y + new_pic2.sample.height + 30 >= height) {
        cur_x += 120;
        cur_y = 20;
      }
      pics.add(new_pic2);
    }
  }
  File dir_with_imgs_left = new File(dataPath("MD"));
  File[] files_imgs = dir_with_imgs_left.listFiles(); //guardar as imagens como ficheiros
  float Ypos_r = 30;
  float Xpos_r = width - 140;

  for (File file_img : files_imgs) { //cada imagem passa a ser um file_img
    if (file_img.toString().endsWith(".png")) { // se o file_img terminar em png
      DraggingPic new_pic = new DraggingPic(Xpos_r, Ypos_r, file_img.toString());
      Ypos_r += new_pic.sample.height + 10;
      if (Ypos_r + new_pic.sample.height  + 30 >= height) {
        Xpos_r -= 120;
        Ypos_r = 30;
      }
      pics.add(new_pic);
    }
  }
}

void welcome_page() { 
  background(#223B6F); 
  imageMode(CENTER);
  image(title, width/2, height/2, title.width, title.height);
  textFont(Tfont); 
  textAlign(CENTER); 
  fill(255); 
  text("Make your Dick Bruna poster!", width/2, height/2 + 200); 
  textFont(Cfont);
  rectMode(CENTER);
  fill(#EFE5E3);
  rect(width/2, height/2 + 250, pw, 50);
  textAlign(CENTER);
  fill(#213A6F);
  text("Click to start", width/2, height/2 + 260);
  imageMode(CORNER);
}

void doing_page() {
  background(#1B3022);  
  rectMode(CENTER);
  //strokeWeight(2);
  //stroke(255);
  fill(cp.c); //fundo do cartaz
  rect(width/2, height/2, pw, ph); //POSTER
  cp.display();
  fill(255);
  rectMode(CENTER);
  fill(255);
  rect(width/2, height-100, pw, 50,10);
  fill(#213A6F); 
  textFont(Cfont);
  textAlign(CENTER, CENTER); 
  text("Save", width/2, height-100);
}

void done_page() {
  File dir_with_posters = new File(dataPath("my_drawings"));
  File[] posters_files = dir_with_posters.listFiles(); //guardar as imagens como ficheiros
  background(#333333); 
  textFont(Tfont); 
  textAlign(CENTER); 
  fill(255); 
  text("Thanks! Your poster has been saved", width/2, height/5); 
  rect(width/2, height/2 + 100, pw, 50);
  fill(0); 
  textFont(Cfont);
  textAlign(CENTER); 
  text("Let's do it again!", width/2, height-40);
  for (File poster_img : posters_files) {
    if (poster_img.toString().endsWith(".png")) {
      poster = loadImage(poster_img.toString());
    }
  }
  image(poster, width/2, height/2, poster.width/1.5, poster.height/1.5);
}

void reset() {
  cp.c = 255; //coloca a cor do cartaz a branco
  for (int i=0; i<pics.size(); i++) {
    pics.remove(i);
  }
}
