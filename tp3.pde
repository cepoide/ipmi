PImage imagenReferencia;

// --- VARIABLES GLOBALES ---

// El centro fijo donde van a ir apareciendo las capas
float capaCentroX, capaCentroY;

// Tamaño base de las capas (el primero que aparece)
float baseCapaAncho, baseCapaAlto; 
float baseCapaAnchoInicial, baseCapaAltoInicial;

// Estos son los valores que hacen que cada capa crezca un poco más que la anterior
float baseAumentoAnchoStep, crecimientoAdicionalPorCapaAncho;
float baseAumentoAltoStep, crecimientoAdicionalPorCapaAlto;
float baseRotacionStep, crecimientoAdicionalPorCapaRotacion;

// Cosas que se usan para reiniciar o manejar con el mouse
int numeroDeCapas;
int numeroDeCapasInicial;
float baseRotacionStepInicial; 
color[] paletaDeColores;
boolean rotacionInteractivaPausada = false;

void setup() {
  size(1600, 400); // Ventana dividida: izquierda imagen, derecha Op Art
  imagenReferencia = loadImage("imagen.jpg"); // cargo la imagen que va del lado izquierdo
  
  // Centro donde se dibuja el patrón (está fijo, así todo gira ahí)
  capaCentroX = 1200; 
  capaCentroY = 200;
  
  // Configuro cómo crece y gira cada capa
  baseAumentoAnchoStep = 2; 
  baseAumentoAltoStep = 1;  
  baseRotacionStepInicial = -PI / 11; 
  baseRotacionStep = baseRotacionStepInicial; 
  
  crecimientoAdicionalPorCapaAncho = 2; 
  crecimientoAdicionalPorCapaAlto = 1;  
  crecimientoAdicionalPorCapaRotacion = -PI / 80; 

  // Guardo el tamaño original por si después tengo que reiniciar todo
  baseCapaAnchoInicial = 52; 
  baseCapaAltoInicial = 40;  
  baseCapaAncho = baseCapaAnchoInicial; 
  baseCapaAlto = baseCapaAltoInicial;
  
  numeroDeCapasInicial = 35; 
  numeroDeCapas = numeroDeCapasInicial;
  
  configurarPaletaInicial(); 
  rotacionInteractivaPausada = false; 
}

void draw() {
  background(255); // fondo blanco

  // Mido qué tan lejos está el mouse del centro del dibujo
  float distancia = dist(mouseX, mouseY, capaCentroX, capaCentroY);
  
  // Si estoy cerca, el patrón crece (efecto zoom raro)
  float multiplicadorTamano = map(distancia, 0, 300, 2.5, 1.0); 
  multiplicadorTamano = constrain(multiplicadorTamano, 1.0, 2.5);
  baseCapaAncho = baseCapaAnchoInicial * multiplicadorTamano;
  baseCapaAlto = baseCapaAltoInicial * multiplicadorTamano;

  // Si moví el mouse, vuelvo a activar la rotación
  if (rotacionInteractivaPausada) {
    if (mouseX != pmouseX || mouseY != pmouseY) { 
      rotacionInteractivaPausada = false;
    }
  } 
  // Mapeo el X del mouse a un ángulo de rotación (controlado con el mouse)
  if (!rotacionInteractivaPausada) {
    float mouseControlX = constrain(mouseX, 800, 1599); 
    baseRotacionStep = map(mouseControlX, 800, 1599, -PI/5, PI/5); 
  }

  // Dibujo capa por capa, de la más lejana a la más cercana
  for (int i = numeroDeCapas - 1; i >= 0; i--) {
    float numIncrementos = i;
    float totalAumentoAncho = 0, totalAumentoAlto = 0, totalRotacion = 0;

    if (numIncrementos > 0) {
      totalAumentoAncho = calcularSumaAcumulada(numIncrementos, baseAumentoAnchoStep, crecimientoAdicionalPorCapaAncho);
      totalAumentoAlto = calcularSumaAcumulada(numIncrementos, baseAumentoAltoStep, crecimientoAdicionalPorCapaAlto);
      totalRotacion = calcularSumaAcumulada(numIncrementos, baseRotacionStep, crecimientoAdicionalPorCapaRotacion);
    }

    float anchoCalculado = baseCapaAncho + totalAumentoAncho;
    float altoCalculado = baseCapaAlto + totalAumentoAlto;
    float currentRotation = totalRotacion; 
    float limiteAnchoMaximo = 798, limiteAltoMaximo = 398;   
    float currentAncho = constrain(anchoCalculado, 1, limiteAnchoMaximo); 
    float currentAlto = constrain(altoCalculado, 1, limiteAltoMaximo); 

    color colorBaseActual = paletaDeColores[i % paletaDeColores.length];
    color colorDeCapa = calcularColorParaCapa(i, numeroDeCapas, colorBaseActual, 255, 255); 

    dibujarCapaRectangular(capaCentroX, capaCentroY, currentAncho, currentAlto, currentRotation, colorDeCapa);
  }

  // Línea divisoria en el medio
  stroke(0); strokeWeight(2); line(800, 0, 800, height); 

  // Si la imagen cargó bien, la muestro
  if (imagenReferencia != null) { 
    image(imagenReferencia, 0, 0, 800, 400); 
  } else { 
    // Si no cargó, muestro un cartel gris
    fill(180); noStroke(); rectMode(CORNER); rect(0, 0, 800, 400); 
    fill(0); textAlign(CENTER, CENTER); text("Error al cargar 'imagen.jpg'.", 400, 200);
  }
}

