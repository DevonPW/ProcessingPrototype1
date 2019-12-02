//Devon Poon Woo

Sprite[] kirbys = new Sprite[768];

Sprite kirby;

void setup(){
   size(800, 600);//FX2D, faster 2D graphics maybe? nope it's worse for sprites apparently
   //setting frame rate
  frameRate(60);
  
  //kirby = new Sprite("sprites/kirbyRun");
  //kirby.setAnim("run");//setting animation
  
  for (int i = 0; i < kirbys.length; i++){
    kirbys[i] = new Sprite("sprites/kirbyRun");
    kirbys[i].setAnim("run");
  }
}

void draw(){
  background(0);
  
  //kirby.updateAnim();
  //image(kirby.currentFrame, width/2, height/2);//drawing sprite to screen
  
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
  }
}
