// IMÁGENES
PImage fondo1, mark1, omniman1, viltrum, omni2, ciudad, fondofinal;

//SONIDOS
import ddf.minim.*;
Minim minim;
AudioPlayer musicafondo;
AudioPlayer sonidobotones;

// POSICIÓN Y ANIMACIÓN
float mark1X = 200;
float omniman1X = 640;
float transitionTime = 3000;
int startTime;
int pantalla = 0;

// BOTÓN DE INICIO
boolean botoninicio = false;
boolean botonVolver = false;

// TEXTO PANTALLA 1
String textInfo = "Omni-Man, cuyo nombre verdadero es Nolan Grayson, es un superhéroe alienígena originario del planeta Viltrum, una raza de seres con fuerza sobrehumana, capacidad de vuelo y longevidad extrema. En la tierra, Nolan adopta la identidad de un escritor de libros de viajes y forma una familia humana con Debbie Grayson, con quien tiene un hijo: Mark Grayson.";
float textoY = 500;
float velocidadTexto = 0.50;
float muchotexto = 480;

// TEXTO PANTALLA 2
String textMark = "Mark Grayson es un joven aparentemente normal que descubre sus poderes a los 17 años. Hijo de Omni-Man, hereda las habilidades de los viltrumitas. A medida que aprende a ser un superhéroe, comienza a cuestionar la verdadera naturaleza de su padre y el propósito de su raza.";
float textoY2 = 500;

// TEXTO PANTALLA 3
String textCreadores = "Invencible fue creado por Robert Kirkman, quien también es conocido por su trabajo en The Walking Dead. La serie fue ilustrada por Cory Walker y más tarde por Ryan Ottley. Invencible es una obra de superhéroes con una historia más madura y violenta, que explora los conflictos familiares y los dilemas morales. El cómic fue publicado por Image Comics a partir de 2003.";
float textoX3;
float velocidadTextoX3 = 2;

void setup() {
  size(640, 480);
  imageMode(CENTER);
  
  //MUSIQUITA
  minim = new Minim(this);
  musicafondo = minim.loadFile("musicafondo.mp3");
  sonidobotones = minim.loadFile("botones.mp3");
  musicafondo.setGain(-10);
  sonidobotones.setGain(0);
  
  musicafondo.loop();

  // IMAGENES
  fondo1 = loadImage("tierra.jpg");
  mark1 = loadImage("mark1.png");
  omniman1 = loadImage("omniMan1.png");
  viltrum = loadImage("viltrum.jpg");
  ciudad = loadImage("ciudad.jpg");
  fondofinal = loadImage("fondofinal.jpg");

  startTime = millis();
  textoX3 = width; // Comienza fuera de la pantalla por la derecha
}

void draw() {
  float elapsedTime = millis() - startTime;

  if (pantalla == 0) {
    image(fondo1, width/2, height/2, width, height);

    if (elapsedTime < transitionTime) {
      mark1X = lerp(640, 454, elapsedTime / transitionTime);
      omniman1X = lerp(-200, 212.5, elapsedTime / transitionTime);
    } else {
      botoninicio = true;
    }

    image(mark1, mark1X, 216.5);
    image(omniman1, omniman1X, 216.5);

    if (botoninicio) {
      fill(50, 150, 255);
      rect(220, 380, 200, 60, 20);

      fill(255);
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Inicio", 320, 410);
    }
  }

  else if (pantalla == 1) {
    image(viltrum, width / 2, height / 2, width, height);

    fill(0);
    textAlign(LEFT, TOP);
    textSize(25);
    text(textInfo, 249, textoY - 1, 320, muchotexto);
    text(textInfo, 251, textoY + 1, 320, muchotexto);
    fill(255, 255, 0);
    text(textInfo, 250, textoY, 320, muchotexto);
    textoY -= velocidadTexto;

    // TÍTULO
    textSize(35);
    fill(0);
    text("Omni-Man", width / 2 - 1, textoY - 40);
    text("Omni-Man", width / 2 + 1, textoY - 40);
    text("Omni-Man", width / 2, textoY - 39);
    text("Omni-Man", width / 2, textoY - 41);
    fill(255, 255, 0);
    text("Omni-Man", width / 2, textoY - 40);

    if (textoY < -muchotexto) {
      textoY = 500;
      pantalla = 2;
    }
  }

  else if (pantalla == 2) {
    image(ciudad, width / 2, height / 2, width, height);

    fill(0);
    textAlign(LEFT, TOP);
    textSize(25);
    text(textMark, 249, textoY2 - 1, 320, muchotexto);
    text(textMark, 251, textoY2 + 1, 320, muchotexto);
    fill(255, 255, 0);
    text(textMark, 250, textoY2, 320, muchotexto);
    textoY2 -= velocidadTexto;

    // TÍTULO
    textSize(35);
    fill(0);
    text("Mark Grayson", width / 2 - 1, textoY2 - 40);
    text("Mark Grayson", width / 2 + 1, textoY2 - 40);
    text("Mark Grayson", width / 2, textoY2 - 39);
    text("Mark Grayson", width / 2, textoY2 - 41);
    fill(255, 255, 0);
    text("Mark Grayson", width / 2, textoY2 - 40);

    if (textoY2 < -muchotexto) {
      textoY2 = 500;
      pantalla = 3;
    }
  }

  else if (pantalla == 3) {
    image(fondofinal, width / 2, height / 2, width, height);

    fill(0);
    textAlign(LEFT, CENTER);
    textSize(50);
    text(textCreadores, textoX3, height/2);
    text(textCreadores, textoX3, height/2);
    fill(255, 255, 0);
    text(textCreadores, textoX3, height/2, muchotexto);
    textoX3 -= velocidadTextoX3;

    if (textoX3 + textWidth(textCreadores) < 0) {
      botonVolver = true;
    }

    if (botonVolver) {
      fill(50, 150, 255);
      rect(width / 2 - 100, height / 2 + 100, 200, 60, 20);

      fill(255);
      textAlign(CENTER, CENTER);
      textSize(20);
      text("Volver al inicio", width / 2, height / 2 + 130);
    }
  }
}

void mousePressed() {
  if (pantalla == 0 && botoninicio &&
      mouseX > 220 && mouseX < 420 &&
      mouseY > 380 && mouseY < 440) {
        sonidobotones.rewind();
        sonidobotones.play();
    pantalla = 1;
  }

  if (pantalla == 3 && botonVolver &&
      mouseX > width / 2 - 100 && mouseX < width / 2 + 100 &&
      mouseY > 380 && mouseY < 440) {
        sonidobotones.rewind();
        sonidobotones.play();
    pantalla = 0;
    startTime = millis();
    mark1X = 200;
    omniman1X = 640;
    botoninicio = false;
    textoY = 500;
    textoY2 = 500;
    textoX3 = width;
    botonVolver = false;
  }
}
