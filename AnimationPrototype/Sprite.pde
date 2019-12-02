//Sprite Class
class Sprite{
  Sprite(){//default constructor
    super();//calling PImage default constructor
  }
  
  Sprite(String fileName){
    imageFile = fileName + ".png";
    dataFile = fileName + ".spt";
    
    animations = new ArrayList<Anim>();
    currentAnim = null;
    
    spriteSheet = loadImage(imageFile);//loading sprite sheet
    initData();//getting data for sprite sheet
    
    currentFrame = new PImage();
    setFrame(0, 0);//first frame in sprite sheet's top left corner
  }
  
  //variables
  String imageFile;//name of the image file (.png)
  String dataFile;//name of the sprite data file (.spt)
  
  PImage currentFrame;//current fame of sprite sheet to display
  PImage spriteSheet;//stores the sprite's sprite sheet
  
  int frameWidth, frameHeight;//size of a single frame in pixels, all sprites on a sheet must be same size (22 x 19)
  
  ArrayList<Anim> animations;//list of animations contained in the sprite sheet
  boolean verticalAnims;//whether animations are lined up vertically or horizontally
  
  Anim currentAnim;//animation sprite is currently running
  
  //methods
  void updateAnim(){//called every frame to update animations
    if (currentAnim != null){
      if (currentAnim.update() == true){
        int frameX = 0;//x coordinate of the next frame
        int frameY = 0;//y coordinate of the next frame
        if (verticalAnims == true){//sprites are aligned in vertical colunms
          frameX = frameWidth * currentAnim.num;//getting x coordiante of sprite
          frameY = frameHeight * currentAnim.currentFrameNum;//getting y coordinate of sprite
        }
        else{//sprites are aligned in horizontal rows
          frameY = frameHeight * currentAnim.num;//getting y coordinate of sprite
          frameX = frameWidth * currentAnim.currentFrameNum;//getting x coordiante of sprite
        }
        setFrame(frameX, frameY);
      }
    }
  }
  
  void setAnim(String animName){//set the animation to run by name
    if (currentAnim != null){
      currentAnim.stop();//stopping previous animation
    }
    for (int i = 0; i < animations.size(); i++){
      if (animations.get(i).name.equals(animName)){
        currentAnim = animations.get(i);//setting currentAnim to point to the desired animation
        break;
      }
    }
  }
  void setAnim(int num){//set the animation to run by it's number
    if (currentAnim != null){
      currentAnim.stop();//stopping previous animation
    }
    currentAnim = animations.get(num);//setting currentAnim to point to the desired animation
  }
  
  void setFrame(int x, int y){//sets frame of sprite sheet to be diplayed on screen
    currentFrame = spriteSheet.get(x, y, frameWidth, frameHeight);
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
              verticalAnims = Boolean.parseBoolean(data[2]);//getting alignment of animation frames
          }
          else{//rest of lines
            Anim a = new Anim(lineNum - 1, data[0], Integer.parseInt(data[1]), Float.parseFloat(data[2]), Boolean.parseBoolean(data[3]));//getting data for animation
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
