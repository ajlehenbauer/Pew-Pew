class Player {
  color c; //  hat color
  float chx; //  xposition
  float chy; //  yposition
  float[][] mainBullets;
  int numBullets;
  int health;
  int fullHealth;
  boolean alive;
  int kc;//kill count
  //INITIALIZE THE INSTANCE VARIABLES
  Player( float x, float y) {
    mainBullets=new float[30][4];
    chx=x;
    chy=y;
    alive=true;
    fullHealth=5;
    health=5;
    kc=0;
  }

  void move (float p, float q) {// moves character in passed direction
    chx+=p;
    chy+=q;
  }


  void display() {//draws character
    fill(0);
    rect(width/2-fullHealth*25, 25, fullHealth*50, 25);
    fill(#FF4848);
    rect(width/2-fullHealth*25, 25, health*50, 25);

    pushMatrix();
    translate(chx, chy);
    textSize(100);


    rotate(atan2((mouseY-chy), (mouseX-chx))+PI/2);
    imageMode(CENTER);
    image(mc, 0, 0);
    imageMode(CORNER);
    popMatrix();
  }
  void drawBullets() {//moves bullets in direction they were shot
    int k;
    if (maxMB)k=29;
    else k=numBullets;
    for (int i=0; i<k; i++) {
      stroke(250,0,0);
      strokeWeight(5);
      line(mainBullets[i][0], mainBullets[i][1], mainBullets[i][2], mainBullets[i][3]);
      stroke(0);
      strokeWeight(1);
      float t1=mainBullets[i][0];
      mainBullets[i][0]+=(mainBullets[i][2]-mainBullets[i][0])/3;
      mainBullets[i][2]+=(mainBullets[i][2]-t1)/3;
      t1=mainBullets[i][1];
      mainBullets[i][1]+=(mainBullets[i][3]-mainBullets[i][1])/3;
      mainBullets[i][3]+=(mainBullets[i][3]-t1)/3;

      for (int j =0; j<enemies.size(); j++) {
        if (dist(mainBullets[i][0], mainBullets[i][1], enemies.get(j).ex, enemies.get(j).ey)<15&&enemies.get(j).isAlive()&&enemies.get(j).ex<width&&enemies.get(j).ey<height&&enemies.get(j).ex>0&&enemies.get(j).ey>0) {
          ahh.rewind();
          ahh.play();
          for(int count=0; i+count<=numBullets;count++){
            if(i+count==29){
              mainBullets[29][0]=0;
              mainBullets[29][1]=0;
              mainBullets[29][2]=0;
              mainBullets[29][3]=0;

          }
            else{
              
            mainBullets[i+count][0]=mainBullets[i+count+1][0];
            mainBullets[i+count][1]=mainBullets[i+count+1][1];
            mainBullets[i+count][2]=mainBullets[i+count+1][2];
            mainBullets[i+count][3]=mainBullets[i+count+1][3];
            }
            
          }
          if(enemies.get(j).health>1){enemies.get(j).health--;
          }
          else{
          enemies.get(j).kill();
          ea--;
          kc++;
          }
        }
      }
    }
  }
void kill(){
  
 alive=false; 
}

boolean isAlive(){
  
 return alive; 
  
}
  void shootDouble() {//adds bullets to bullet array, shoots from each of character's two guns

    float mx=mouseX-chx;
    float my=mouseY-chy;
    float a=atan2(my, mx);
    float y1=chy-15*sin(a+PI/2);
    float x1=chx-15*cos(a+PI/2);
    float y2=mouseY-15*sin(a+PI/2);
    float x2=mouseX-15*cos(a+PI/2);
    if (mouseX>chx&&mouseY>chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1+(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1+(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    } else if (mouseX<chx&&mouseY>chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1-(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1+(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    } else if (mouseX>chx&&mouseY<chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1+(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1-(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    } else if (mouseX<chx&&mouseY<chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1-(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1-(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    }
    y1=chy+15*sin(a+PI/2);
    x1=chx+15*cos(a+PI/2);
    y2=mouseY+15*sin(a+PI/2);
    x2=mouseX+15*cos(a+PI/2);
    if (numBullets==29) {
      maxMB=true;
      numBullets=0;
    } else {
      numBullets++;
    }
    if (mouseX>chx&&mouseY>chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1+(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1+(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    } else if (mouseX<chx&&mouseY>chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1-(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1+(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    } else if (mouseX>chx&&mouseY<chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1+(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1-(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    } else if (mouseX<chx&&mouseY<chy) {
      mainBullets[numBullets][0]=x1;
      mainBullets[numBullets][1]=y1;
      mainBullets[numBullets][2]=x1-(15*abs(x2-x1)/dist(x1, y1, x2, y2));
      mainBullets[numBullets][3]=y1-(15*abs(y2-y1)/dist(x1, y1, x2, y2));
    }
    if (numBullets==29) {
      maxMB=true;
      numBullets=0;
    } else {
      numBullets++;
    }
  }
  void shootBullets() {//adds bullets to bullet array, shoots from charcter's center

    float mx=mouseX-chx;
    float my=mouseY-chy;
    float a=atan2(my, mx);
    float y1=sin(a)/15;
    float x1=cos(a)/15;

    if (mouseX>main.chx&&mouseY>chy) {
      mainBullets[numBullets][0]=chx;
      mainBullets[numBullets][1]=chy;
      mainBullets[numBullets][2]=chx+(15*abs(mouseX-chx)/dist(chx, chy, mouseX, mouseY));
      mainBullets[numBullets][3]=chy+(15*abs(mouseY-chy)/dist(chx, chy, mouseX, mouseY));
    } else if (mouseX<main.chx&&mouseY>main.chy) {
      mainBullets[numBullets][0]=chx;
      mainBullets[numBullets][1]=chy;
      mainBullets[numBullets][2]=chx-(15*abs(mouseX-chx)/dist(chx, chy, mouseX, mouseY));
      mainBullets[numBullets][3]=chy+(15*abs(mouseY-chy)/dist(chx, chy, mouseX, mouseY));
    } else if (mouseX>main.chx&&mouseY<main.chy) {
      mainBullets[numBullets][0]=chx;
      mainBullets[numBullets][1]=chy;
      mainBullets[numBullets][2]=chx+(15*abs(mouseX-chx)/dist(chx, chy, mouseX, mouseY));
      mainBullets[numBullets][3]=chy-(15*abs(mouseY-chy)/dist(chx, chy, mouseX, mouseY));
    } else if (mouseX<main.chx&&mouseY<main.chy) {
      mainBullets[numBullets][0]=chx;
      mainBullets[numBullets][1]=chy;
      mainBullets[numBullets][2]=chx-(15*abs(mouseX-chx)/dist(chx, chy, mouseX, mouseY));
      mainBullets[numBullets][3]=chy-(15*abs(mouseY-chy)/dist(chx, chy, mouseX, mouseY));
    }
    if (numBullets==29) {
      maxMB=true;
      numBullets=0;
    } else {
      numBullets++;
    }
  }
}