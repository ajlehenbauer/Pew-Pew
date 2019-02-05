import ddf.minim.*;
PImage back;
PImage ground;
int chx;
int chy;
int fx;
int fy;
int groundX;
int groundY;
Player main;
boolean start;
boolean e;
boolean h;
boolean keys[];
ArrayList<Enemy> enemies;
PImage mc;
boolean maxMB;
boolean chooseChar;
boolean endRound;
Minim minim;
AudioPlayer player;
AudioInput input;
AudioPlayer pew;
AudioPlayer enemyPew;
AudioPlayer backgroundMusic;
  AudioPlayer ahh;

int round;
Player o;
Player two;
Player three;
Player four;
int ea;
boolean instructions;
void setup() {
  instructions=false;
  minim=new Minim(this);
    ahh=minim.loadFile("ahh.wav");

  pew = minim.loadFile("pewpew.wav");
  enemyPew = minim.loadFile("peew.wav");
  backgroundMusic=minim.loadFile("backgroundmusic.mp3");
  backgroundMusic.play();
  input = minim.getLineIn();
  o = new Player(width/6, width/2);
  two = new Player(2*width/6, width/2);
  three = new Player(4*width/6, width/2);
  four = new Player(5*width/6, width/2);

  round=1;
  minim = new Minim(this);
  enemies=new ArrayList<Enemy>();
  chooseChar=false;
  maxMB=false;
  mc=loadImage("mainCharacter.png");
  frameRate=30;
  keys = new boolean[20];
  size(600, 600); 
  ground = loadImage("grass.jpg");
  image(ground, -width/4, -height/4);
  // background(back);
  fx=width/2;
  start=false;
  fy=height/2;
  groundX=-2000;
  groundY=-2000;
  smooth(4);
  chx=width/2;
  chy=height/2;
  e=false;
  h=false;
  endRound=false;
  ea=0;
  main=new Player(chx, chy);
}




void keyPressed() {//keys array used so player can move
  //x and y direction simultaneously


  if (keyCode==UP||key=='w') {
    keys[0]=true;
  }
  if (keyCode==DOWN||key=='s') {
    keys[1]=true;
  }
  if (keyCode==RIGHT||key=='d') {
    keys[2]=true;
  }
  if (keyCode==LEFT||key=='a') {
    keys[3]=true;
  }
}
void keyReleased() {//keys array used so player can move
  //x and y direction simultaneously


  if (keyCode==UP||key=='w') {
    keys[0]=false;
  }
  if (keyCode==DOWN||key=='s') {
    keys[1]=false;
  }
  if (keyCode==RIGHT||key=='d') {
    keys[2]=false;
  }
  if (keyCode==LEFT||key=='a') {
    keys[3]=false;
  }
}



