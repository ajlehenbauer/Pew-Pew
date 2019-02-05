class Enemy {
  float ex, ey;
  color c;
  boolean killed;
  int s;
  int health;
  float[][] enemyBullets;
  int numBullets;
  PImage e = loadImage("enemy1.png");
  Enemy(float x, float y, int size) {
    health=1;
    enemyBullets=new float[30][4];
    for(int i=0;i<30;i++){
              enemyBullets[i][0]=0;
              enemyBullets[i][1]=0;
              enemyBullets[i][2]=0;
              enemyBullets[i][3]=0;
    }
    ex=x;
    ey=y;
    s=size;
    killed=false;
  }
  void move (float p, float q) {//moves enemy in passed direction
    ex+=p;
    ey+=q;
  }
  void display() {//draws enemy
imageMode(CENTER);
    //fill(#FF1212);
    fill(c);
    pushMatrix();
    translate(ex,ey);
    rotate(-atan2(ex-chx,ey-chy));
    e.resize(s,s);
    image(e,0,0);
    popMatrix();
    imageMode(CORNER);
  }
  void kill() {
    killed=true;
  }
  boolean isAlive() {
    return !killed;
  }
  void drawBullets() {//moves bullets in direction they were shot
    int k;
    if (maxMB)k=29;
    else k=numBullets;
    for (int i=0; i<29; i++) {
      stroke(0,250,0);
      strokeWeight(5);
      line(enemyBullets[i][0], enemyBullets[i][1], enemyBullets[i][2], enemyBullets[i][3]);
      stroke(0);
      strokeWeight(1);
      float t1=enemyBullets[i][0];
      enemyBullets[i][0]+=(enemyBullets[i][2]-enemyBullets[i][0])/3;
      enemyBullets[i][2]+=(enemyBullets[i][2]-t1)/3;
      t1=enemyBullets[i][1];
      enemyBullets[i][1]+=(enemyBullets[i][3]-enemyBullets[i][1])/3;
      enemyBullets[i][3]+=(enemyBullets[i][3]-t1)/3;
      
        if ((dist(enemyBullets[i][0], enemyBullets[i][1], main.chx, main.chy)<15)&&main.health>0) {
          main.health--;
          
          numBullets--;

          for(int count=0; i+count<=numBullets;count++){
            if(i+count==29){
              enemyBullets[29][0]=0;
              enemyBullets[29][1]=0;
              enemyBullets[29][2]=0;
              enemyBullets[29][3]=0;

          }
            else{
              
            enemyBullets[i+count][0]=enemyBullets[i+count+1][0];
            enemyBullets[i+count][1]=enemyBullets[i+count+1][1];
            enemyBullets[i+count][2]=enemyBullets[i+count+1][2];
            enemyBullets[i+count][3]=enemyBullets[i+count+1][3];
            }
            
          }
        }
        
  

}
    
  }

  void shootBullets() {//adds bullets to bullet array
    if (!killed) {
      if (main.chx>ex&&main.chy>ey) {
        enemyBullets[numBullets][0]=ex;
        enemyBullets[numBullets][1]=ey;
        enemyBullets[numBullets][2]=ex+(15*abs(main.chx-ex)/dist(ex, ey, main.chx, main.chy));
        enemyBullets[numBullets][3]=ey+(15*abs(main.chy-ey)/dist(ex, ey, main.chx, main.chy));
      } else if (main.chx<ex&&main.chy>ey) {
        enemyBullets[numBullets][0]=ex;
        enemyBullets[numBullets][1]=ey;
        enemyBullets[numBullets][2]=ex-(15*abs(main.chx-ex)/dist(ex, ey, main.chx, main.chy));
        enemyBullets[numBullets][3]=ey+(15*abs(main.chy-ey)/dist(ex, ey, main.chx, main.chy));
      } else if (main.chx>ex&&main.chy<ey) {
        enemyBullets[numBullets][0]=ex;
        enemyBullets[numBullets][1]=ey;
        enemyBullets[numBullets][2]=ex+(15*abs(main.chx-ex)/dist(ex, ey, main.chx, main.chy));
        enemyBullets[numBullets][3]=ey-(15*abs(main.chy-ey)/dist(ex, ey, main.chx, main.chy));
      } else if (main.chx<ex&&main.chy<ey) {
        enemyBullets[numBullets][0]=ex;
        enemyBullets[numBullets][1]=ey;
        enemyBullets[numBullets][2]=ex-(15*abs(main.chx-ex)/dist(ex, ey, main.chx, main.chy));
        enemyBullets[numBullets][3]=ey-(15*abs(main.chy-ey)/dist(ex, ey, main.chx, main.chy));
      }
      if (numBullets==29) {
        maxMB=true;
        numBullets=0;
      } else {
        numBullets++;
      }
    }
  }
}