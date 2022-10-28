import ddf.minim.*;

int page, inst, type;
float W, H, imgS[][]= new float[19][2];
boolean idiom, audio, pause, pos, vel, acel;
String txt[][]= new String[31][2];
PImage img[][]= new PImage[19][2];
Button button[]= new Button[19];
Minim music;
AudioPlayer jazz;

int tb, count;
int tpN[]= new int[7];
String t[]= new String[7];
boolean tp[]= new boolean[7];

//Estas variables sirven para ubicar los gráficos, las scale sirven para re-escalar con la rueda del mouse los gráficos
int[] xPan= new int[4], yPan= new int[4], nX= new int[4], nY= new int[4];
float[] scaleG= new float[4], scaleP= new float[4], x= new float[4], r= new float[4];

float[][] mat= new float[1][3];
float A, m, k, a, w, F, wd;
void setup(){
  size(1280,720);
  surface.setResizable(true);
  surface.setLocation(100, 100);
  surface.setTitle("Simulacion de Sistemas Oscilatorios");
  
  xPan[0]=1045;
  xPan[1]=1045;
  xPan[2]=1045;
  xPan[3]=600;
  yPan[0]=120;
  yPan[1]=340;
  yPan[2]=560;
  yPan[3]=340;
  
  //La escala y la posición de vista de los gráficos se declara inicialmente
  for(int i=0; i<4; i++){
    scaleG[i]=1;
    scaleP[i]=1;
    x[i]=1;
    r[i]=1;
    nX[i]=0;
    nY[i]=0;
  }
  nX[3]=-130;
  xPan[3]=470;
  
  page=0;
  inst=0;
  type=0;
  count=0;
  tb=-1;
  
  W=width;
  H=height;
  
  idiom=true;
  audio=true;
  pause=true;
  pos=true;
  vel=true;
  acel=true;
  
  //Estos son los textos en el programa que son almacenados y cambian al cambiar de idioma
  txt[0][0]="Jugar";
  txt[1][0]="Instrucciones";
  txt[2][0]="Salir";
  txt[3][0]="ESP";
  txt[4][0]="Seleccione una simulacion";
  txt[5][0]="Sistema no amortiguado";
  txt[6][0]="";
  txt[7][0]="Sistema amortiguado";
  txt[8][0]="";
  txt[9][0]="Sistema Forzado";
  txt[10][0]="";
  txt[11][0]="Regresar";
  txt[12][0]="Seguir";
  txt[13][0]="Amplitud";
  txt[14][0]="Masa";
  txt[15][0]="Elasticidad";
  txt[16][0]="Fase";
  txt[17][0]="Amortiguamiento";
  txt[18][0]="Fuerza externa";
  txt[19][0]="Frequencia F";
  txt[20][0]="Posicion";
  txt[21][0]="Velocidad";
  txt[22][0]="Aceleracion";
  txt[23][0]="Guardar Datos";
  txt[24][0]="Guardar valores de posicion";
  txt[25][0]="Guardar valores de velocidad";
  txt[26][0]="Guardar valores de aceleracion";
  txt[27][0]="Guardar";
  txt[28][0]="Menu principal";
  txt[29][0]="Tiempo";
  txt[30][0]="Datos";
  txt[0][1]="Play";
  txt[1][1]="Instructions";
  txt[2][1]="Exit";
  txt[3][1]="ENG";
  txt[4][1]="Select a simulation";
  txt[5][1]="Undamped system";
  txt[6][1]="";
  txt[7][1]="damped system";
  txt[8][1]="";
  txt[9][1]="Forced system";
  txt[10][1]="";
  txt[11][1]="Return";
  txt[12][1]="Next";
  txt[13][1]="Amplitude";
  txt[14][1]="Mass";
  txt[15][1]="Elasticity";
  txt[16][1]="Phase";
  txt[17][1]="Damping";
  txt[18][1]="External force";
  txt[19][1]="Frequency F";
  txt[20][1]="Position";
  txt[21][1]="Velocity";
  txt[22][1]="Acceleration";
  txt[23][1]="Save Data";
  txt[24][1]="Save position values";
  txt[25][1]="Save velocity values";
  txt[26][1]="Save acceleration values";
  txt[27][1]="Save";
  txt[28][1]="Main menu";
  txt[29][1]="Time";
  txt[30][1]="Data";
  
  img[0][0]=loadImage("/assets/images/menuBackground.jpg");
  img[1][0]=loadImage("/assets/images/inst1.png");
  img[2][0]=loadImage("/assets/images/inst2.PNG");
  img[3][0]=loadImage("/assets/images/inst3.PNG");
  img[4][0]=loadImage("/assets/images/inst4.PNG");
  img[5][0]=loadImage("/assets/images/menuBackgroundE.jpeg");
  img[6][0]=loadImage("/assets/images/instE1.PNG");
  img[7][0]=loadImage("/assets/images/instE2.PNG");
  img[8][0]=loadImage("/assets/images/instE3.PNG");
  img[9][0]=loadImage("/assets/images/instE4.PNG");
  img[10][0]=loadImage("/assets/images/background.jpeg");
  img[11][0]=loadImage("/assets/images/seeThroughBackground.png");
  img[12][0]=loadImage("/assets/images/logoUN.png");
  img[13][0]=loadImage("/assets/images/sonidoIC.png");
  img[14][0]=loadImage("/assets/images/restart.png");
  img[15][0]=loadImage("/assets/images/backward.png");
  img[16][0]=loadImage("/assets/images/reanudar.png");
  img[17][0]=loadImage("/assets/images/pausa.png");
  img[18][0]=loadImage("/assets/images/forward.png");
  img[12][0].resize(250,125);
  img[13][0].resize(35,35);
  img[14][0].resize(40,40);
  img[15][0].resize(40,40);
  img[16][0].resize(50,50);
  img[17][0].resize(30,30);
  img[18][0].resize(40,40);
  for(int i=0; i<img.length; i++){
    if(i<12){
      img[i][0].resize(width, height);
    }
    img[i][1]=img[i][0].get();
  }
  
  button[0]= new Button(txt[0][0], 20, 640, 320, 400, 40);
  button[1]= new Button(txt[1][0], 20, 640, 380, 400, 40);
  button[2]= new Button(txt[2][0], 20, 640, 440, 400, 40);
  button[3]= new Button(txt[3][0], 20, 55, 35, 80, 40);
  button[4]= new Button("", 20, 135, 35, 40, 40);
  button[5]= new Button(txt[5][0], 20, 210, 180, 400, 40);
  button[6]= new Button(txt[7][0], 20, 210, 240, 400, 40);
  button[7]= new Button(txt[9][0], 20, 210, 300,  400, 40);
  button[8]= new Button(txt[11][0], 20, 85, 690, 150, 40);
  button[9]= new Button(txt[12][0], 20, 1195, 690, 150, 40);
  button[10]= new Button("", 20, 30, 390, 40, 40);
  button[11]= new Button("", 20, 130, 390, 40, 40);
  button[12]= new Button("", 20, 230, 390, 40, 40);
  button[13]= new Button("", 20, 330, 390, 40, 40);
  button[14]= new Button("", 20, 320, 250, 40, 40);
  button[15]= new Button("", 20, 320, 310, 40, 40);
  button[16]= new Button("", 20, 320, 370, 40, 40);
  button[17]= new Button(txt[27][0], 20, 640, 460, 160, 40);
  button[18]= new Button(txt[28][0], 20, 1195, 690, 150, 40);
  
  music= new Minim(this);
  jazz= music.loadFile("/assets/audio/relaxing-jazz-hiphop.mp3");
  jazz.loop();
  
  for(int i=0; i<7; i++){
    t[i]="1";
    tp[i]=false;
  }
}

