PImage imagen;

void setup(){
  size(968,600);
  imagen =loadImage("pintura.jpg");
  
}

void draw(){
  image(imagen, 0, 0);
  noStroke();
  fill(0);
  
  //primer bloque
  fill(150);
  rect(width/2,0,968,22);
  fill(103,157,229);
  rect(484,0,120,22);
  fill(#9ab1db);
  rect(604,0,227,22);
  fill(#c6ad5b);
  triangle(603,21,629,0,603,0);
  triangle(830,27,830,0,806,0);
  stroke(0);
  strokeWeight(2);
  line(604,20,630,0);
  line(833,26,807,0);
  line(605,21,826,21);
  noStroke();
  
  
  fill(141, 171, 231);
  rect(831,0,width,15);
  
  //segundo bloque
  fill(150);
  rect(484,22,605,183);
  fill(195,177,93);
  rect(484,20,120,185);
  fill(193,186,157);
  triangle(514,107,604,22,604,204);
  fill(183,110,16);
  rect(604,22,226,183);
  fill(203,199,125);
  ellipse(716,113,175,175);
  fill(205,54,25);
  ellipse(716,113,171,171);
  fill(195);
  ellipse(716,113,118,118);
  fill(108,164,238);
  ellipse(716,113,110,110);
  fill(193,186,157);
  rect(830,22,830,183);
  fill(195,177,93);
  triangle(830,22,920,112,830,206);
  
  //tercer bloque
  fill(167,28,33);
  rect(484,205,height,191);
  
  fill(204,48,25);
  triangle(604,206,519,304,604,397);
  
  stroke(0);
  strokeWeight(1.5);
  fill(131,165,228);
  rect(604,205,226,190);
  
  stroke(0);
  strokeWeight(9);
  fill(195,143,42);
  ellipse(716,310,175,175);
  
  noFill();
  stroke(122,61,32);
  strokeWeight(9);
  ellipse(716,310,119,119);
  
  stroke(203,51,30);
  strokeWeight(3);
  fill(171,19,40);
  ellipse(716,310,103,103);
  
  noStroke();
  fill(207,49,40);
  ellipse(716,310,85,85);
  
  fill(170,23,41);
  rect(832,205,832,191);
  
  fill(204,48,25);
  triangle(831,205,920,304,831,399);
  
  //cuarto bloque
  fill(53,46,40);
  rect(width/2,396,height,176);

  fill(159,125,80);
  triangle(603,397,530,486,603,573);
  
  fill(#d13423);
  rect(603,396,225,176);
  
  stroke(#c3c6b3);
  strokeWeight(35);
  fill(#4f6d91);
  ellipse(716,482,133,133);
  
  noStroke();
  fill(0);
  ellipse(716,482,75,75);
  
  fill(#6c391c);
  rect(828,394,width,178);
  
  stroke(#c49d42);
  strokeWeight(2);
  line(828,394,968,394);
  
  fill(#c49d42);
  triangle(827,395,920,482,827,570);
  
  //cuarto bloque
  noStroke();
  fill(#7db2f8);
  rect(width/2,572,width,height);
  
  fill(#0f357c);
  rect(width/2,572,120,13);
  
  fill(#a4c1ed);
  rect(604,572,223,600);
  
  fill(#a18462);
  triangle(603,571,628,600,603,600);
  triangle(798,600,827,572,827,600);
  
  fill(#0947b8);
  rect(827,571,width,9);
  
  fill(#6ca6ef);
  rect(827,580,width,height);
  
}
