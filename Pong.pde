//Note:Please install PressStart2P.ttf in the file for the 8 bit font

int fps;//fps value
PImage cursor;//custom cursor image
int screenMode;//screen modes for the game
float soloBallDirection;//to decide where the ball is going at the start of the game (Practice)
float duoBallDirection;//to decide where the ball is going at the start of the game (1v1)
boolean ballActivate;//boolean for activating movement of the ball
float ballSpeed;//Default speed of the ball
boolean leftWall;//To make the ball bounce off the right/left wall
boolean topWall, bottomWall;//To make the ball bounce off the top/bottom wall
boolean leftSideRacket, rightSideRacket;//To make the ball bounce off the right/left racket
int rightSideRacketY;//Default Y position of the right side racket
int leftSideRacketY;//Default X position of the right side racket
int ballX, ballY;//Position of the ballket
int rightSideRacketBottom;//Bottom of the rigth side racket
int leftSideRacketBottom;//Bottom of the left side racket
boolean[] racketKeys;//boolean for keyPressed cases
PFont pixelFont;//Press Start 2P
int leftScore;//left side player score
int rightScore;//right side player score
int counterMillis = 0;//Milliseconds for the countdown timer
int counterSeconds = 3;//Seconds for the countdown timer
int gameOverMode;//screen mode when games over for different cases

void setup() {//set up
  fullScreen();//makes the program full screen sized.
  fps = 60;
  cursor = loadImage("rainbowcursor.png");//custom cursor image
  cursor(cursor);//Cross cursor
  frameRate(fps);//FPS
  smooth(2);//Smoothening the motion
  screenMode = 1;//program starts with lobby screen
  ballActivate = false;//ball doesn't move until it's true
  leftWall = false;
  topWall = false;
  bottomWall = false;
  leftSideRacket = false;
  rightSideRacket = false;
  ballSpeed = 5;//default ball speed
  ballX = 960;//Ball spawn location (x)
  ballY = 540;//Ball spawn location (y)
  rightSideRacketY = 1080 / 2 - 90;
  leftSideRacketY = 1080 / 2 - 90;
  racketKeys=new boolean[4];//boolean for controlling rackets
  racketKeys[0]=false;//Up key
  racketKeys[1]=false;//Down key
  racketKeys[2]=false;//W key
  racketKeys[3]=false;//S key
  leftScore = 0;
  rightScore = 0;
  counterMillis = 0;
  counterSeconds = 3;
  gameOverMode = 0;
}

void draw() {//draw
  
  //Lobby screen
  if (screenMode == 1){
    
    lobby();//function for the lobby
    
  }
  
  //1 player mode (Practice mode)
  else if (screenMode == 2){
    
    practiceMode();//function for practice mode
    
  }
  
  //2 player mode (1v1)
  else if (screenMode == 3){
    
    oneVOneMode();//function for 1v1 mode
    
  }
  
  //Game over
  else if (screenMode == 4){
    
    gameOver();//function for game mover screen
    
  }
}

void keyPressed() {//Key Pressed function
  if (keyCode == UP) {//When user press Up
    
    racketKeys[0]=true;
    
  } if (keyCode == DOWN) {//When user press Down
    
    racketKeys[1]=true;
    
  } if (key == 'W' || key == 'w') {//When user press w
    
    racketKeys[2]=true;
    
  } if (key == 'S' || key == 's') {//When user press s
    
    racketKeys[3]=true;
    
  }
}

void keyReleased() {//Key Released function
  if (keyCode == UP) {//When user release Up
    
    racketKeys[0]=false;
    
  } if (keyCode == DOWN) {//When user release Up
    
    racketKeys[1]=false;
    
  } if (key == 'W' || key == 'w') {//When user release Up
    
    racketKeys[2]=false;
    
  } if (key == 'S' || key == 's') {//When user release Up
    
    racketKeys[3]=false;
    
  }
  
}