void draw(){
  //Se hace el resize de la pestaña si el usuario lo desea
  if(W!=width || H!=height){
    windowResized();
  }
  //Se selecciona la página en la que el usuario está
  pageSelector();
}

void page0(){
  //Página del menú principal 
  image(img[0][1],0,0);
  image(img[12][1],0,height-125*H/720);
  
  scale(W/1280,H/720);
  button[0].display();
  button[1].display();
  button[2].display();
  button[3].display();
  button[4].display();
  
  image(img[13][1],118,18);
  if(audio==false){
    stroke(255);
    strokeWeight(3);
    line(120,50,150,20);
    noStroke();
  }
}

void page1(){
  //Página de instrucciones
  image(img[1+inst][1],0,0);
  scale(W/1280,H/720);
  button[8].display();
  button[9].display();
}

void page2(){
  //Página para seleccionar el tipo de movimiento que desea simular
  image(img[10][1],0,0);
  scale(W/1280,H/720);
  fill(255);
  textAlign(LEFT);
  textSize(40);
  text(txt[4][0],10,100);
  
  button[5].display();
  button[6].display();
  button[7].display();
  button[8].display();
}

void page3(){
  if(frameCount%60==0){
    //Contador de segundos
    count+=1;
  }
  A= float(t[0]);
  m= float(t[1]);
  k= float(t[2]);
  a= float(t[3])*PI/180;
  F= float(t[5]);
  wd= float(t[6]);
  w= sqrt(k/m);
  
  switch(type){
    //Si el type es 0 significa que se seleccionó el sistema no amortiguado
    case 0:
      float j=0;
      for(int i=0; i<mat.length; i++){
        mat[i][0]= A*cos(w*j-a);
        mat[i][1]= -A*w*sin(w*j-a);
        mat[i][2]= -A*pow(w,2)*cos(w*j-a);
        j+=0.01666666666666666666666666666667;
      }
    break;
    
    //En el caso 1, se selecciona el sistema amortiguado
    case 1:
      float b= float(t[4]);
      float e=2.71828;
      
      //Este es el caso cuando estamos en sobre amortiguamiento
      if(b*b>4*m*k){
        float y0=A*cos(a);
        float v0=-A*w*sin(a);
        float r1 = (float)((b - Math.sqrt(b*b - 4*m*k)) / (2*m)); 
        float r2 = (float)((b + Math.sqrt(b*b - 4*m*k)) / (2*m));
        float c1 = (y0*r2 - v0) / (r2 - r1);
        float c2 = (v0 - y0*r1) / (r2 - r1);
        
        j=0;
        for(int i=0; i<mat.length; i++){
          mat[i][0] = (float)(c1*Math.pow(e, -r1*j)+c2*Math.pow(e, -r2*j));
          mat[i][1] = (float)(-c1*r1*Math.pow(e, -r1*j)-c2*r2*Math.pow(e, -r2*j));
          mat[i][2] = (float)(c1*Math.pow(r1, 2)*Math.pow(e, -r1*j)+c2*Math.pow(r2, 2)*Math.pow(e, -r2*j));
          j+=0.01666666666666666666666666666667;
        }
        //En el caso crítico y sub-amortiguado se usa esta misma ecuación
      }else{
        float wi=sqrt(k/m-(float)(pow(b, 2)/(4*pow(m, 2))));
        
        j=0;
        for(int i=0; i<mat.length; i++){
          mat[i][0] = (float)(A*Math.pow(e, -(b/(2*m)*j))*cos(wi*j+a));
          mat[i][1] = (float)(A*(-((b*Math.pow(e, -(b*j)/(2*m)))/(2*m))-Math.pow(e, -(b*j)/(2*m))*sin(wi*j+a)));
          mat[i][2] = (float)((A*(b*b*pow(e, -(b*j)/(2*m))*cos(wi*j+a)+4*b*m*pow(e, -(b*j)/(2*m))*wi*sin(wi*j+a)-4*m*m*pow(e, -(b*j)/(2*m))*wi*wi*cos(wi*j+a))/(4*m*m)));
          j+=0.01666666666666666666666666666667;
        }
      }
    break;
    //Finalmente, este es el caso cuando se selecciona el movimiento forzado
    case 2:
      b= float(t[4]);
      e=2.71828;
      float wi=sqrt(k/m-(float)(pow(b, 2)/(4*pow(m, 2))));
      float Ad= (float)(F/(sqrt(pow(k-m*pow(wd, 2), 2)+pow(b, 2)*pow(wd, 2)))); 
      float ad= (float)(atan((b*wd)/(m*(pow(wi, 2)-pow(wd, 2)))));
      
      //Y evidentemente, de nuevo las fórmulas se dividen por su amortiguamiento, siendo la primera el caso sobre amortiguado
      if(b*b>4*m*k){
        float y0=A*cos(a);
        float v0=-A*w*sin(a);
        float r1 = (float)((b - Math.sqrt(b*b - 4*m*k)) / (2*m)); 
        float r2 = (float)((b + Math.sqrt(b*b - 4*m*k)) / (2*m));
        float c1 = (y0*r2 - v0) / (r2 - r1);
        float c2 = (v0 - y0*r1) / (r2 - r1);
        
        j=0;
        for(int i=0; i<mat.length; i++){
          mat[i][0] = (float)(c1*Math.pow(e, -r1*j)+c2*Math.pow(e, -r2*j))+Ad*cos(wd*j-ad);
          mat[i][1] = (float)(-c1*r1*Math.pow(e, -r1*j)-c2*r2*Math.pow(e, -r2*j))+-Ad*wd*sin(wd*j-ad);
          mat[i][2] = (float)(c1*Math.pow(r1, 2)*Math.pow(e, -r1*j)+c2*Math.pow(r2, 2)*Math.pow(e, -r2*j))-Ad*pow(wd,2)*cos(wd*j-ad);
          j+=0.01666666666666666666666666666667;
        }
        //Y la segunda el caso de amortiguamiento crítico y sub-amortiguado
      }else{
        j=0;
        for(int i=0; i<mat.length; i++){
          mat[i][0]= (float)(A*Math.pow(e, -(b/(2*m)*j))*cos(wi*j+a))+Ad*cos(wd*j-ad);
          mat[i][1] = (float)(A*(-((b*Math.pow(e, -(b*j)/(2*m)))/(2*m))-Math.pow(e, -(b*j)/(2*m))*sin(wi*j+a)))-Ad*wd*sin(wd*j-ad);
          mat[i][2] = (float)((A*(b*b*pow(e, -(b*j)/(2*m))*cos(wi*j+a)+4*b*m*pow(e, -(b*j)/(2*m))*wi*sin(wi*j+a)-4*m*m*pow(e, -(b*j)/(2*m))*wi*wi*cos(wi*j+a))/(4*m*m)))-Ad*pow(wd,2)*cos(wd*j-ad);
          j+=0.01666666666666666666666666666667;
        }
      }
    break;
  }
  
  //Aquí se dibuja el resorte y su respectivo gráfico
  pushMatrix();
  scale(W/1280,H/720);
  fill(255);
  noStroke();
  textSize(10);
  rectMode(LEFT);
  rect(400,20,800,660);
  dibujar(3);
  popMatrix();
  
  pushMatrix();
  image(img[11][1],0,0);
  popMatrix();
  
  scale(W/1280,H/720);
  textSize(15);
  fill(255);
  textAlign(CENTER);
  
  //Aquí se dibuja el resto de la página
  switch(type){
    case 0:
      text(txt[5][0],600,15);  
    break;
    case 1:
      text(txt[7][0],600,15);
    break;
    case 2:
      text(txt[9][0],600,15);
    break;
  }
  text(txt[20][0],1045,15);
  text(txt[21][0],1045,235);
  text(txt[22][0],1045,455);
  
  textSize(20);
  text("Variables", 200,40);
  textAlign(LEFT);
  text(txt[13][0],10,95);
  text(txt[14][0],10,135);
  text(txt[15][0],10,175);
  text(txt[16][0],10,215);
  stroke(0);
  strokeWeight(2);
  rectMode(LEFT);
  rect(120,70,350,100);
  rect(120,110,350,140);
  rect(120,150,350,180);
  rect(120,190,350,220);
  text("m",355,95);
  text("kg",355,135);
  text("N/m",355,175);
  text("°",355,215);
  fill(0);
  //Esto es para simular la pequeña barra que se muestra cada segundo al escribir texto
  if(tb==0 && count%2==0){
    text(t[0].concat("|"),125,95);
  }else{
  text(t[0],125,95);
  }
  if(tb==1 && count%2==0){
    text(t[1].concat("|"),125,135);
  }else{
  text(t[1],125,135);
  }
  if(tb==2 && count%2==0){
    text(t[2].concat("|"),125,175);
  }else{
  text(t[2],125,175);
  }
  if(tb==3 && count%2==0){
    text(t[3].concat("|"),125,215);
  }else{
  text(t[3],125,215);
  }
  if(type!=0){
    textSize(12.5);
    fill(255);
    text(txt[17][0],10,255);
    rect(120,230,350,260);
    text("Ns/m",355,255);
    fill(0);
    textSize(20);
    if(tb==4 && count%2==0){
    text(t[4].concat("|"),125,255);
    }else{
    text(t[4],125,255);
    }
    if(type==2){
      fill(255);
      textSize(12.5);
      text(txt[18][0],10,295);
      text(txt[19][0],10,335);
      rect(120,270,350,300);
      rect(120,310,350,340);
      text("N",355,295);
      text("rad/s",355,335);
      textSize(10);
      text("ext",86,336);
      fill(0);
      textSize(20);
      if(tb==5 && count%2==0){
      text(t[5].concat("|"),125,295);
      }else{
      text(t[5],125,295);
      }
      if(tb==6 && count%2==0){
      text(t[6].concat("|"),125,335);
      }else{
      text(t[6],125,335);
      }
    }
  }
  fill(0);
    strokeWeight(4);
  rect(0,370,400,410);
  button[8].display();
  button[9].display();
  button[10].display();
  button[11].display();
  button[12].display();
  button[13].display();
  image(img[14][1],10,372);
  image(img[15][1],110,372);
  image(img[18][1],310,372);
  
  //Aquí se dibujan los gráficos de posición, velocidad y aceleración
  strokeWeight(1);
  textSize(20);
  fill(255);
  rectMode(LEFT);
  rect(820,20,1270,220);
  rect(820,240,1270,440);
  rect(820,460,1270,660);
  noFill();
  textSize(10);
  dibujar(0);
  dibujar(1);
  dibujar(2);
  textAlign(LEFT);
  fill(255);
  textSize(20);
  //Se muestran los valores de cada variable calculada
  text("y: "+mat[mat.length-1][0]+"m",10,450);
  text("v: "+mat[mat.length-1][1]+"m/s",10,480);
  text("a: "+mat[mat.length-1][2]+"m/s²",10,510);
  //Aquí se evalúa la condición de pausa
   if(pause){
    image(img[16][1],205,365);
   }else{
     image(img[17][1],215.5,375.5);
     float[][] tmpA= new float[mat.length+1][3];
      for(int i=0; i<mat.length; i++){
        tmpA[i][0]= mat[i][0];
        tmpA[i][1]= mat[i][1];
        tmpA[i][2]= mat[i][2];
        mat= tmpA;
      }
      if(scaleG[0]==1){
        nX[0]-=1;
        xPan[0]-=1;
      }
      if(scaleG[1]==1){
        nX[1]-=1;
        xPan[1]-=1;
      }
      if(scaleG[2]==1){
        nX[2]-=1;
        xPan[2]-=1;
      }
   }
   //Aquí actúa el botón para retroceder 10 segundos
  if(button[11].isHovering && mousePressed){
    if(mat.length>10){
      float[][] tmpA= new float[mat.length-10][3];
      for(int i=0; i<mat.length; i++){
         tmpA[i][0]= mat[i][0];
         tmpA[i][1]= mat[i][1];
         tmpA[i][2]= mat[i][2];
         mat= tmpA;
      }
      if(scaleG[0]==1){
      nX[0]+=10;
      xPan[0]+=10;
      }
      if(scaleG[1]==1){
        nX[1]+=10;
        xPan[1]+=10;
      }
      if(scaleG[2]==1){
        nX[2]+=10;
        xPan[2]+=10;
      }
    }
  }
  //Y aquí para adelantar 10 segundos
  if(button[13].isHovering && mousePressed){
    float[][] tmpA= new float[mat.length+10][3];
      for(int i=0; i<mat.length; i++){
         tmpA[i][0]= mat[i][0];
         tmpA[i][1]= mat[i][1];
         tmpA[i][2]= mat[i][2];
         mat= tmpA;
      }
      if(scaleG[0]==1){
      nX[0]-=10;
      xPan[0]-=10;
      }
      if(scaleG[1]==1){
        nX[1]-=10;
        xPan[1]-=10;
      }
      if(scaleG[2]==1){
        nX[2]-=10;
        xPan[2]-=10;
      }
  }
  
}

