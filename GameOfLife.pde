//there's two draws, be careful lol

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  buttons = new Life[NUM_ROWS][NUM_COLS];
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buttons[r][c] = new Life(r,c);
    }
  }
  buffer = new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
      buttons[r][c] = new Life(r,c);
    } //makes it go crazy
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
}

public void copyFromBufferToButtons() {
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c].setLife(buffer[r][c]);
    }
  }
}

public void copyFromButtonsToBuffer() {
  for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c < NUM_COLS; c++){
    }
  }
}

public boolean isValid(int r, int c) {
  if(r >= 0 && c >= 0){
    if(r < NUM_ROWS && c < NUM_COLS){
      return true;
    }
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  for(int r = row-1; r <= row+1; r++){ //start at row to the left 
   for(int c = col-1; c <= col+1; c++){ //end to the row of right
        if(isValid(r,c) == true && buttons[r-1][c].getLife() == true){ //same applies to col
          neighbors = neighbors + 1;//start from top to bottom
        }
     }
  }
  if(buttons[row][col].getLife() == true){ //same applies to col
    neighbors = neighbors - 1;//start from top to bottom
  } 
 return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
     width = 400/NUM_COLS;
     height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    return alive;
    //return false;
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
