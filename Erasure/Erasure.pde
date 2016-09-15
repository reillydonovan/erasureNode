/***********************************************************************
 * Erasure
 * Coded by Reilly Donovan 
 * For ArtHack ieti @ Cornish
 * September 2016 - Seattle, WA
 * ***********************************************************************/

import tsps.*;
import java.net.*;
import java.io.*;
import javax.imageio.*;
import java.awt.image.*;
import java.lang.Thread;
import processing.pdf.*;
import java.util.Calendar;

TSPS tspsReceiver;
Crop crop;
Uploader uploader;
Timer timer;

String title = "";
char s = ' ';
char u = '_';
PFont    uifont;      //holds font for console ui
int  maxLines = 30;   //number of lines console will have at most
int totalFadeTime = 1; // add to taste
int currentFadeTime = 0;
int lastDrawn = 0;
int numPeopleLeft = 0;
String   console[];   //array of strings for console
String debugText;
PImage screenShot;
PImage fader;
Boolean debug = false;
Boolean uploadNow = false;
Boolean fade = false;
boolean finished = false; // This will keep track of whether the thread is finished
float percent = 0; // And how far along
int n = 0;
void setup() {
  //size(displayWidth, displayHeight);
fullScreen();
  crop = new Crop();
  timer = new Timer(5000);

  tspsReceiver= new TSPS(this, 12000);

  uifont = loadFont("Helvetica-48.vlw");
  console = new String[maxLines];
  printConsole("begin console");
  background(1); // adjust this value to control fade rate
  fader = get();
  background(255);
  frameRate(60);
  noCursor();
  timer.start();
}

void draw() {
  drawLines();
  debugText = "";
  if (uploadNow) {
    //  screenShot = get(0, 0, width, height);
    printConsole("saving drawing"); 
    n += 1;
  //  saveFrame("data/" + n + ".png");
    println(n);
    uploadNow = false;
  }



  // crop.display();
  debugger();

  if (fade) {
    blend(fader, 0, 0, width, height, 0, 0, width, height, SCREEN);
    currentFadeTime++;
    if (currentFadeTime == totalFadeTime) {
      fade = false; // stop fading
      currentFadeTime=0;//reset counter
    }
  }
}

class MyServer extends Thread {
  public void run() {
    println("2nd thread running");
  }
}

void personEntered( TSPSPerson p ) {
  col = color(random(0, 255), random(0, 255), random(0, 255));
  //background( 0 );
  // fill( 0 );
  // textAlign( CENTER );
  // text( new_sentence(), width / 2, height / 2 );
  // noFill();
  //text( "Hello new person!", width / 2, height / 2 );
}
void personUpdated( TSPSPerson p ) {
}

void personLeft( TSPSPerson p ) {
  fade = true;
  uploadNow = true;
  println(new_sentence());


  // no one left :(
  if (numPeopleLeft == 0) {
    //   text( "All alone again...", width / 2, height / 2 );
  } else {
    //    text( "See ya!\nGlad I've got "+ numPeopleLeft +" more friends to kick it with.", width / 2, height / 2 );
  }
  lastDrawn = millis();
}