//Esta es la página donde se guardan los datos de las variables calculadas en un archivo csv (Comma Separated Value)
void page4(){
  image(img[10][1],0,0);
  scale(W/1280,H/720);
  textSize(50);
  textAlign(CENTER);
  text(txt[23][0],640,180);
  textSize(20);
  textAlign(LEFT);
  text(txt[24][0],360,258);
  text(txt[25][0],360,318);
  text(txt[26][0],360,378);
  button[8].display();
  button[14].display();
  button[15].display();
  button[16].display();
  button[17].display();
  button[18].display();
  if(pos){
    stroke(255);
    strokeWeight(3);
    line(305,265,335,235);
    line(335,265,305,235);
    noStroke();
  }
  if(vel){
    stroke(255);
    strokeWeight(3);
    line(305,325,335,295);
    line(335,325,305,295);
    noStroke();
  }
  if(acel){
    stroke(255);
    strokeWeight(3);
    line(305,385,335,355);
    line(335,385,305,355);
    noStroke();
  }
}
//Esta es la subrutina para realizar el resize
void windowResized(){
  for (int i=0; i<12; i++){
    img[i][1]=img[i][0].get();
    img[i][1].resize(width, height);
  }
  img[12][1]=img[12][0].get();
  img[12][1].resize(250*width/1280, 125*height/720);
  W=width;
  H=height;
}
//Aquí se selecciona la página en la que está el usuario
void pageSelector(){
  switch(page){
    case 0:
      page0();
    break;
    case 1:
      page1();
    break;
    case 2:
      page2();
    break;
    case 3:
      page3();
    break;
    case 4:
     page4();
    break;
  }
}

