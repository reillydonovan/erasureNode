color col = color(181,157,0,100);
float lineModuleSize = 0;
float angle = 0;
float angleSpeed = 1.0;
PShape lineModule = null;
float stepSize = 5.0;

void drawLines() {
  TSPSPerson[] people = tspsReceiver.getPeopleArray();
  for (int i=0; i<people.length; i++) {
    // get person
    TSPSPerson person = people[i];
    lineModuleSize = random(50,160);
    pushMatrix();
    strokeWeight(random(0,1)); 
    noFill();
    stroke(col);

    translate(person.centroid.x*width, person.centroid.y*height);
    rotate(radians(angle));
     if (lineModule != null) {
      shape(lineModule, 0, 0, lineModuleSize, lineModuleSize);
    } 
    else {
      line(0, 0, lineModuleSize, lineModuleSize);
      //fill(col);
      //stroke(-col);
   //   ellipse(0,0, lineModuleSize, lineModuleSize);
    }
    popMatrix();
  }
  angle += angleSpeed;
}