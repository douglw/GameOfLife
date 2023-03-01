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
  buffer = new boolean[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new Life(r, c);
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if(countNeighbors(r,c) == 3){
        buffer[r][c] = true;
      }
      if(countNeighbors(r,c) == 2 && buttons[r][c].alive == true){
        buffer[r][c] = true;
      }
      else{
        buffer[r][c] = false;
      }
      buttons[r][c] = new Life(r, c);
    } //makes it go crazy
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
   if (running == false) {
    running = true;
  } else {
    running = false;
  }
}

public void copyFromBufferToButtons() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if(buffer[r][c] == true){
        buttons[r][c].alive = true;
      }
      else{
        buttons[r][c].alive = false;
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if(buttons[r][c].alive == true){
        buffer[r][c] = true;
      }
      else{
        buffer[r][c] = false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  if (r >= 0 && c >= 0) {
    if (r < NUM_ROWS && c < NUM_COLS) {
      return true;
    }
  }
  return false;
}

public int countNeighbors(int row, int col) {
  int neighbors = 0; 
  //for (int r = row-1; r <= row+1; r++) { //start at row to the left 
  //  for (int c = col-1; c <= col+1; c++) { //end to the row of right
  //    if (isValid(r, c) == true && buttons[r-1][c].getLife() == true) { //same applies to col
  //      neighbors = neighbors + 1; //start from top to bottom
  //    }
  //  }
  //}
  //if (buttons[row][col].getLife() == true) { //same applies to col
  //  neighbors = neighbors - 1; //start from top to bottom
  //} 
  if(isValid(row-1,col-1) && buttons[row-1][col-1].getLife() ==true)
    neighbors++;
  if(isValid(row-1,col) && buttons[row-1][col].getLife()==true)
    neighbors++;
  if(isValid(row-1,col+1) && buttons[row-1][col+1].getLife()==true)
    neighbors++;
  if(isValid(row,col-1) && buttons[row][col-1].getLife()==true)
    neighbors++;
  if(isValid(row,col+1) && buttons[row][col+1].getLife()==true)
    neighbors++;
  if(isValid(row+1,col-1) && buttons[row+1][col-1].getLife()==true)
    neighbors++;
  if(isValid(row+1,col) && buttons[row+1][col].getLife()==true)
    neighbors++;
  if(isValid(row+1,col+1) && buttons[row+1][col+1].getLife()==true)
    neighbors++;
  return neighbors;
}
// nothing to add here
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
  }
  public void setLife(boolean living) {
    alive = living;
  }
}
