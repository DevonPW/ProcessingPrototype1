//Devon Poon Woo

//Sprite[] kirbys = new Sprite[768];

Sprite kirby, kirby2, kirby3;

void setup(){
   size(800, 600);//FX2D, faster 2D graphics maybe? nope it's worse for sprites apparently
   //setting frame rate
  frameRate(60);
  
  kirby = new Sprite("sprites/kirbySleep");
  kirby.setAnim("fallAsleep");//setting animation
  
  kirby2 = new Sprite("sprites/kirbySleep");
  kirby2.setAnim("sleep");//setting animation
  
  kirby3 = new Sprite("sprites/kirbySleep");
  kirby3.setAnim("wake");//setting animation
  
  /*
  for (int i = 0; i < kirbys.length; i++){
    kirbys[i] = new Sprite("sprites/kirbyRun");
    kirbys[i].setAnim("run");
  }*/
}

void draw(){
  background(0);
  
  kirby.updateAnim();
  kirby2.updateAnim();
  kirby3.updateAnim();
  
  image(kirby.currentFrame, width/2 - 30, height/2);//drawing sprite to screen
  image(kirby2.currentFrame, width/2, height/2);//drawing sprite to screen
  image(kirby3.currentFrame, width/2 + 30, height/2);//drawing sprite to screen
  
  /*
  int j = -1;
  int k = 0;
  
  for (int i = 0; i < kirbys.length; i++){
    if ((i * 25) % (width) < 25){
      j++;
      k = 0;
    }
    kirbys[i].updateAnim();
    image(kirbys[i].currentFrame, k * 25, j * 25);//drawing sprite to screen
    k++;
  }*/
}