/*Aquí se asegura si el cursor está encima del botón, si es el caso el botón se colorea negro, 
y también para asegurar la posición y los movimientos en los gráficos*/
void mouseMoved(){
  switch(page){
    case 0:
      button[0].isInside();
      button[1].isInside();
      button[2].isInside();
      button[3].isInside();
      button[4].isInside();
      if(button[0].isHovering || button[1].isHovering || button[2].isHovering || button[3].isHovering || button[4].isHovering){
        cursor(HAND);
      }else{
        cursor(ARROW);
      }
    break;
    case 1:
      button[8].isInside();
      button[9].isInside();
      if(button[8].isHovering || button[9].isHovering){
        cursor(HAND);
      }else{
        cursor(ARROW);
      }
    break;
    case 2:
    button[5].isInside();
    button[6].isInside();
    button[7].isInside();
    button[8].isInside();
    if(button[5].isHovering || button[6].isHovering || button[7].isHovering || button[8].isHovering){
      cursor(HAND);
    }else{
      cursor(ARROW);
    }
    break;
    case 3:
      button[8].isInside();
      button[9].isInside();
      button[10].isInside();
      button[11].isInside();
      button[12].isInside();
      button[13].isInside();
      if(button[8].isHovering || button[9].isHovering || button[10].isHovering || button[11].isHovering || button[12].isHovering || button[13].isHovering){
        cursor(HAND);
      }else if(mouseX>400*width/1280 & mouseX<800*width/1280 & mouseY>20*height/720 & mouseY<660*height/720){
        cursor(MOVE);
      }else if((mouseX>820*width/1280 & mouseX<1270*width/1280) & ((mouseY>20*height/720 & mouseY<220*height/720) || (mouseY>240*height/720 & mouseY<440*height/720) || (mouseY>460*height/720 & mouseY<660*height/720))){
        cursor(MOVE);
      }else if(tb>=0){
        cursor(TEXT);
      }else{
        cursor(ARROW);
      }
    break;
    case 4:
      button[8].isInside();
      button[14].isInside();
      button[15].isInside();
      button[16].isInside();
      button[17].isInside();
      button[18].isInside();
      if(button[8].isHovering || button[14].isHovering || button[15].isHovering || button[16].isHovering || button[17].isHovering || button[18].isHovering){
        cursor(HAND);
      }else{
        cursor(ARROW);
      }
    break;
  }
}
//Aquí lo que ocurre con cada botón si es clickeado
void mouseClicked(){
  switch(page){
    case 0:
      if(button[0].isHovering){
        page=2;
      }
      if(button[1].isHovering){
        inst=0;
        page=1;
      }
      if(button[2].isHovering){
        exit();
      }
      if(button[3].isHovering){
        language();
      }
      if(button[4].isHovering){
        if(audio){
          jazz.pause();
          audio=false;
        }else{
          jazz.loop();
          audio=true;
        }
      }
    break;
    case 1:
      if(button[8].isHovering){
        if(inst==0){
          page=0;
        }else{
          inst-=1;
        }
      }
      if(button[9].isHovering){
        if(inst==3){
          page=0;
        }else{
          inst+=1;
        }
      }
    break;
    case 2:
    if(button[5].isHovering){
        page=3;
        type=0;
    }
    if(button[6].isHovering){
        page=3;
        type=1;
    }
    if(button[7].isHovering){
        page=3;
        type=2;
    }
    if(button[8].isHovering){
        page=0;
    }
    break;
    case 3:
    if(mouseX>120*width/1280 && mouseX<350*width/1280){
      if(mouseY>70*height/720 && mouseY<100*height/720){
        tb=0;
      }else{
        tb=-1;
      }
      if(mouseY>110*height/720 && mouseY<140*height/720){
        tb=1;
      }
      if(mouseY>150*height/720 && mouseY<180*height/720){
        tb=2;
      }
      if(mouseY>190*height/720 && mouseY<220*height/720){
        tb=3;
      }
      if(type!=0){
        if(mouseY>230*height/720 && mouseY<260*height/720){
          tb=4;
        }
        if(type==2){
          if(mouseY>270*height/720 && mouseY<300*height/720){
            tb=5;
          }
          if(mouseY>310*height/720 && mouseY<340*height/720){
            tb=6;
          }
        }
      }
    }
    if(button[8].isHovering){
      page=2;
      pause=true;
      mat= new float[1][3];
      xPan[0]=1045;
      xPan[1]=1045;
      xPan[2]=1045;
      nX[0]=0;
      nX[1]=0;
      nX[2]=0;
      for(int i=0; i<7; i++){
        t[i]="1";
      }
    }
    if(button[9].isHovering){
      pause=true;
      page=4;
    }
    if(button[10].isHovering){
      mat= new float[1][3];
      xPan[0]=1045;
      xPan[1]=1045;
      xPan[2]=1045;
      nX[0]=0;
      nX[1]=0;
      nX[2]=0;
    }
    if(button[12].isHovering){
      if(pause){
        pause=false;
      }else{
        pause=true;
      }
    }
    break;
    case 4:
    if(button[8].isHovering){
      page=3;
    }
    if(button[14].isHovering){
      if(pos){
        pos=false;
      }else{
        pos=true;
      }
    }
    if(button[15].isHovering){
      if(vel){
        vel=false;
      }else{
        vel=true;
      }
    }
    if(button[16].isHovering){
      if(acel){
        acel=false;
      }else{
        acel=true;
      }
    }
    //Aquí se crea el archivo CSV con los datos de las variables
    if(button[17].isHovering){
       Table table= new Table();
       table.addColumn(txt[29][0]);
       if(pos){
         table.addColumn(txt[20][0]);
       }
       if(vel){
         table.addColumn(txt[21][0]);
       }
       if(acel){
         table.addColumn(txt[22][0]);
       }
      
       float j=0;
       for(int i=0; i<mat.length; i++){
         TableRow newRow = table.addRow();
         newRow.setFloat(txt[29][0], j);
         if(pos){
           newRow.setFloat(txt[20][0], mat[i][0]);
         }
         if(vel){
           newRow.setFloat(txt[21][0], mat[i][1]);
         }
         if(acel){
           newRow.setFloat(txt[22][0], mat[i][2]);
         }
         j+=0.01666666666666666666666666666667;
       }
       saveTable(table, txt[30][0]+".csv");
    }
    if(button[18].isHovering){
      page=0;
      mat= new float[1][3];
      xPan[0]=1045;
      xPan[1]=1045;
      xPan[2]=1045;
      nX[0]=0;
      nX[1]=0;
      nX[2]=0;
      for(int i=0; i<7; i++){
        t[i]="1";
      }
    }
    break;
  }
}
//Esta función sirve en los textfield para introducir los valores que se usan en las ecuaciones
void keyPressed(){
  if(tb>=0){
    if((int)key>=48 && (int)key<=57 && t[tb].length()<17){
      t[tb] = t[tb] + key;
    }else if((int)key==46 && tp[tb]==false && t[tb].length()<17){
      t[tb]=t[tb].concat(".");
      tp[tb]=true;
      tpN[tb]=t[tb].length();
    }else if((int)key==8 && t[tb].length()!=0){
      t[tb]= t[tb].substring( 0 , t[tb].length()- 1 );
      if(t[tb].length()<tpN[tb]){
        tp[tb]=false;
      }
    }else if((int)key==127){
      t[tb]= "";
      tp[tb]=false;
    }
  }
}

