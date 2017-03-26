import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.sound.*;

//Buttons
Button b,b2,b3,b4,b5,b6,b7,b8;

//Images
PImage menuimg;

//Sounds
SoundFile snakemusic;
SoundFile GmeOver;

int wallhei, wallwid;

snake snek;
food food1;

//Global Integers
int highScore;




//booleans
boolean strgm = true;
boolean begin = false;
boolean pauseboard = false;
boolean endgm = false;
boolean bgmusic = false;
boolean qtgame = false;
boolean rst = false;
boolean ctrls = false;

void setup(){
  size(1000, 600);
  wallhei = height;
  wallwid = width;
 // call buttons
    b = new Button(450,310,125,100,"Play Again");
    b2 = new Button(600,310,125,100,"Quit Game");
    b3 = new Button(450,310,125,100,"Resume Game");
    b4 = new Button(500,200,125,100,"Play Game");
    b5 = new Button(500,310,125,100,"Controls");
    b6 = new Button(500,420,125,100,"Quit Game");
    b7 = new Button(663,518,160,50,"Main Menu");
    b8 = new Button(530,310,200,150,"Main Menu");
  //set up minim cause reasons

  
    //call sound files
  snakemusic = new SoundFile(this, "Snakeloop.mp3");
  GmeOver = new SoundFile(this, "gameoversnd.wav");


  
  frameRate(14);
  snek = new snake();
  food1 = new food();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
   
  
   
  highScore = 0;
   
   //setup image
 menuimg = loadImage("Board.png");  

 
  }

 
 
 
void draw(){
 background(0);
 
 if (strgm == true) {
  
   fill(25,30,0);
   rect(500,300,500,500);
   
   
   fill(52,255,0);
  textSize(45);
  text( "Trevino's Snake Game", width/2, 80);
  b4.update();
  b5.update();
  b6.update();
  
    //button 4 starts game
    
    if(b4.clicked) {
   
    begin = true;
    strgm = false;
    endgm = false;
    pauseboard = false;
    bgmusic = false;
    qtgame = false;
    rst = false;
    ctrls = false;
    
  }
  
  //button 5 controls 
  
      if(b5.clicked) {
   
    strgm = false;
    ctrls = true;
    begin = false;
    endgm = false;
    pauseboard = false;
    bgmusic = false;
    qtgame = false;
    rst = false;
    
    
  }
  
  if(b6.clicked)exit();
  
 }
 
 if (ctrls == true) {
  
  // rectangle the holds all contents 
   fill(25,30,0);
   rect(500,300,500,500);
   
   // Title 
   fill(52,255,0);
  textSize(45);
  text( "Controls", width/2, 80); 
  
  //Text 
   fill(52,255,0);
  textSize(20);
  text( "W or Up Arrow to move up.", 400, 150); 
  text( "A or Left Arrow to move left.", 407, 190);
  text( "S or Down Arrow to move Down.", 425, 230);
  text( "D or Right Arrow to move left.", 411, 270);
  text( "P to pause the game.", 368, 310);
  
  // Main Menu button
  b7.update();
  //Button clicked
    if(b7.clicked) {
      
    ctrls = false;
    strgm = true;
    begin = false;
    pauseboard = false;
    endgm = false;
    bgmusic = false;
    qtgame = false;
    rst = false;
    
  }
 }
  
  //begin starts up the game 
  if (begin == true) {


  
  drawScoreboard();
  snek.move();
  snek.display();
  food1.display();

   
  if( dist(food1.xpos, food1.ypos, snek.xpos.get(0), snek.ypos.get(0)) < snek.sidelen ){
    food1.reset();
    snek.addLink();
  }
   
  if(snek.len > highScore){
    highScore= snek.len;
  }
 

  
  }
  
  if (pauseboard==true) {
   drawScoreboard();
   
  image(menuimg, 275, 150, 500, 300);
  
  
  fill(52,255,0);
  textSize(60);
  text( "Game Paused", 530, 180);
  
  b2.update();
  b3.update();
  
  if(b3.clicked) {
    pauseboard = false;
    begin = true;
    strgm = false;
    endgm = false;
    bgmusic = false;
    qtgame = false;
    rst = false;
    ctrls = false;
  }
  
  if(b2.clicked)exit();
  }

  if (qtgame==true) {
   drawScoreboard();
   
  image(menuimg, 275, 150, 500, 300);
  
  
  fill(52,255,0);
  textSize(60);
  text( "Game Over", 530, 180);
  
 
  b8.update();
  
  
  if(b8.clicked) {
 
    qtgame = false;
    strgm = true;
    begin = false;
    pauseboard = false;
    begin = false;
    endgm = false;
    bgmusic = false;
    rst = false;
    ctrls = false;
    
  }
  
  
  }

}

 
 
