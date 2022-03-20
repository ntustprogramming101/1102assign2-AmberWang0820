PImage skyImg, lifeImg, robotImg, soilImg, soldierImg, cabbageImg;
PImage groundhogImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage titleImg, gameoverImg, startNormalImg, startHoveredImg, restartNormalImg, restartHoveredImg;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

final int BUTTON_TOP = 360;//detect button's position, change picture
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

int lifeCount;
int soldierX, soldierY;//soldier's position
int soldierSize;
int soldierSpeed;
int robotX, robotY;//robot's position
int laserX1, laserX2, laserY;//laser's position, laserX1=laserX2
float laserLenght;
int laserSpeed;
int groundhogX;//groundhog's position
int groundhogY;
int groundhogSize;
int cabbageX;//cabbage's position
int cabbageY;
int cabbageSize;

void setup() {
  size(640, 480, P2D);
  frameRate (60);

  //load the pictures
  skyImg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhog.png");
  lifeImg = loadImage("img/life.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  robotImg = loadImage("img/robot.png");
  cabbageImg = loadImage("img/cabbage.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  titleImg = loadImage("img/title.jpg");
  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  gameoverImg = loadImage("img/gameover.jpg");

  //lifeCount
  lifeCount = 2;

  //soldier
  soldierX = -160;
  soldierY = 80*floor(random(2, 6));
  soldierSize = 80;
  soldierSpeed = 3;//soldier

  //robot
  robotX = 80*floor(random(2, 8));
  robotY = 80*floor(random(2, 6));

  //laser
  laserX1 = robotX+25;
  laserX2 = robotX+25;
  laserY = robotY+37;
  laserLenght=2;
  laserSpeed=2;

  //groundhog
  groundhogX=320;
  groundhogY=80;
  groundhogSize=80;

  //cabbage
  cabbageX = 80*floor(random(0, 8));
  cabbageY = 80*floor(random(2, 6));
  cabbageSize=80;
}

void draw() {
  switch(gameState) {
  case GAME_START:
    image(titleImg, 0, 0);//start picture
    //detect button position
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHoveredImg, BUTTON_LEFT, BUTTON_TOP);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    } else {
      image(startNormalImg, BUTTON_LEFT, BUTTON_TOP);
    }
    break;

  case GAME_RUN:
    //background
    image(skyImg, 0, 0);//sky
    fill(253, 184, 19);//sun
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(590, 50, 120, 120);
    image(soilImg, 0, 160);//soil
    strokeWeight(15);//grass
    stroke(24, 204, 25);
    line(0, 152.5, 640, 152.5);

    //lifeHeart (size: 50*43) game change
    if (lifeCount == 0) {
      gameState = GAME_OVER;
    }
    if (lifeCount == 1) {
      image(lifeImg, 10, 10);
    }
    if (lifeCount == 2) {
      image(lifeImg, 10, 10);
      image(lifeImg, 80, 10);
    }
    if (lifeCount == 3) {
      image(lifeImg, 10, 10);
      image(lifeImg, 80, 10);
      image(lifeImg, 150, 10);
    }


    //check area
    strokeWeight(1);
    stroke(0, 255, 0);
    line(80, 160, 80, width);
    line(160, 160, 160, width);
    line(240, 160, 240, width);
    line(320, 160, 320, width);
    line(400, 160, 400, width);
    line(480, 160, 480, height);
    line(560, 160, 560, height);
    line(640, 160, 640, height);

    line(0, 160, 640, 160);
    line(0, 240, 640, 240);
    line(0, 320, 640, 320);
    line(0, 400, 640, 400);

    //cabbage
    if (groundhogX < cabbageX+cabbageSize &&
      groundhogX+groundhogSize > cabbageX &&
      groundhogY < cabbageY+cabbageSize &&
      groundhogY+groundhogSize > cabbageY)
    {
      lifeCount+=1;
      cabbageX=-80;//let cabbage out of the screen
      cabbageY=-80;
    }
    image(cabbageImg, cabbageX, cabbageY);

    //characters

    //Draw groundhog
    if (groundhogX < soldierX+soldierSize &&
      groundhogX+groundhogSize > soldierX &&
      groundhogY < soldierY+soldierSize &&
      groundhogY+groundhogSize > soldierY)
    {
      lifeCount-=1;
      groundhogX=320;
      groundhogY=80;
    }
    image(groundhogImg, groundhogX, groundhogY);

    //Draw soldier
    image(soldierImg, soldierX, soldierY);
    soldierX += soldierSpeed;//soldier Walking Speed
    if (soldierX > 640) {
      soldierX = -80;
      soldierX += soldierSpeed;
    };

    /*//Draw robot
     image(robotImg,robotX,robotY);
     
     //Draw laser
     strokeWeight(10);
     stroke(255,0,0);
     line(laserX2,laserY,(laserX1-=laserSpeed) -laserLenght++,laserY);
     if(laserLenght++ > 20){
     laserX2-=laserSpeed;
     laserLenght=20;
     }
     if(robotX-140 >= laserX1){
     laserLenght=0;//let laser from short to long
     laserX1=robotX+25;
     laserX2=robotX+25;
     }*/
    break;

  case GAME_OVER:
    image(gameoverImg, 0, 0);//gameover picture
    //detect button position
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(restartHoveredImg, BUTTON_LEFT, BUTTON_TOP);
      if (mousePressed) {
        gameState = GAME_RUN;
        lifeCount = 2;
        groundhogX=320;
        groundhogY=80;
        soldierY = 80*floor(random(2, 6));
        cabbageX = 80*floor(random(0, 8));
        cabbageY = 80*floor(random(2, 6));
      }
    } else {
      image(restartNormalImg, BUTTON_LEFT, BUTTON_TOP);
    }
    break;
  }
}

void keyPressed() {
  switch (keyCode) {
  case DOWN: //CODE 40
    groundhogY += 80;
    image(groundhogDownImg, groundhogX, groundhogY);
    break;
  case LEFT: //CODE 37
    groundhogX -= 80;
    image(groundhogLeftImg, groundhogX, groundhogY);
    break;
  case RIGHT: //CODE 39
    groundhogX += 80;
    image(groundhogRightImg, groundhogX, groundhogY);
    break;
  }
  //groundhog boundary detection
  if (groundhogX > width-groundhogSize) {
    groundhogX = width-groundhogSize;
  }
  if (groundhogX < 0) {
    groundhogX = 0;
  }
  if (groundhogY > height-groundhogSize) {
    groundhogY = height-groundhogSize;
  }
  if (groundhogY < 80) {
    groundhogY = 80;
  }
}

void keyReleased() {
}