//Sirve para cambiar el lenguaje si se presiona el botón
void language(){
  if(idiom){
    surface.setTitle("Simulation of Oscillatory Systems");
    idiom=false;
  }else{
    surface.setTitle("Simulacion de Sistemas Oscilatorios");
    idiom=true;
  }
  
  String tmp[]= new String[txt.length];
  for(int i=0; i<txt.length; i++){
    tmp[i]=txt[i][0];
    txt[i][0]=txt[i][1];
    txt[i][1]=tmp[i];
  }
  
  PImage tmpImg;
  for(int i=0; i<5; i++){
    tmpImg=img[i][0].get();
    img[i][0]=img[5+i][0].get();
    img[5+i][0]=tmpImg.get();
    
    img[i][1]=img[i][0].get();
    img[i][1].resize(width, height);
  }
  
  button[0]= new Button(txt[0][0], 20, 640, 320, 400, 40);
  button[1]= new Button(txt[1][0], 20, 640, 380, 400, 40);
  button[2]= new Button(txt[2][0], 20, 640, 440, 400, 40);
  button[3]= new Button(txt[3][0], 20, 55, 35, 80, 40);
  button[5]= new Button(txt[5][0], 20, 210, 180, 400, 40);
  button[6]= new Button(txt[7][0], 20, 210, 240, 400, 40);
  button[7]= new Button(txt[9][0], 20, 210, 300,  400, 40);
  button[8]= new Button(txt[11][0], 20, 85, 690, 150, 40);
  button[9]= new Button(txt[12][0], 20, 1195, 690, 150, 40);
  button[17]= new Button(txt[27][0], 20, 640, 460, 160, 40);
  button[18]= new Button(txt[28][0], 20, 1195, 690, 150, 40);
}

