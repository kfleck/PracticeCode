//new array list
ArrayList<Particle> particles = new ArrayList<Particle>();
//audio
import ddf.minim.*;
Minim minim;
AudioPlayer player;
//variables for the firework and balls
float wx,hy;
float x,y,ac,ve;
PVector loc,vel,acc;
//firework picture
PImage firework;
//size
float d=50;
void setup() {
  //color mode
  colorMode(HSB, 360, 100, 100, 100);
  size(800,600);
  //add one new particle to the particles ArrayList
  particles.add(new Particle(width/2, 120));
  //define start locations
  wx=random(width);
  hy=random(height);
  x=random(width);
  y=height;
  ve=random(5,6);
  ac=random(.1,.2);
  //music
  minim= new Minim(this);
  //load image
  firework = loadImage("firework final.png");
  //play music
  player = minim.loadFile("Katy Perry - Firework.mp3");
  player.play();
}

void draw() {
  //draw background
  background(0);
  //draw the circles
  loc = new PVector(random(width), height);
  vel = new PVector(-5,-1);
  acc = new PVector(1,3);
  //draw the firework
  image(firework, x, y, 50, 50);
  //update firework
  ve=ve-ac;
  y=y-ve;
  //make firework explode
  if(ve<.1){
   wx=x;
   hy=y;
   x=random(width);
   y=height;
   ve=random(8,13);
   ac=random(.1,.15);
  }
//additional function: balls where moused pressed
  if (mousePressed){
    wx = mouseX;
    hy = mouseY;
  }
  //add new particles
  particles.add(new Particle(wx, hy));
  //run loop backwards to avoid glitching
  for (int i = particles.size()-1; i >=0; i--) {
    Particle p = particles.get(i);
    p.display();
    p.update();
    //remove particles
    if (p.life <= 0) {
      particles.remove(i);
    }
  }
}
//class particle
class Particle {
  PVector loc, vel, acc;
  int size;
  float hue;
  int life;
//location of particle
  Particle(float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-2, 0));
    acc = new PVector(0, .01);
    size = 20;
    hue = random(360);
    life = 100;
  }
//draw the ellipses
  void display() {
    fill(hue, 100, 100);
    stroke(hue, 100, 50);
    strokeWeight(2);
    ellipse(loc.x, loc.y, size, size);
  }
//update everything
  void update() {
    vel.add(acc);
    loc.add(vel);
    life--;
  }
}
