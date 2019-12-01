
//Animation Class
class Anim {
  Anim(){//default constructor
  }
  Anim(int numFrames_, float speed_){//default constructor
  }
  
  //variables
  int numFrames;//number of frames in the animation
  float speed;//speed animation runs at
  
  //methods
  
  
}

//Sprite Class
class SpriteSheet extends PImage{
  SpriteSheet(){//default constructor
    super();//calling PImage default constructor
  }
  
  SpriteSheet(String fileName){
    imageFile = fileName + ".png";
    dataFile = fileName + ".spt";
    
    loadImage(imageFile);
    initData();
  }
  
  //variables
  String imageFile;//name of the image file (.png)
  String dataFile;//name of the sprite data file (.spt)
  
  int frameWidth, frameHeight;//size of a single frame in pixels, all sprites on a sheet must be same size (22 x 19)
  
  ArrayList<Anim> animations;//list of animations contained in the sprite sheet
  
  //methods
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

void setup(){
  
}

void draw(){
  SpriteSheet kirby = new SpriteSheet("sprites/kirbyRun");
  
  
}