//Ajusta la escala si de los gráficos con la rueda del mouse
void mouseWheel(MouseEvent event){
  if(page==3){
    int e = event.getCount();
  if(mouseX>400*width/1280 & mouseX<800*width/1280 & mouseY>20*height/720 & mouseY<660*height/720){
    if(e>0){
        scaleG[3]/=1.05;
        scaleP[3]/=1.05;
      }else{
        scaleG[3]*=1.05;
        scaleP[3]*=1.05;
      }
  }
  if(mouseX>820*width/1280 & mouseX<1270*width/1280){
    if(mouseY>20*height/720 & mouseY<220*height/720){
      if(e>0){
        scaleG[0]/=1.05;
        scaleP[0]/=1.05;
      }else{
        scaleG[0]*=1.05;
        scaleP[0]*=1.05;
      }
    }
    if(mouseY>240*height/720 & mouseY<440*height/720){
      if(e>0){
        scaleG[1]/=1.05;
        scaleP[1]/=1.05;
      }else{
        scaleG[1]*=1.05;
        scaleP[1]*=1.05;
      }
    }
    if(mouseY>460*height/720 & mouseY<660*height/720){
      if(e>0){
        scaleG[2]/=1.05;
        scaleP[2]/=1.05;
      }else{
        scaleG[2]*=1.05;
        scaleP[2]*=1.05;
      }
    }
  }
  }
}

//Se cerciora si el mouse está siendo movido para trasladarse por los gráficos
void mouseDragged(MouseEvent event) {
  if(page==3){
    if(mouseX>400*width/1280 & mouseX<800*width/1280 & mouseY>20*height/720 & mouseY<660*height/720){
      xPan[3] = xPan[3]+(mouseX - pmouseX);
      yPan[3] = yPan[3]+(mouseY - pmouseY);
      nX[3] = nX[3]+(mouseX - pmouseX);
      nY[3]= nY[3]+(mouseY - pmouseY);
  }
  if(mouseX>820*width/1280 & mouseX<1270*width/1280){
    if(mouseY>20*height/720 & mouseY<220*height/720){
      xPan[0] = xPan[0]+(mouseX - pmouseX);
      yPan[0] = yPan[0]+(mouseY - pmouseY);
      nX[0]= nX[0]+(mouseX - pmouseX);
      nY[0]= nY[0]+(mouseY - pmouseY);
    }
    if(mouseY>240*height/720 & mouseY<440*height/720){
      xPan[1] = xPan[1]+(mouseX - pmouseX);
      yPan[1] = yPan[1]+(mouseY - pmouseY);
      nX[1]= nX[1]+(mouseX - pmouseX);
      nY[1]= nY[1]+(mouseY - pmouseY);
    }
    if(mouseY>460*height/720 & mouseY<660*height/720){
      xPan[2] = xPan[2]+(mouseX - pmouseX);
      yPan[2] = yPan[2]+(mouseY - pmouseY);
      nX[2]= nX[2]+(mouseX - pmouseX);
      nY[2]= nY[2]+(mouseY - pmouseY);
    }
  }
  }
}

