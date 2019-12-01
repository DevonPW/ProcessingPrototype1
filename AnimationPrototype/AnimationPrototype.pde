
//Animation Class
class Anim {
  Anim(){//default constructor
  }
  Anim(int numFrames_, float speed_){//default constructor
    numFrames = numFrames_;
    speed = speed_;
  }
  
  //variables
  int numFrames;//number of frames in the animation
  float speed;//speed animation runs at
  
  //methods
  
  
}

//Sprite Class
class Sprite{
  Sprite(){//default constructor
    super();//calling PImage default constructor
  }
  
  Sprite(String fileName){
    imageFile = fileName + ".png";
    dataFile = fileName + ".spt";
    
    animations = new ArrayList<Anim>();
    
    spriteSheet = loadImage(imageFile);//loading sprite sheet
    initData();//getting data for sprite sheet
    
    currentFrame = new PImage();
    setFrame(0, 0);
  }
  
  //variables
  String imageFile;//name of the image file (.png)
  String dataFile;//name of the sprite data file (.spt)
  
  PImage currentFrame;//current fame of sprite sheet to display
  PImage spriteSheet;//stores the sprite's sprite sheet
  
  int frameWidth, frameHeight;//size of a single frame in pixels, all sprites on a sheet must be same size (22 x 19)
  
  ArrayList<Anim> animations;//list of animations contained in the sprite sheet
  
  //methods
  void setFrame(int x, int y){//sets frame of sprite sheet to be diplayed on screen
    currentFrame = spriteSheet.get(x, y, frameWidth, frameHeight); //<>//
    //currentFrame.copy(spriteSheet, x, y, frameWidth, frameHeight, 0, 0, frameWidth, frameHeight);//don't use this or the set function cuz apparently they don't work
  }
  
  void initData(){//gets data from sprite data file
    BufferedReader reader;
    String line;
    
    try {
      reader = createReader(dataFile);//getting sprite data file
      int lineNum = 0;
      
      while ((line = reader.readLine()) != null){
        if (line.charAt(0) != '#'){//ignore lines starting with #, comment lines
        
          String[] data = line.split(",");//separating line into chunks, by commas
          
          if (lineNum == 0){//first line of file
              frameWidth = Integer.parseInt(data[0]);//storing number as integer, getting frame width
              frameHeight = Integer.parseInt(data[1]);//getting frame height
          }
          else{//rest of lines
            Anim a = new Anim(Integer.parseInt(data[0]), Float.parseFloat(data[1]));//getting date for animation
            animations.add(a);//adding animation to animation list
          }
          lineNum++;//incrementing line number
        }
        
      }
    }catch (IOException e){
      e.printStackTrace();
      line = null;
    }
    
  }
}

Sprite kirby;//test sprite

void setup(){
   size(800, 600, FX2D);//FX2D = faster 2D graphics maybe
   //setting frame rate
  frameRate(60);
  
  kirby = new Sprite("sprites/kirbyRun");
}

void draw(){
  background(0);
  
  //kirby.setFrame(0, 0);
  image(kirby.currentFrame, width/2, height/2);
}