void draw() {
  image(ground, groundX, groundY);
  if (start||instructions) {
    textSize(25);
    fill(25);
    text("Quit", 25, 575);
  }
  if (main.health==0) {
    fill(0);
    textSize(25);
    text("u ded", width/2-textWidth("ded")/2, 200);
    text("Enemies Killed:"+Integer.toString(main.kc), width/2-textWidth("Enemies Killed:"+Integer.toString(main.kc))/2, 300);
  } else if (!start&&!instructions) {//display start screen
    fill(200, 0, 0);
    textSize(75);
    text("Pew Pew,Ahhhh!", width/2-textWidth("Pew Pew,Ahhhh!")/2, 100);
    fill(255);
    text("Pew Pew,Ahhhh!", width/2-textWidth("Pew Pew,Ahhhh!")/2-5, 100-5);

    textSize(50);

    if (abs(mouseX-width/2)<textWidth("Start")/2&&abs(mouseY-height/2)<40) {
      textSize(75);
      text("Start", width/2-textWidth("Start")/2, height/2+12.5);
    } else  text("Start", width/2-textWidth("Start")/2, height/2);
    textSize(50);
    if (abs(mouseX-width/2)<textWidth("How to play")/2&&abs(mouseY-height/2-100)<40) {
      textSize(75);
      text("How to Play", width/2-textWidth("How to play")/2, height/2+100+12.5);
    } else text("How to Play", width/2-textWidth("How to play")/2, height/2+100);
  } else if (instructions) {
    fill(255);
    text("KILL THEM ALL! Use your arrow keys or asdw ", 20, 40);
    text("to move, and your mouse to shoot.", 20, 70);
    text("Your enemies will always chase you, easy", 20, 120);
    text("enough to kill but watch out, if they", 20, 150);
    text("touch each other they combine to get", 20, 180);
    text("larger and stronger, taking multiple", 20, 210);
    text("shots to destroy.", 20, 240);
    text("Good luck!", 20, 300);
    text("-Anthony", 400, 400);

  } else if (!chooseChar) {
    mc=loadImage("mainCharacter.png");


    o.display();
    o.drawBullets();
    mc=loadImage("mainCharacterG.png");
    two.display();
    two.drawBullets();
    mc=loadImage("mainCharacterB.png");

    three.display();
    three.drawBullets();
    mc=loadImage("mainCharacterP.png");

    four.display();
    four.drawBullets();
  } else if (!h&&!e) {//display easy/difficult options
    fill(255);
    textSize(50);
    text("Easy", width/4-textWidth("Start")/2, height/2);

    text("Hard", 3*width/4-textWidth("Start")/2, height/2);
  } else if (ea==0) {//checks round completion
    textSize(40);
    fill(0);
    text("Round: "+Integer.toString(round)+" complete", width/2-textWidth("Round: "+Integer.toString(round)+" complete")/2, height/2);
        textSize(30);
        text("Click Mouse to Continue", width/2-textWidth("Click Mouse to Continue")/2, height/2+100);

    main.health=main.fullHealth;
    int q = enemies.size();
    for (int i = 0; i<q; i++) {
      enemies.remove(0);
    }
    groundX=-2000;
    groundY=-2000;
  } else {//starts gameplay
    noFill();
    stroke(0);
    drawRadar();
    textSize(20);
    fill(0);
    text("Enemies Remaining: "+Integer.toString(ea), 20, 100);

    if ((main.chx>width-15&&keys[2])||(main.chx<15&&keys[3])||(main.chy>height-15&&keys[1])||(main.chy<15&&keys[0])) {
      //dont move
    } else {//move character/enemies by moving ground. Enemies moved in reverse direction to make 
      //main character appear faster

      moveCharacters();
    }
    checkCollision();
    for (int i = 0; i<enemies.size(); i++) {

      if (enemies.get(i).ex<main.chx)
        enemies.get(i).ex +=.3;
      else enemies.get(i).ex-=.3;

      if (enemies.get(i).ey<main.chy)
        enemies.get(i).ey +=.3;
      else enemies.get(i).ey-=.3;

      if (keys[0])enemies.get(i).ey-=.3;
      if (keys[1])enemies.get(i).ey+=.3;
      if (keys[2])enemies.get(i).ex-=.3;
      if (keys[3])enemies.get(i).ex+=.3;
    }

    for (int i = 0; i<enemies.size(); i++) {
      if (enemies.get(i).isAlive()) {
        enemies.get(i).display();
      }
      if (frameCount%30==0&&enemies.get(i).ex<width&&enemies.get(i).ex>0&&enemies.get(i).ey<height&&enemies.get(i).ey>0) {
        enemyPew.rewind();
        enemyPew.play();
        enemies.get(i).shootBullets();
      }

      enemies.get(i).drawBullets();
    }

    main.display();

    main.drawBullets();
  }
}//end draw



