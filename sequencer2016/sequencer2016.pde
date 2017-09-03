import controlP5.*;
import g4p_controls.*;
import processing.sound.*;



ControlP5 cp5;
ControlP5 knobs;
// define global variables
SoundFile f1;
SoundFile f2;
SoundFile f3;
SoundFile f4;
SoundFile f5;
SoundFile f6;
SoundFile f7;
SoundFile f8;

Knob master;
Knob vol1;
Knob vol2;
Knob vol3;
Knob vol4;
Knob vol5;
Knob vol6;
Knob vol7;
Knob vol8;

int MasterVol;
float Sample1;
float Sample2;
float Sample3;
float Sample4;
float Sample5;
float Sample6;
float Sample7;
float Sample8;
int knobValue = 100;
String sample1;
String sample2;
String sample3;
String sample4;
String sample5;
String sample6;
String sample7;
String sample8;
int MyDispX = 830; // set the size of our display window
int MyDispY = 450;
int startX = 20;
int startY = 20;
int curX = startX;
int curY = startY; 
float bpmLocX = MyDispX/10 * 7;
float bpmLocY = MyDispY/10 * 8.5;
int curPos = 0;
int bg = 255;
int myBPM = 120; // beats per minute
int tempo = 1000 * 60/myBPM;
int mytime = 0;
GTimer GT1; // we get the GTimer from the G4P library
boolean rectOver[] = new boolean[129]; // apparently, with my indexing of the array, I needed one more cell to prevent crashing
int rectX[] = new int[128]; //arays for rectangle postions
int rectY[] = new int[128];
int rectSpacing = 40; // distance between rectangles
int rectSize = 25;     // size of rect
color rectColor; // ordinary rectangle colour
color rectHighlight; // highlight colour
color playHead;
color playHighlight;
//color currentColor; // current colour, whatever that may be
int btnID = -1; // keep track of what button we're over
boolean playing = false;
PImage image;


// in Processing 3, some system definitions can only be changed, using variables, in a settings function
void settings()
{
  size(MyDispX, MyDispY);
}