//Dibuja los planos cartesianos
void dibujar(int k){
  if(scaleP[k]>2){
    scaleG[k]= r[k]*2;
    r[k]=scaleG[k];
    scaleP[k]=1;
    x[k]/=0.5;
  }
  if(scaleP[k]<0.5){
    scaleG[k]= r[k]/2;
    r[k]= scaleG[k];
    scaleP[k]=1;
    x[k]*=0.5;
  }
  if(k!=3){
    pushMatrix();
    translate(0,0);
    textAlign(RIGHT);
    translate(xPan[k], yPan[k]);
    scale(scaleP[k]);
    for (int i=-(int)(225/scaleP[k])-(int)(nX[k]/scaleP[k]); i<(int)(225/scaleP[k])-(int)(nX[k]/scaleP[k]); i++) {
      if (i%60==0) {
        if (i==0) {
          strokeWeight(2);
        } else {
          strokeWeight(1);
        }
        stroke(105, 105, 105);
        line(i, -100/scaleP[k]-nY[k]/scaleP[k], i, 100/scaleP[k]-nY[k]/scaleP[k]);
        fill(0);
        if(i>-(int)(225/scaleP[k])-(int)(nX[k]/scaleP[k]) && i<(int)(225/scaleP[k])-(int)(nX[k]/scaleP[k])){
          if(15/scaleP[k]>-(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k]) && 15/scaleP[k]<(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k])){
            text(String.valueOf((float)(i/60)/x[k]), i-10, 15);
          }
        }
      }
      if (i%10==0) {
        strokeWeight(0.5);
        stroke(211, 211, 211);
        line(i, -100/scaleP[k]-nY[k]/scaleP[k], i, 100/scaleP[k]-nY[k]/scaleP[k]);
      }
    }
  
    for (int i=-(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k]); i<(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k]); i++) {
      if (i%60==0) {
  
        if (i==0) {
          strokeWeight(2);
        } else {
          strokeWeight(1);
        }
        stroke(105, 105, 105);
        line(-225/scaleP[k]-nX[k]/scaleP[k], i, 225/scaleP[k]-nX[k]/scaleP[k], i);
  
        if (i!=0) {
          fill(0);
          if(i>-(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k]) && i<(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k])){
            if(-10/scaleP[k]>-(int)(225/scaleP[k])-(int)(nX[k]/scaleP[k]) && -10/scaleP[k]<(int)(225/scaleP[k])-(int)(nX[k]/scaleP[k])){
              text(String.valueOf((float)(i/60)/x[k]), -10, i+5);
            }
          }
        }
      }
  
      if (i%10==0) {
        strokeWeight(0.5);
        stroke(211, 211, 211);
        line(-225/scaleP[k]-nX[k]/scaleP[k], i, 225/scaleP[k]-nX[k]/scaleP[k], i);
      }
    }
    popMatrix();
    pushMatrix();
    translate(0,0);
    translate(xPan[k], yPan[k]);
    scale(scaleG[k]);
    switch(k){
      case 0:
      stroke(255,0,0);
      break;
      case 1:
      stroke(0,255,0);
      break;
      case 2:
      stroke(0,0,255);
      break;
      }
    strokeWeight(1/scaleG[k]);
    for(int i=1; i<mat.length; i++){
      if(((int)(i-1)*r[k])>((int)(-225/scaleP[k])-(int)(nX[k]/scaleP[k])) && (int)((i)*r[k])<((int)(225/scaleP[k])-(int)(nX[k]/scaleP[k]))){
        if((int)((60*mat[i][k])*r[k])>(-(int)(100/scaleP[k])-(int)(nY[k]/scaleP[k])) && (int)((60*mat[i-1][k])*r[k])<((int)(100/scaleP[k])-(int)(nY[k]/scaleP[k]))){
          line(i-1, 60*mat[i-1][k], i, 60*mat[i][k]);
        }
        
      }
    }
    popMatrix();
    
  }else{
    pushMatrix();
    translate(0,0);
    textAlign(RIGHT);
    translate(xPan[k], yPan[k]);
    scale(scaleP[k]);
    for (int i=-(int)(200/scaleP[k])-(int)(nX[k]/scaleP[k]); i<(int)(200/scaleP[k])-(int)(nX[k]/scaleP[k]); i++) {
      if (i%60==0) {
        if (i==0) {
          strokeWeight(2);
        } else {
          strokeWeight(1);
        }
        stroke(105, 105, 105);
        line(i, -320/scaleP[k]-nY[k]/scaleP[k], i, 320/scaleP[k]-nY[k]/scaleP[k]);
        fill(0);
        if(i>-(int)(200/scaleP[k])-(int)(nX[k]/scaleP[k]) && i<(int)(200/scaleP[k])-(int)(nX[k]/scaleP[k])){
          if(15/scaleP[k]>-(int)(320/scaleP[k])-(int)(nY[k]/scaleP[k]) && 15/scaleP[k]<(int)(320/scaleP[k])-(int)(nY[k]/scaleP[k])){
            text(String.valueOf((float)(i/60)/x[k]), i-10, 15);
          }
        }
      }
      if (i%10==0) {
        strokeWeight(0.5);
        stroke(211, 211, 211);
        line(i, -320/scaleP[k]-nY[k]/scaleP[k], i, 320/scaleP[k]-nY[k]/scaleP[k]);
      }
    }
  
    for (int i=-(int)(320/scaleP[k])-(int)(nY[k]/scaleP[k]); i<(int)(320/scaleP[k])-(int)(nY[k]/scaleP[k]); i++) {
      if (i%60==0) {
  
        if (i==0) {
          strokeWeight(2);
        } else {
          strokeWeight(1);
        }
        stroke(105, 105, 105);
        line(-200/scaleP[k]-nX[k]/scaleP[k], i, 200/scaleP[k]-nX[k]/scaleP[k], i);
  
        if (i!=0) {
          fill(0);
          if(i>-(int)(320/scaleP[k])-(int)(nY[k]/scaleP[k]) && i<(int)(320/scaleP[k])-(int)(nY[k]/scaleP[k])){
            if(-10/scaleP[k]>-(int)(200/scaleP[k])-(int)(nX[k]/scaleP[k]) && -10/scaleP[k]<(int)(200/scaleP[k])-(int)(nX[k]/scaleP[k])){
              text(String.valueOf((float)(i/60)/x[k]), -10, i+5);
            }
          }
        }
      }
  
      if (i%10==0) {
        strokeWeight(0.5);
        stroke(211, 211, 211);
        line(-200/scaleP[k]-nX[k]/scaleP[k], i, 200/scaleP[k]-nX[k]/scaleP[k], i);
      }
    }
    popMatrix();
    pushMatrix();
    translate(0,0);
    translate(xPan[k], yPan[k]);
    scale(scaleG[k]);
    
    if(type==0){
      rectMode(CENTER);
    if(A>=10){
      fill(0);
      rect(180*A/10,-(abs(60*mat[0][0]))-210*A/10,240*A/10,60*A/10);
      fill(192,192,192);
      rectMode(LEFT);
      rect(150*(A/10)+(15/A)*mat[mat.length-1][0],-(abs(60*mat[0][0]))-180*A/10,210*A/10-(15/A)*mat[mat.length-1][0],60*mat[mat.length-1][0]-60);
      fill(255,165,0);
      rectMode(CENTER);
      rect(180*A/10,60*mat[mat.length-1][0],120*A/10,120*A/10);
      
    }else if(A<1){
      fill(0);
      rect(180*A,-(abs(60*mat[0][0]))-210*A,240*A,60*A);
      fill(192,192,192);
      rectMode(LEFT);
      rect(150*A+(15*A)*mat[mat.length-1][0],-(abs(60*mat[0][0]))-180*A,210*A-(15*A)*mat[mat.length-1][0],60*mat[mat.length-1][0]-60*A);
      fill(255,165,0);
      rectMode(CENTER);
      rect(180*A,60*mat[mat.length-1][0],120*A,120*A);
    }else{
      fill(0);
      rect(180,-(abs(60*mat[0][0]))-210,240,60);
      fill(192,192,192);
      rectMode(LEFT);
      rect(150+(15/A)*mat[mat.length-1][0],-(abs(60*mat[0][0]))-180,210-(15/A)*mat[mat.length-1][0],60*mat[mat.length-1][0]-60);
      fill(255,165,0);
      rectMode(CENTER);
      rect(180,60*mat[mat.length-1][0],120,120);
    }
    }else{
      rectMode(CENTER);
    if(A>=10){
      fill(0);
      rect(360*A/10,-60*(F)-(abs(60*mat[0][0]))-210*A/10,480*A/10,60*A/10);
      fill(192,192,192);
      rectMode(LEFT);
      rect(360*(A/10)+(15/(A+F))*mat[mat.length-1][0],-60*(F)-(abs(60*mat[0][0]))-180*A/10,430*A/10-(15/(A+F))*mat[mat.length-1][0],60*mat[mat.length-1][0]-60);
      fill(119,136,153);
      rect(280*(A/10),-60*(F)-(abs(60*mat[0][0]))-180*A/10,320*(A/10),60*mat[mat.length-1][0]-60);
      fill(255,165,0);
      rectMode(CENTER);
      rect(360*A/10,60*mat[mat.length-1][0],240*A/10,120*A/10);
      
    }else if(A<1){
      fill(0);
      rect(360*A,-60*(F)-(abs(60*mat[0][0]))-210*A,480*A,60*A);
      fill(192,192,192);
      rectMode(LEFT);
      rect(360*A+(15/(A+F))*mat[mat.length-1][0],-60*(F)-(abs(60*mat[0][0]))-180*A,430*A-(15/(A+F))*mat[mat.length-1][0],60*mat[mat.length-1][0]-60*A);
      fill(119,136,153);
      rect(280*A,-60*(F)-(abs(60*mat[0][0]))-180*A,320*A,60*mat[mat.length-1][0]-60*A);
      fill(255,165,0);
      rectMode(CENTER);
      rect(360*A,60*mat[mat.length-1][0],240*A,120*A);
    }else{
      fill(0);
      rect(360,-60*(F)-(abs(60*mat[0][0]))-210,480,60);
      fill(192,192,192);
      rectMode(LEFT);
      rect(360+(15/(A+F))*mat[mat.length-1][0],-60*(F)-(abs(60*mat[0][0]))-180,430-(15/(A+F))*mat[mat.length-1][0],60*mat[mat.length-1][0]-60);
      fill(119,136,153);
      rect(280,-60*(F)-(abs(60*mat[0][0]))-180,320,60*mat[mat.length-1][0]-60);
      fill(255,165,0);
      rectMode(CENTER);
      rect(360,60*mat[mat.length-1][0],240,120);
    }
    }
    
    
    noFill();
    popMatrix();
  }
  
}
//La clase que describe a cada botón
class Button{
  boolean isHovering;
  String txt;
  float txtsize, x, y, w, h;
  
  //Recibe las variables de cada boton
  Button(String label, float lblsize, float posX, float posY, float Width, float Height){
    txt= label;
    txtsize= lblsize;
    x= posX;
    y= posY;
    w= Width;
    h= Height;
  }
  
  void display(){
    //Dibuja el boton
    rectMode(CENTER);
    fill(isHovering? color(0,0,0) : color(105,105,105));
    stroke(0);
    strokeWeight(4);
    rect(x,y,w,h);
    
    //Dibuja el texto del boton
    textAlign(CENTER);
    textSize(txtsize);
    fill(255);
    if(height>=720){
      text(txt, x, y+7/((0+height)/720));
    }else{
      text(txt, x, y+7);
    }
  }
  //Verifica si el cursor esta dentro del boton
  boolean isInside() {
    return isHovering = mouseX > (x-w/2)*width/1280 & mouseX < (x+w/2)*width/1280 & mouseY > (y-h/2)*height/720 & mouseY < (y+h/2)*height/720;
  }
}