void keyPressed(){
  
  
  
  if(key == CODED){
    if(keyCode == LEFT){
      snek.dir = "left";
    }
    if(keyCode == RIGHT){
      snek.dir = "right";
    }
    if(keyCode == UP){
      snek.dir = "up";
    }
    if(keyCode == DOWN){
      snek.dir = "down";
    }
   
    
  }
  
    if(key == 'a'){
      snek.dir = "left";
    }
    if(key == 'd'){
      snek.dir = "right";
    }
    if(key == 'w'){
      snek.dir = "up";
    }
    if(key == 's'){
      snek.dir = "down";
    }
  
  if(key == 'p' && strgm == false && ctrls == false && qtgame == false) { 
    
 strgm = false;
 begin = false;
 pauseboard = true;
 endgm = false;
 bgmusic = false;
 qtgame = false;
 rst = false;
 ctrls = false;
 
  }
  
  
  //The ASCII code for esc is 27, so therefore 27
  if(key == 27) {
    exit();
    }
  
}
 
 
void drawScoreboard(){
  // Textfill
   

  

   
  // draw scoreboard
  stroke(0);
  fill(23,30,0);
  rect(90,65,150,90);
  
  
  fill(52,255,0);
  textSize(17);
  text( "Score: " + snek.len, 70, 50);
   
  fill(52,255,0);
  textSize(17);
  text( "High Score: " + highScore, 91, 70);
}
 
class food{
   
  // define varibles
  float xpos, ypos;
   
   
   
  //child class
  food(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
  }
   
   
  // functions
 void display(){
    
   fill(0,255,0);
   ellipse(xpos, ypos,17,17);
 }
  
  //child class resets food 
 void reset(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
 }  
}
 
class snake{
   
  //define varibles
  int len;
  float sidelen;
  String dir;
  ArrayList <Float> xpos, ypos;
  boolean hitchk;
     //child class resets food 

  // constructor
  snake(){
    len = 1;
    sidelen = 17;
    dir = "right";
    xpos = new ArrayList();
    ypos = new ArrayList();
    xpos.add( random(width) );
    ypos.add( random(height) );
    
    
    
  }
   
  
  // functions
  

   
  void move(){
   for(int i = len - 1; i > 0; i = i -1 ){
    xpos.set(i, xpos.get(i - 1));
    ypos.set(i, ypos.get(i - 1)); 
   }
   
   
   if(dir == "left"){
     xpos.set(0, xpos.get(0) - sidelen);
   }
   if(dir == "right"){
     xpos.set(0, xpos.get(0) + sidelen);
   }
    
   if(dir == "up"){
     ypos.set(0, ypos.get(0) - sidelen);
   
   }
    
   if(dir == "down"){
     ypos.set(0, ypos.get(0) + sidelen);
   }
   xpos.set(0, (xpos.get(0) + width) % width);
   ypos.set(0, (ypos.get(0) + height) % height);
    
    // check if hit is true the Game Over Screen will pop up.
    if( checkHit() == true){
      len = 1;
      float xtemp = xpos.get(0);
      float ytemp = ypos.get(0);
      xpos.clear();
      ypos.clear();
      xpos.add(xtemp);
      ypos.add(ytemp);
      qtgame = true;
      strgm = false;
      begin = false;
      pauseboard = false;
      endgm = false;
      bgmusic = false;
      rst = false;
      ctrls = false;
    }
    
 
    
  }
   
   
   
  void display(){
    for(int i = 0; i <len; i++){
      stroke(163,255,159);
      fill(0,255,0, map(i-1, 0, len-1, 250, 50));
      rect(xpos.get(i), ypos.get(i), sidelen, sidelen);
      if(xpos.get(i) > wallwid) {
       hitchk = true; 
      } else {
       hitchk = false; 
      }
      if(ypos.get(i) > wallhei) {
       hitchk = true; 
      } else {
       hitchk = false; 
      }
    } 
  }
   
   
  void addLink(){
    xpos.add( xpos.get(len-1) + sidelen);
    ypos.add( ypos.get(len-1) + sidelen);
    len++;
  }
   
   boolean checkHit(){
    for(int i = 1; i < len; i++){
     
      //sees if snake touches itself
     if( dist(xpos.get(0), ypos.get(0), xpos.get(i), ypos.get(i)) < sidelen){
       return true; 
     }
   
  //snake's head hits the walls 
    if(dist(snek.xpos.get(0),snek.ypos.get(0),snek.xpos.get(i),snek.ypos.get(i)) > wallhei) {
      return true;
    }
    
    }  
    if(hitchk == true) {
     return true; 
    }
    return false;
    
   }
}

//calls the button class
class Button{
  int xpos, ypos, wid, hei;
  String label;
  boolean over = false;
  boolean down = false; 
  boolean clicked = false;
  Button(
  int tx, int ty,
  int tw, int th,
  String tlabel
  ){
    xpos = tx;
    ypos = ty;
    wid = tw;
    hei = th;
    label = tlabel;
  }
  
  void update(){
    //it is important that this comes first
    if(down&&over&&!mousePressed){
      clicked=true;
    }else{
      clicked=false;
    }
    
    //UP OVER AND DOWN STATE CONTROLS
    if(mouseX>xpos && mouseY>ypos && mouseX<xpos+wid && mouseY<ypos+hei){
      over=true;
      if(mousePressed){
        down=true;
      }else{
        down=false;
      }
    }else{
      over=false;
    }
    smooth();
    
    //box color controls
    if(!over){
      fill(52,255,0);
    }else{
      if(!down){
        fill(52,120,0);
      }else{
        fill(52,80,0);
      }
    }
    stroke(0);
    rect(xpos, ypos, wid, hei, 10);//draws the rectangle, the last param is the round corners
    
    //Text Color Controls
    if(down){
      fill(0);
    }else{    
      fill(0);
    }
    textSize(16); 
    text(label, xpos+wid/30-(textWidth(label)/30), ypos+hei/30+(textAscent()/30)); 
    //all of this just centers the text in the box
  } 
}