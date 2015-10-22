PImage bg1;
PImage bg2;
PImage enemy;
PImage fighter;
PImage hp;
PImage treasure;
PImage end1,end2,start1,start2;
int bg1X,bg2X;
int hpX;
int treasureX,treasureY;
int enemyX,enemyY;
int fighterX,fighterY;

final int GAME_START=1,GAME_RUN=2,GAME_LOSE=3;
int gameState;


boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
int fighterSpeed=5;


void setup () {
  size(640,480) ;  // must use this size.
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  enemy=loadImage("img/enemy.png");
  fighter=loadImage("img/fighter.png");
  hp=loadImage("img/hp.png");
  treasure=loadImage("img/treasure.png");
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  
  bg1X=640;
  bg2X=0;
  
  hpX=40;
  
  treasureX=floor(random(0,470));
  treasureY=floor(random(60,420));
  
  enemyX=0;
  enemyY=floor(random(50,420));
  
  fighterX=550;
  fighterY=240;
  
  gameState = GAME_START;

  
}

void draw() {
  //background
  image(bg1,bg1X-640,0);
  image(bg2,bg2X-640,0);
  bg1X++;
  bg2X++;
  bg1X%=1280;
  bg2X%=1280;


  //fighter
  image(fighter,fighterX,fighterY);
  
  //hp
  fill(255,0,0);
  noStroke();
  rect(20,13,hpX,20,10);
  image(hp,10,10);
  
  
  switch(gameState){
    case GAME_START:
      image(start2,0,0);
      if(mouseX>200 && mouseX<460 && mouseY>375 && mouseY<415)
        if(mousePressed){
          gameState = GAME_RUN;
        }else{
          image(start1,0,0);
        }
 
    break;
    case GAME_RUN:
       //enemy
      image(enemy,enemyX,enemyY);
      enemyX += 4;
      if(enemyX>width){
        enemyX=0;
        enemyY=floor(random(50,420));
      }
      //enemy chase
      if(enemyY < fighterY){
        enemyY+=2;
      }
      if(enemyY> fighterY){
        enemyY-=2;
      }

      
      //enemy hit
      if(fighterX <= enemyX+40 && fighterX>=enemyX-40 && fighterY <= enemyY+50 && fighterY>= enemyY-50){
        hpX -= 40;
        enemyX=0;
        enemyY=floor(random(50,420));
      }
      if(hpX<=20){
        gameState = GAME_LOSE;
      }
      
    //treasure hit
    image(treasure,treasureX,treasureY);
     if(fighterX <= treasureX+40 && fighterX>=treasureX-40 && fighterY <= treasureY+40 && fighterY>= treasureY-40){
          hpX += 20;
      treasureX=floor(random(0,470));
      treasureY=floor(random(60,420));
     }
      
      //hp boundary
      if(hpX > 200){
        hpX = 200;  
      }
      break;
   case GAME_LOSE:
     image(end2,0,0);
     if(mouseX>200 && mouseX<440 && mouseY>300 && mouseY<350)
      if(mousePressed){
        gameState = GAME_RUN;
        hpX=40;
        fighterX=550;
        fighterY=240;
        treasureX=floor(random(0,470));
        treasureY=floor(random(60,420));
  
        enemyX=0;
        enemyY=floor(random(50,420));
      }else{
        image(end1,0,0);
      }
   break;
  
  } 
  
  //move
  if(upPressed){
    fighterY -= fighterSpeed;
  }
  if(downPressed){
    fighterY += fighterSpeed;
  }
  if(leftPressed){
    fighterX -= fighterSpeed;
  }
  if(rightPressed){
    fighterX += fighterSpeed;
  }
  
  //boundary
  if(fighterX<0){
    fighterX=0;
  }
  if(fighterX>590){
    fighterX=590;
  }
  if(fighterY<0){
    fighterY=0;
  }
  if(fighterY>430){
    fighterY=430;
  }
  
}
void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