void checkCollision() {//checks collision between enemies and merges them if they hit


  for (int i=0; i<enemies.size(); i++) {
  
    for (int j = 0; j<enemies.size(); j++) {
      if (j!=i) {
        
        if (dist(enemies.get(i).ex, enemies.get(i).ey, enemies.get(j).ex, enemies.get(j).ey)<30) {

          if (enemies.get(j).s<enemies.get(i).s) {
            enemies.get(i).s+=4;
            enemies.get(i).health++;
            enemies.remove(j);
            j--;
            ea--;
          } else if (enemies.get(j).s>=enemies.get(i).s) {
            enemies.get(j).s+=4;
            enemies.get(j).health++;

            enemies.remove(i);
            ea--;
          }
        }
      }
    }
  }
}
void drawRadar() {//creates radar in bottom left corner of the screen
  ellipse(width-80, height-80, 100, 100);
  for (int i = 0; i<enemies.size(); i++) {// draws radar

    fill(#FF4848);
    stroke(#FF4848);
    if (abs(dist(enemies.get(i).ex, enemies.get(i).ey, main.chx, main.chy))>300&&enemies.get(i).isAlive()) {

      if (enemies.get(i).ex>main.chx&&enemies.get(i).ey>main.chy) {
        ellipse((50*abs(enemies.get(i).ex-main.chx)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+width-80, 
          (50*abs(enemies.get(i).ey-main.chy)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+height-80, 10, 10);
      } else if (enemies.get(i).ex<main.chx&&enemies.get(i).ey<main.chy) {
        ellipse(-(50*abs(enemies.get(i).ex-main.chx)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+width-80, 
          -(50*abs(enemies.get(i).ey-main.chy)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+height-80, 10, 10);
      } else if (enemies.get(i).ex>main.chx&&enemies.get(i).ey<main.chy) {
        ellipse((50*abs(enemies.get(i).ex-main.chx)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+width-80, 
          -(50*abs(enemies.get(i).ey-main.chy)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+height-80, 10, 10);
      } else if (enemies.get(i).ex<main.chx&&enemies.get(i).ey>main.chy) {
        ellipse(-(50*abs(enemies.get(i).ex-main.chx)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+width-80, 
          (50*abs(enemies.get(i).ey-main.chy)/abs(dist(main.chx, main.chy, enemies.get(i).ex, enemies.get(i).ey)))+height-80, 10, 10);
      }
    }
  }
}
void moveCharacters() {//actually moves background image in direction inverse of characters motion
//unless character reaches edge of map, then character is moved
  int k;
  if (maxMB)k=29;
  else k = main.numBullets;
  if (keys[0]) {
    if (groundY<0&&main.chy<=width/2) {
      groundY+=5;
      for (int j = 0; j<k; j++) {
        main.mainBullets[j][1]+=5;
        main.mainBullets[j][3]+=5;
      }
      for (int i = 0; i<enemies.size(); i++) {
        enemies.get(i).move(0, 3);

        for (int j = 0; j<enemies.get(i).numBullets; j++) {
          enemies.get(i).enemyBullets[j][1]+=5;
          enemies.get(i).enemyBullets[j][3]+=5;
        }
      }
    } else {
      main.move(0, -5);
    }
  } 
  if (keys[1]) {
    if (groundY>-4400&&main.chy>=width/2) {
      groundY-=5;
      for (int j = 0; j<k; j++) {
        main.mainBullets[j][1]-=5;
        main.mainBullets[j][3]-=5;
      }
      for (int i = 0; i<enemies.size(); i++) {
        enemies.get(i).move(0, -3);
        for (int j = 0; j<enemies.get(i).numBullets; j++) {
          enemies.get(i).enemyBullets[j][1]-=5;
          enemies.get(i).enemyBullets[j][3]-=5;
        }
      }
    } else {
      main.move(0, 5);
    }
  }
  if (keys[2]) {
    if (groundX>-4400&&main.chx>=width/2) {
      for (int j = 0; j<k; j++) {
        main.mainBullets[j][0]-=5;
        main.mainBullets[j][2]-=5;
      }
      for (int i = 0; i<enemies.size(); i++) {
        enemies.get(i).move(-3, 0);
        for (int j = 0; j<enemies.get(i).numBullets; j++) {
          enemies.get(i).enemyBullets[j][0]-=5;
          enemies.get(i).enemyBullets[j][2]-=5;
        }
      }
      groundX-=5;
    } else {
      main.move(5, 0);
    }
  }
  if (keys[3]) {
    if (groundX<0&&main.chx<=width/2) {
      for (int j = 0; j<k; j++) {
        main.mainBullets[j][0]+=5;
        main.mainBullets[j][2]+=5;
      }
      for (int i = 0; i<enemies.size(); i++) {

        enemies.get(i).move(3, 0);
        for (int j = 0; j<enemies.get(i).numBullets; j++) {
          enemies.get(i).enemyBullets[j][0]+=5;
          enemies.get(i).enemyBullets[j][2]+=5;
        }
      }
      groundX+=5;
    } else {
      main.move(-5, 0);
    }
  }
}

void mouseClicked() {
  if ((start||instructions)&&mouseX<50+textWidth("Quit")&&mouseY>550-12.5) {
    start=false;
    e=false;
    h=false;
    chooseChar=false;
    instructions=false;
    round=1;
    int q =enemies.size();
    for (int i = 0; i<q; i++) {//creates enemies
      enemies.remove(0);
    }
    ea=0;
    main.health=main.fullHealth;
  }
  if (!start&&(mouseX>width/2-textWidth("Start")/2&&mouseX<width/2+textWidth("Start")
    &&mouseY<height/2+25&&mouseY>height/2-25)) {
    start=true;
  } else if (!start&&abs(mouseX-width/2)<textWidth("How to play")/2&&abs(mouseY-height/2-100)<40) {

    instructions=true;
  } else if (!chooseChar) {
    if (mouseY<height/2+20&&mouseY>height/2-20) {
      if (mouseX>width/6-20&&mouseX<width/6+20) {
        mc=loadImage("mainCharacter.png");
        chooseChar = true;
      } else if (mouseX>2*width/6-20&&mouseX<2*width/6+20) {
        mc=loadImage("mainCharacterG.png");
        chooseChar = true;
      } else if (mouseX>4*width/6-20&&mouseX<4*width/6+20) {
        mc=loadImage("mainCharacterB.png");
        chooseChar = true;
      } else if (mouseX>5*width/6-20&&mouseX<5*width/6+20) {
        mc=loadImage("mainCharacterP.png");
        chooseChar = true;
      }
    } else {
      o.shootDouble(); 
      two.shootDouble();
      three.shootDouble();
      four.shootDouble();
    }
  } else if (start&&!e&&!h) {
    if (mouseX<width/2) {
      main.health=10;
      e=true;
      main.health=10;
      main.fullHealth=10;
      for (int i = 0; i<5; i++) {//creates enemies
        enemies.add(new Enemy((int)random(-200, 800), (int)random(-200, 800), 50));
        ea++;
      }
    } else {
      main.health=5;
      main.fullHealth=5;
      h = true;
      for (int i = 0; i<5; i++) {//creates enemies
        enemies.add(new Enemy((int)random(-200, 800), (int)random(-200, 800), 50));
        ea++;
      }
    }
  } else if (ea==0) {
    for (int i = 0; i<10+round*5; i++) {//creates enemies
      enemies.add(new Enemy((int)random(-2000, 2000), (int)random(-2000, 2000), 50));
      ea++;
    }    
    round++;
  } else {
  }
}

void mousePressed() {
  if (e||h&&main.isAlive()&&ea!=0) {
    pew.rewind();
    pew.play();
    main.shootDouble();
  }
}