// teh setup function, runs once when the program starts
void setup() {
  int i,j;
  background(0);
  image = loadImage("Metal.jpg");
  frameRate(30);  
  // Load a soundfile from the /data folder of the sketch and play it back
  f1 = new SoundFile(this, "kick.wav");
  f2 = new SoundFile(this, "hat.wav");
  f3 = new SoundFile(this, "snare.wav");
  f4 = new SoundFile(this, "floortom.wav");
  f5 = new SoundFile(this, "racktom.wav");
  f6 = new SoundFile(this, "splash.wav");
  f7 = new SoundFile(this, "crash.wav");
  f8 = new SoundFile(this, "cowbell.wav");
  sample1 = ("Kick");
  sample2 = ("Hat");
  sample3 = ("Snare");
  sample4 = ("Tom 1");
  sample5 = ("Tom 2");
  sample6 = ("Splash");
  sample7 = ("Crash");
  sample8 = ("Cowbell");
  
  GT1 = new GTimer(this, this, "showtime", tempo);
  // GT1.start(); // commented out, as we're starting and stopping with space bar now.
  rectColor = #00004D;
  rectHighlight = #CC00FF;
  playHead = #FF6600 ;
  playHighlight = #CC00FF ;
  textFont(createFont("Georgia", 24));
  
  cp5 = new ControlP5(this);
  DropdownList droplist = cp5.addDropdownList("Samples").setPosition(width/5 * 4, height/10 * 8.5);
  
  droplist.addItem("Rock", 1);
  droplist.addItem("Techno", 2);
  
  {

       master = cp5.addKnob("MasterVol")
                 .setRange(2,102)
                 .setValue(50)
                 .setPosition(width/20, height/20 * 16)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(4)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(40)
                 .setDragDirection(Knob.VERTICAL)
                 ;
       vol1 = cp5.addKnob("Sample1")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
        vol2 = cp5.addKnob("Sample2")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 2 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
         vol3 = cp5.addKnob("Sample3")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 3 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
         vol4 = cp5.addKnob("Sample4")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 4 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
         vol5 = cp5.addKnob("Sample5")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 5 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
         vol6 = cp5.addKnob("Sample6")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 6 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
         vol7 = cp5.addKnob("Sample7")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 7 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
         vol8 = cp5.addKnob("Sample8")
                 .setRange(0.01,0.99)
                 .setValue(0.5)
                 .setPosition(width/10 * 8, 8 * rectSpacing - 20)
                 .setNumberOfTickMarks(20)
                 .setTickMarkLength(2)
                 .setColorForeground(color(255))
                 .setColorBackground(color(#FF6600))
                 .setRadius(10)
                 .setDragDirection(Knob.VERTICAL)
                 ;
  }
   
   
    for(i=0;i<128;i++)
  {
    rectOver[i] = false;
  }
  // calculate all rectangle coordinates
  for(i=0;i<8;i++) // rows
  {
    for(j=0;j<16;j++) // columns
    {
      rectX[(i*16) + j] = curX;
      rectY[(i*16) + j] = curY;
      curX += rectSpacing;
      // check if we've filled one row
      if(j == 15)
      {
        curX = startX;
      }
    }
    curY += rectSpacing;
  }  
} 

void controlEvent(ControlEvent theEvent) {
  if (0 == theEvent.getController().getValue()) {
    f1 = new SoundFile(this, "kick.wav");
    f2 = new SoundFile(this, "hat.wav");
    f3 = new SoundFile(this, "snare.wav");
    f4 = new SoundFile(this, "floortom.wav");
    f5 = new SoundFile(this, "racktom.wav");
    f6 = new SoundFile(this, "splash.wav");
    f7 = new SoundFile(this, "crash.wav");
    f8 = new SoundFile(this, "cowbell.wav");
    sample1 = ("Kick");
    sample2 = ("Hat");
    sample3 = ("Snare");
    sample4 = ("Tom 1");
    sample5 = ("Tom 2");
    sample6 = ("Splash");
    sample7 = ("Crash");
    sample8 = ("Cowbell");
  }
  if (1 == theEvent.getController().getValue()) {
    f1 = new SoundFile(this, "TechnoKick.wav");
    f2 = new SoundFile(this, "TechnoHat.mp3");
    f3 = new SoundFile(this, "TechnoClap.wav");
    f4 = new SoundFile(this, "TechnoTom.wav");
    f5 = new SoundFile(this, "boop.wav");
    f6 = new SoundFile(this, "splash.wav");
    f7 = new SoundFile(this, "ready.wav");
    f8 = new SoundFile(this, "scratch.wav");
    sample1 = ("Kick");
    sample2 = ("Hat");
    sample3 = ("Clap");
    sample4 = ("Bop");
    sample5 = ("Boop");
    sample6 = ("Splash");
    sample7 = ("Ready");
    sample8 = ("Scratch");
  }
}


// the main draw function. This is the function called for every frame refresh
void draw() 
{
  update(mouseX, mouseY);  
  background(#33CCFF);
  image(image, 0, 0, width, height);
  playCursor();
  drawSquares();
  showbpm(myBPM);
}

// everything below this point are functions that make up the rest of te functionality

// a cursor that indicates where we are on screen and in the sequence
void playCursor()
{
  stroke(#993D00);
  strokeWeight(4);
  line(curPos, 10, curPos, rectSpacing * 8.5);
}

// check if the cursor is over a particuar area
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

// update what button we're over
void update(int x, int y) 
{
  int i,j;
  for(i=0;i<8;i++)
  {
    for(j=0;j<16;j++)
    {
      if ( overRect(rectX[(i*16) + j], rectY[(i*16) + j], rectSize, rectSize) ) 
      {
        btnID = (i*16) + j;
      }
    }
  }
  if(mouseX > rectSpacing * 16 || mouseX < rectSpacing/2 || mouseY > rectSpacing * 8 || mouseY < rectSpacing/2)
  {
   btnID = -1; 
  }
}

// pick the notes that are active for the beat we're on
void soundstep(int n)
{
  if(rectOver[n] == true)
  {
    f1.play();
    f1.amp((MasterVol - 2) * (Sample1 - 0.01));
  }
  if(rectOver[n+16] == true)
  {
    f2.play();
    f2.amp((MasterVol - 2) * (Sample2 - 0.01));
  }
  if(rectOver[n+32] == true)
  {
    f3.play();
    f3.amp((MasterVol - 2) * (Sample3 - 0.01));
  }
  if(rectOver[n+48] == true)
  {
    f4.play();
    f4.amp((MasterVol - 2) * (Sample4 - 0.01));
  }
  if(rectOver[n+64] == true)
  {
    f5.play();
    f5.amp((MasterVol - 2) * (Sample5 - 0.01));
  }
  if(rectOver[n+80] == true)
  {
    f6.play();
    f6.amp((MasterVol - 2) * (Sample6 - 0.01));
  }
  if(rectOver[n+96] == true)
  {
    f7.play();
    f7.amp((MasterVol - 2) * (Sample7 - 0.01));
  }
  if(rectOver[n+112] == true)
  {
    f8.play();
    f8.amp((MasterVol - 2) * (Sample8 - 0.01));
  }
}
// handle mouse clicks
void mouseClicked() 
{
  //println(btnID);
  if(btnID != -1)
  {
    if(rectOver[btnID] == false)
    {
      rectOver[btnID] = true;
      //print("Button: ");
      //println(btnID);
    }
    else
    {
      rectOver[btnID] = false;
    }
  }
  if(mouseX > width/10 * 2.5 && mouseX < width/10 * 2.5 + width/20 && mouseY > height/10 * 8.3 && mouseY < height/10 * 8.3 + width/20)
  {
    fill(rectHighlight);
    stroke(rectColor);
    rect(width/10 * 2.5, height/10 * 8.3, width/20, width/20);
    GT1.stop();
    mytime = 0;
    curPos = mytime;
  }
  if(mouseX > width/10 * 4.5 && mouseX < width/10 * 4.5 + width/20 && mouseY > height/10 * 8.3 && mouseY < height/10 * 8.3 + width/20)
  {
    fill(rectHighlight);
    stroke(rectColor);
    rect(width/10 * 4.5, height/10 * 8.3, width/50, width/20);
    rect(width/10 * 4.8, height/10 * 8.3, width/50, width/20);
    GT1.stop();
  }
  if(mouseX > width/10 * 3.5 && mouseX < width/10 * 3.5 + width/20 && mouseY > height/10 * 8.3 && mouseY < height/10 * 8.3 + width/20)
  {
    fill(rectHighlight);
    stroke(rectColor);
    triangle(width/10 * 3.5, height/10 * 8.3, width/10 * 3.5, height/10 * 8.3 + width/20, width/10 * 3.5 + width/20, height/10 * 8.3 + width/40);
    GT1.start();
  }
  if(mouseX > bpmLocX - 40 && mouseX < bpmLocX - 20 && mouseY > bpmLocY + rectSpacing - 16 && mouseY < bpmLocY + rectSpacing + 8)
  {
    myBPM--;
  }
  if(mouseX > bpmLocX + 20 && mouseX < bpmLocX + 40 && mouseY > bpmLocY + rectSpacing - 16 && mouseY < bpmLocY + rectSpacing + 8)
  {
    myBPM++;
  }
}

// check if the user is pressing keys
void keyPressed() 
{
  switch(key)
  {
    // exit the program
    case ESC:
      GT1.stop();
      stop();
      exit();
      break;
    // arrow keys for changing tempo  
    case CODED:
      if( keyCode == UP)
      {
        myBPM++;
        tempo = 1000 * 60/myBPM;
        GT1.setInterval(tempo);
      }
      if( keyCode == DOWN)
      {
        myBPM--;
        
        if(tempo<0)
        {
          tempo = 0;
        }
        tempo = 1000 * 60/myBPM;
        GT1.setInterval(tempo);
      }
      
      
      if(keyCode == LEFT)
      {
       mytime = mytime - 1;
       curPos = (mytime - 1) * rectSpacing + rectSize/2 + startX;
       if(mytime < 2)
       {
         mytime = 17;
       }
      }
      if(keyCode == RIGHT)
      {
       mytime = mytime + 1;
       curPos = (mytime - 1) * rectSpacing + rectSize/2 + startX;
       if(mytime > 15)
       {
         mytime = 0;
       }
      }
      
      
      //print(myBPM);
      //print(" ");
      //println(tempo);
      break;
    // letter keys for playing sound directly  
    case ' ': // start/stop playing when pressing SPACE bar
      if(playing == false)
      {
        playing = true;
        GT1.start();
      }
      else
      {
        GT1.stop();
        playing = false;
      }
      break;
      case ENTER:
        mytime = 0;
        break;
      case RETURN:
        mytime = 0;
        break;
    case 'a':
      f1.play();
      break;
    case 's':
      f2.play();
      break;      
    case 'd':
      f3.play();
      break;
    case 'f':
      f4.play();
      break;
    case 'g':
      f5.play();
      break;      
    case 'h':
      f6.play();
      break;
    case 'j':
      f7.play();
      break;
    case 'k':
      f8.play();
      break;     
    default:
      break;
  }

}

// draw all the squares on screen
void drawSquares()
{
  int i,j;
  strokeWeight(1); // draw thin lines around rectangles
  for(i=0;i<16;i++)
  {
    for(j=0;j<8;j++)
    {
      if(rectOver[(i*8) + j]) 
      {
        fill(rectHighlight);
      } 
      else 
      {
        fill(rectColor);
      }
      stroke(#FF6600);
      ellipse(rectX[(i*8) + j] + 12.5, rectY[(i*8) + j] + 12.5, rectSize, rectSize);
      fill(playHead);
      stroke(rectColor);
      rect(width/10 * 2.5, height/10 * 8.3, width/20, width/20);
      rect(width/10 * 4.5, height/10 * 8.3, width/50, width/20);
      rect(width/10 * 4.8, height/10 * 8.3, width/50, width/20);
      triangle(width/10 * 3.5, height/10 * 8.3, width/10 * 3.5, height/10 * 8.3 + width/20, width/10 * 3.5 + width/20, height/10 * 8.3 + width/40);
    }
  }
}

// display BPM value
void showbpm( int i )
{
  stroke(255);
  fill(#FF6600);
  rect(bpmLocX - 40, bpmLocY - 20, 80, 68);
  textAlign(CENTER);
  fill(255);
  text("Tempo", bpmLocX, bpmLocY);
  text("- " + i + " +", bpmLocX, bpmLocY + rectSpacing);
  textAlign(LEFT);
  fill(#FF6600);
  text(sample1, width/10 * 8 + 30, rectSpacing);
  text(sample2, width/10 * 8 + 30, 2 * rectSpacing);
  text(sample3, width/10 * 8 + 30, 3 * rectSpacing);
  text(sample4, width/10 * 8 + 30, 4 * rectSpacing);
  text(sample5, width/10 * 8 + 30, 5 * rectSpacing);
  text(sample6, width/10 * 8 + 30, 6 * rectSpacing);
  text(sample7, width/10 * 8 + 30, 7 * rectSpacing);
  text(sample8, width/10 * 8 + 30, 8 * rectSpacing);
}

// timer for each beat, runs as callback
void showtime(GTimer gtimer)
{
  mytime++;
  if(mytime > 16)
  {
    mytime = 1;
  }
  if(mytime < 1)
  {
    mytime = 16;
  }
  
  soundstep(mytime - 1);
  curPos = (mytime - 1) * rectSpacing + rectSize/2 + startX;
//  println(mytime);
}