// Me aseguro que la paleta empiece toda en blanco
void configurarPaletaInicial() {
  paletaDeColores = new color[10]; 
  for (int k = 0; k < paletaDeColores.length; k++) {
    paletaDeColores[k] = color(255); 
  }
}

// Dibujo una capa girada en su lugar
void dibujarCapaRectangular(float xCentro, float yCentro, float w, float h, float angRot, color cRelleno) {
  pushMatrix();
  translate(xCentro, yCentro);
  rotate(angRot);
  rectMode(CENTER);
  fill(cRelleno); 
  stroke(0); 
  strokeWeight(2);
  rect(0, 0, w, h);
  popMatrix();
}

// Me da la suma acumulada de valores (para el crecimiento no lineal)
float calcularSumaAcumulada(float numPasos, float pasoBase, float crecimientoDelPaso) {
  float sumaTotal = 0;
  if (numPasos > 0) {
    for (int j = 0; j < numPasos; j++) { 
      sumaTotal += (pasoBase + (j * crecimientoDelPaso));
    }
  }
  return sumaTotal;
}

// Le bajo la opacidad a las capas según qué tan lejos estén
color calcularColorParaCapa(int indiceCapa, int totalCapas, color cBase, float minAlpha, float maxAlpha) {
  float alphaCalculado;
  if (totalCapas <= 1) alphaCalculado = maxAlpha; 
  else alphaCalculado = map(indiceCapa, 0, totalCapas - 1, maxAlpha, minAlpha); 
  return color(red(cBase), green(cBase), blue(cBase), alphaCalculado); 
}

// Cuando se reinicia todo
void reiniciarValores() {
  println("Valores Reiniciados!");

  // Centro fijo del patrón
  capaCentroX = 1200;
  capaCentroY = 200;

  // Volvemos todo a como era al principio
  numeroDeCapas = numeroDeCapasInicial;
  baseRotacionStep = baseRotacionStepInicial; 
  rotacionInteractivaPausada = true; 
  baseCapaAncho = baseCapaAnchoInicial;
  baseCapaAlto = baseCapaAltoInicial;

  baseAumentoAnchoStep = 2; 
  baseAumentoAltoStep = 1;  
  crecimientoAdicionalPorCapaAncho = 2; 
  crecimientoAdicionalPorCapaAlto = 1;  
  crecimientoAdicionalPorCapaRotacion = -PI / 80; 
  
  configurarPaletaInicial(); 
}

// Flechas arriba/abajo para agregar o quitar capas. R para reiniciar.
void keyPressed() {
  if (keyCode == UP) {
    numeroDeCapas++;
    rotacionInteractivaPausada = false; 
  } else if (keyCode == DOWN) {
    if (numeroDeCapas > 1) numeroDeCapas--;
    rotacionInteractivaPausada = false; 
  } else if (key == 'r' || key == 'R') {
    reiniciarValores();
  }
}

// Si clickeo con el mouse, cambio la paleta a colores random
void mousePressed() {
  println("Mouse Presionado - Cambiando paleta de colores a aleatorios!");
  for (int k = 0; k < paletaDeColores.length; k++) {
    paletaDeColores[k] = color(random(50, 255), random(50, 255), random(50, 255)); 
  }
  rotacionInteractivaPausada = false; 
}