void lobby() {
  
  background(#000000);//black background
  //PONG
  pixelFont = createFont("Press Start 2P", 200);
  fill(#39FF14);
  textFont(pixelFont);
  textAlign(CENTER, CENTER);
  text("PONG", 960, 400);//title
  
  //Button 1(practice)
  fill(#39FF14);
  rect(400, 600, 500, 300, 7);//Button for practice mode
  fill(#000000);
  pixelFont = createFont("Press Start 2P", 30);
  textFont(pixelFont);
  textAlign(CENTER, CENTER);
  text("Practice Mode", 650, 750);
  //button 2(1v1)
  fill(#39FF14);
  rect(1020, 600, 500, 300, 7);//Button for 1v1 mode
  fill(#000000);
  pixelFont = createFont("Press Start 2P", 30);
  textFont(pixelFont);
  textAlign(CENTER, CENTER);
  text("1v1 Mode", 1270, 750);
    
  if (mousePressed) {//Mouse pressed
      
    if (mouseX > 400 && mouseX < 400 + 500 && mouseY > 600 && mouseY < 600 + 300) {//When user clicks the left button(practice mode)
      screenMode += 1;//loads up the practice mode
    } else if (mouseX > 1020 && mouseX < 1020 + 500 && mouseY > 600 && mouseY < 600 + 300) {//When user clicks the right button(1v1)
      screenMode += 2;//loads up the 1v1 mode
    }
      
  }
 
}

void practiceMode() {
  
  background(#000000);//black background
  fill(#39FF14);//line colour
  rect(width / 2 - 8, 0, 16, 1080);//the centre line
  fill(#39FF14);//ball colour
  ellipse(ballX, ballY, 30, 30);//the ball
  fill(#39FF14);//left side wall colour
  rect(0, 0, 16, 1080);//left side wall
  fill(#39FF14);//right side racket colour
  rect(1904, rightSideRacketY, 16, 180);//right side racket
  noCursor();//removes cursor
  
  rightSideRacketBottom = rightSideRacketY + 180;//The value of the right side racket bottom
  startCountDown();//countdown before the game starts
  
  if (ballActivate == true) {
    
    if (soloBallDirection >= 0 && soloBallDirection <= 1) {//When random number generator generates 0~1, ball goes up and to the right side at the start of the game
      
      leftWall = true;
      topWall = true;
      soloBallDirection+=4;//cancel out the random after it's called
      
    } else if (soloBallDirection >= 1.0001 && soloBallDirection <= 2) {//When random number generator generates 1.0001~2, ball goes down and to the right side at the start of the game
      
      leftWall = true;
      bottomWall = true;
      soloBallDirection+=4;//cancel out the random after it's called
      
    }
    
    if (ballX + 15 >= 1904 && (rightSideRacketY <= ballY && ballY <= rightSideRacketBottom)) {//The ball moves right until it bounces off the right racket
      rightSideRacket = true;
      leftWall = false;
      ballSpeed = ballSpeed + (ballSpeed * 0.05);//ball speed increases 
    }
     
    else if (ballX >= 1910) {//When user fails to bounce off the ball
      screenMode+=2;//game over screen
    }
     
    if (ballX - 15 <= 16) {//The ball moves left until it bounces off the left wall
      leftWall = true;
      rightSideRacket = false;
      ballSpeed = ballSpeed + (ballSpeed * 0.05);//ball speed increases 
    }
  
    if (rightSideRacket == true) {//To make the ball bounce off the right racket
     ballX-=ballSpeed;
    }
  
    if (leftWall == true) {//To make the ball bounce off the left wall
      ballX+=ballSpeed;
    }
  
    if (ballY + 15 >= height) {//The ball moves down until it bounces off the top wall
      bottomWall = true;
      topWall = false;
    }
   
    if (ballY - 15 <= 0) {//The ball moves down until it bounces off the bottom wall
      topWall = true;
      bottomWall = false;
    }
  
    if (bottomWall == true) {//To make the ball bounce off the bottom wall
      ballY-=ballSpeed;
    }
  
    if (topWall == true) {//To make the ball bounce off the top wall
      ballY+=ballSpeed;
    }
    
    //Racket Control (Key pressed)
    if (racketKeys[0] && rightSideRacketY >= 10) {//When user press Up, the right racket goes up
    
      rightSideRacketY -= 10;
      
    } if (racketKeys[1] && rightSideRacketY <= height - 190) {//When user press Down, the right racket goes down
        
      rightSideRacketY += 10;
        
    }
     
  }
  
}

void oneVOneMode() {
  
  background(#000000);//black background
  fill(#39FF14);//line colour
  rect(width / 2 - 8, 0, 16, 1080);//the centre line
  fill(#39FF14);//ball colour
  ellipse(ballX, ballY, 30, 30);//the ball
  fill(#39FF14);//left side racket colour
  rect(0, leftSideRacketY, 16, 180);//left side racket
  fill(#39FF14);//right side racket colour
  rect(1904, rightSideRacketY, 16, 180);//right side racket
  noCursor();//removes cursor
  
  pixelFont = createFont("Press Start 2P", 60);
  textFont(pixelFont);
  textAlign(CENTER, CENTER);
  
  //left side score
  text(leftScore, width / 2 - 100, 100);
  
  //right side score
  text(rightScore, width / 2 + 100, 100);
  
  rightSideRacketBottom = rightSideRacketY + 180;//The value of the right side racket bottom
  leftSideRacketBottom = leftSideRacketY + 180;//The value of the left side racket bottom
 
  startCountDown();
  
  if (ballActivate == true) {
    
    if (duoBallDirection >= 0 && duoBallDirection <= 1) {//When random number generator generates 0~1, ball goes up and to the right side at the start of the game
      
      rightSideRacket = true;
      topWall = true;
      duoBallDirection+=4;//cancel out the random after it's called
      
    } else if (duoBallDirection >= 1.0001 && duoBallDirection <= 2) {//When random number generator generates 1.0001~2, ball goes down and to the right side at the start of the game
      
      rightSideRacket = true;
      bottomWall = true;
      duoBallDirection+=4;//cancel out the random after it's called
      
    } else if (duoBallDirection >= 2.0001 && duoBallDirection <= 3) {//When random number generator generates 2.0001~3, ball goes up and to the left side at the start of the game
      
      leftSideRacket = true;
      topWall = true;
      duoBallDirection+=4;//cancel out the random after it's called
      
    } else if (duoBallDirection >= 3.0001 && duoBallDirection <= 4) {//When random number generator generates 3.0001~4, ball goes down and to the left side at the start of the game
      
      leftSideRacket = true;
      bottomWall = true;
      duoBallDirection+=4;//cancel out the random after it's called
      
    }
    
    if (ballX + 15 >= 1904 && (rightSideRacketY <= ballY && ballY <= rightSideRacketBottom)) {//The ball moves right until it bounces off the right racket
      rightSideRacket = true;
      leftSideRacket = false;
      ballSpeed = ballSpeed + (ballSpeed * 0.05);//ball speed increases 
    }
     
    else if (ballX >= 1910) {//When the left side scores
  
    leftScore++;
    ballActivate = false;
    counterSeconds = 3;//resetting timer
    //reset ball and bracket location value and starts the countdown for the next round
    resetValue();
    startCountDown();
  
      if (leftScore == 7) {//when left side wins (scores 7)
        screenMode+=1;
        gameOverMode+=1;
      }
     
    }
     
    if (ballX - 15 <= 16 && (leftSideRacketY <= ballY && ballY <= leftSideRacketBottom)) {//The ball moves left until it bounces off the left racket
      leftSideRacket = true;
      rightSideRacket = false;
      ballSpeed = ballSpeed + (ballSpeed * 0.05);//ball speed increases 
    }
    
    else if (ballX <= 10) {//When the right side scores
  
    rightScore++;
    ballActivate = false;
    counterSeconds = 3;//resetting timer
    //reset ball and bracket location value and starts the countdown for the next round
    resetValue();
    startCountDown();
  
      if (rightScore == 7) {//when right side wins (scores 7)
        screenMode+=1;
        gameOverMode+=2;
      }
  
    }
  
    if (rightSideRacket == true) {//To make the ball bounce off the right racket
      ballX-=ballSpeed;
    }
  
    if (leftSideRacket == true) {//To make the ball bounce off the left racket
      ballX+=ballSpeed;
    }
  
    if (ballY + 15 >= height) {//The ball moves down until it bounces off the top wall
      bottomWall = true;
      topWall = false;
    }
    
    if (ballY - 15 <= 0) {//The ball moves down until it bounces off the bottom wall
      topWall = true;
      bottomWall = false;
    }
  
    if (bottomWall == true) {//To make the ball bounce off the bottom wall
      ballY-=ballSpeed;
    }
  
    if (topWall == true) {//To make the ball bounce off the top wall
      ballY+=ballSpeed;
    }
    
    //Racket Control 
    if (racketKeys[0] && rightSideRacketY >= 10) {//When user press Up, the right racket goes up
    
      rightSideRacketY -= 10;
      
    } if (racketKeys[1] && rightSideRacketY <= height - 190) {//When user press Down, the right racket goes down
        
      rightSideRacketY += 10;
        
    } if (racketKeys[2] && leftSideRacketY >= 10) {//When user press w, the left racket goes up
     
      leftSideRacketY -= 10;
          
    } if (racketKeys[3] && leftSideRacketY <= height - 190) {//When user press s, the left racket goes down
        
      leftSideRacketY += 10;
        
    } if (racketKeys[0] && racketKeys[2] && rightSideRacketY >= 10 && leftSideRacketY >= 10) {//When up and w pressed at the same time
        //rightSideRacketY -= 10;
        //leftSideRacketY -= 10;
    } if (racketKeys[0] && racketKeys[3] && rightSideRacketY >= 10 && leftSideRacketY <= height - 190) {//When up and s pressed at the same time
        //rightSideRacketY -= 10;
        //leftSideRacketY += 10;
    } if (racketKeys[1] && racketKeys[2] &&rightSideRacketY <= height - 190 && leftSideRacketY >= 10) {//When down and w pressed at the same time
        //rightSideRacketY += 10;
        //leftSideRacketY -= 10;
    } if (racketKeys[1] && racketKeys[3] && rightSideRacketY <= height - 190 && leftSideRacketY <= height - 190) {//When down and s pressed at the same time
        //rightSideRacketY += 10;
        //leftSideRacketY += 10;
    }
    
  }
    
}

void gameOver() {
  
  background(#000000);//black background
  pixelFont = createFont("Press Start 2P", 200);
  textFont(pixelFont);
  textAlign(CENTER, CENTER);
  text("GAME OVER", 960, 400);
  fill(#FF2D00);
  textSize(32);
  noCursor();//removes cursor
    
  if (gameOverMode == 1) {//when player 2 wins in 1v1 mode
      
    fill(#FFFF00);
    textAlign(CENTER, CENTER);
    text("Player 1 won!", 960, 700);
      
  } else if (gameOverMode == 2) {//when player 2 wins in 1v1 mode
      
    fill(#FFFF00);
    textAlign(CENTER, CENTER);
    text("Player 2 won!", 960, 700);
      
  }
    
  fill(#FF2D00);
  textAlign(CENTER, CENTER);
  text("Press space to restart.", 960, 900);
   
  if (keyPressed) {
    if (key == 32) {//space
      setup();
    }
  }
    
}

void resetValue() {//resets all the values that are changed during the game when the game starts
  
  ballSpeed = 5;
  ballX = 960;
  ballY = 540;
  rightSideRacketY = 1080 / 2 - 90;
  leftSideRacketY = 1080 / 2 - 90;
  topWall = false;
  leftSideRacket = false;
  rightSideRacket = false;
  bottomWall = false;
  
}
  
void startCountDown() {//3 seconds of countdown before the game starts
  
  if (counterSeconds > 0) {//when countdown second is more than 0 (1-3)
    //displaying countdown second
    fill(#FFFFFF);
    pixelFont = createFont("Press Start 2P", 200);
    textFont(pixelFont);
    textAlign(CENTER, CENTER);
    text(counterSeconds, width / 2, 400);
    
    if (counterMillis >= fps) {//milliseconds to decrease second
      counterMillis = 0;
      counterSeconds--;
    }
    counterMillis++;//increasing milliseconds for 60 times (FPS) in 1 second
     
    if (counterSeconds == 0 && screenMode == 2){//if the game mode is practice mode
  
      ballActivate = true;//activates ballActive so it starts moving
      soloBallDirection = random(2);
    
    }else if(counterSeconds == 0 && screenMode == 3){//if the game mode is 1v1 mode
  
      ballActivate = true;//activates ballActive so it starts moving
      duoBallDirection = random(4);
    
    }
  }
}