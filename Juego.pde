  
import ddf.minim.*;
Minim soundengine;
AudioSample sonido1;

Bichos[] myBichosArray = new Bichos[50];
PImage inicio;
PImage fondo;
PImage insecto;
PImage chancla;

PImage evolucion1;
PImage evolucion2;
PImage evolucion3;

int score = 0;
int actualscore;
int highScore = 0;
boolean introScreen = true;
int savedTime;
int totalTime = 20000;

void setup() {
  size(800, 800);
  smooth();
  soundengine = new Minim(this);
  sonido1 = soundengine.loadSample("sonidobichos.mp3");
  inicio = loadImage("inicio.jpg");
  fondo = loadImage ("fondo.jpg");
  insecto = loadImage ("bicho.png");
  chancla= loadImage ("chancla.png");
  
  evolucion1= loadImage ("cucaracha.png");
  evolucion2= loadImage ("pulga.png");
  evolucion3= loadImage ("arana.png");
  
  textSize(20);  
  savedTime = millis();
  for(int i=0; i<myBichosArray.length; i++) {
    myBichosArray[i] = new Bichos(300,300,25);  
  }
  
}

void draw() { 
  cursor (chancla);
  background(fondo);
  
   
   if (keyPressed) {
    if (key == 'i' || key == 'I') {
       introScreen = false;
    }
  }
 
  if (introScreen==true)
  {
    image(inicio, 0, 0);
    fill(#000000);
    text("Your score: "+actualscore,220,415);
    text("High score: "+highScore,220,440);
  }
  else {
    for(int i=0; i<myBichosArray.length; i++) {  
     myBichosArray[i].speed();
     myBichosArray[i].colision();
     myBichosArray[i].display(); 
     myBichosArray[i].aplasta(); 
     myBichosArray[i].score(); 
     myBichosArray[i].gameover(); 
    }
  } 
   
}

class Bichos {
 
  float x;
  float y;
  float d;
  float xSpeed;
  float ySpeed; 
  
  Bichos(float posX, float posY, float diametro) {
    x = posX;
    y = posY;
    d = diametro;
    
    xSpeed = random(-5, 5);
    ySpeed = random(-5, 5);
     
  }
 
  void speed() {
    x += xSpeed;
    y += ySpeed; 
    
     if (score>10){
     x += xSpeed;
    y += ySpeed; 
    }
    if (score>30){
    x += +xSpeed;
    y += +ySpeed; 
    }
    if (score>40){
    x += +xSpeed;
    y += +ySpeed; 
    }
   
  }
   
  void colision() {
    
    if ((x<0) || (x>width-d)){
      xSpeed = -xSpeed;
    } 
     
    if((y<0) || (y>height-d)) {
      ySpeed = -ySpeed; 
    }
     
  }
   
  void display() { 
    
    if (score<10){
    image(insecto, x, y);
    }
    if ((score>=10)&(score<30)){
     image(evolucion1, x, y);
    }
    if ((score>=30)&(score<40)) {
     image(evolucion2, x, y);
    }
    if (score>=40){
    image(evolucion3, x, y);
    }
    
  }
  
  void aplasta() { 
     if (mousePressed) { 
      float distance = dist(mouseX, mouseY, x, y);
      if (distance<d) {
          x = -1000;
          xSpeed = 0;
          ySpeed = 0;
          score++;
          actualscore= score;
          highScore = max(score, highScore);
          sonido1.trigger();
       }
     } 
  }
  
   void score() { 
    fill(#000000);
    text("score: "+score,10,20);  
  }
  
   void gameover() { 
   int passedTime = millis() - savedTime;
   
     if (passedTime > totalTime){
         introScreen = true;
         savedTime = millis();
         score = 0;
         for(int i=0; i<myBichosArray.length; i++) {
         myBichosArray[i] = new Bichos(300,300,25);  
         }
     }
   }
   
}