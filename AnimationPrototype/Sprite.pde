//Sprite Class
class Sprite{
  Sprite(){//default constructor
    super();//calling PImage default constructor
  }
  
  Sprite(String fileName){
    imageFile = fileName + ".png";
    dataFile = fileName + ".spt";
    sequenceFile = fileName + ".fsq";
    
    animations = new ArrayList<Anim>();
    currentAnim = null;
    
    verticalAnims = false;
    fsq = false;
    
    spriteSheet = loadImage(imageFile);//loading sprite sheet
    initData();//getting data for sprite sheet
    
    currentFrame = new PImage();
    setFrame(0, 0);//first frame in sprite sheet's top left corner
  }
  
  //variables
  String imageFile;//name of the image file (.png)
  String dataFile;//name of the sprite data file (.spt)
  String sequenceFile;//name of the frame sequence file (.fsq), optional
  
  PImage currentFrame;//current fame of sprite sheet to display
  PImage spriteSheet;//stores the sprite's sprite sheet
  
  int frameWidth, frameHeight;//size of a single frame in pixels, all sprites on a sheet must be same size (22 x 19)
  
  ArrayList<Anim> animations;//list of animations contained in the sprite sheet
  boolean verticalAnims;//whether animations are lined up vertically or horizontally
  boolean fsq;//whether a framesequence (.fsq) file is used
  
  Anim currentAnim;//animation sprite is currently running
  
  //methods
  void updateAnim(){//called every frame to update animations
    if (currentAnim != null){
      if (currentAnim.update() == true){
        int frameX = 0;//x coordinate of the next frame
        int frameY = 0;//y coordinate of the next frame
        if (verticalAnims == true){//sprites are aligned in vertical colunms
          frameX = frameWidth * currentAnim.num;//getting x coordiante of sprite
          frameY = frameHeight * currentAnim.currentFrame;//getting y coordinate of sprite
        }
        else{//sprites are aligned in horizontal rows
          frameY = frameHeight * currentAnim.num;//getting y coordinate of sprite
          frameX = frameWidth * currentAnim.currentFrame;//getting x coordiante of sprite
        }
        setFrame(frameX, frameY);
      }
    }
  }
  
  void setAnim(String animName){//set the animation to run by it's name
    if (currentAnim != null){
      currentAnim.pause();//stopping previous animation
    }
    for (int i = 0; i < animations.size(); i++){
      if (animations.get(i).name.equals(animName)){
        currentAnim = animations.get(i);//setting currentAnim to point to the desired animation
        currentAnim.restart();
        break;
      }
    }
  }
  void setAnim(int num){//set the animation to run by it's number
    if (currentAnim != null){
      currentAnim.pause();//stopping previous animation
    }
    currentAnim = animations.get(num);//setting currentAnim to point to the desired animation
  }
  
  void setFrame(int x, int y){//sets frame of sprite sheet to be diplayed on screen
    currentFrame = spriteSheet.get(x, y, frameWidth, frameHeight);
  }
  
  void initData(){//gets data from sprite data files
    BufferedReader reader;
    String line;
    
    //getting sprite data file
    try {
      reader = createReader(dataFile);
      
      int lineNum = 0;
      while ((line = reader.readLine()) != null){
        if (line.charAt(0) != '#'){//ignore lines starting with #, comment lines
        
          String[] data = line.split(",");//separating line into chunks, by commas
          
          if (lineNum == 0){//first line of file
              frameWidth = Integer.parseInt(data[0]);//storing number as integer, getting frame width
              frameHeight = Integer.parseInt(data[1]);//getting frame height
              
              //getting alignment of animation frames
              if (data.length > 2 && (data[2].equals("vertical") || data[2].equals("Vertical") || data[2].equals("VERTICAL"))){
                verticalAnims = true;
              }
              //getting whether a frame sequence file is used or not
              if (data.length > 3 && (data[3].equals("fsq") || data[2].equals("framesequence") || data[2].equals("FSQ"))){
                fsq = true;
              }
          }
          else{//rest of lines
           //getting if animation loops or not
           int loopType = 0;//if not specified, animation will not loop by default
            if (data.length > 3 && data[3].equals("loop")){
                loopType = 1;
            }
            else if (data.length > 3  && data[3].equals("boomerang")){
              loopType = 2;
            }
            Anim a = new Anim(lineNum - 1, data[0], Integer.parseInt(data[1]), Float.parseFloat(data[2]), loopType);//getting data for animation
            animations.add(a);//adding animation to animation list
          }
          lineNum++;//incrementing line number
        }
        
      }
    }catch (IOException e){
      e.printStackTrace();
      line = null;
    }
    
    //getting frame sequence data file
    if (fsq == true){
      try {
        reader = createReader(sequenceFile);
        
        int lineNum = 0;
        while ((line = reader.readLine()) != null){
          if (line.charAt(0) != '#'){//ignore lines starting with #, comment lines
            
            if (line.charAt(0) != 'n' && line.charAt(0) != 'N'){//ignore lines starting with n, means animation doesn't have custom sequence
              String[] data = line.split(",");//separating line into chunks, by commas
              
              //putting numbers into an array
              ArrayList<Integer> sequence = new ArrayList<Integer>();
              for (int i = 0; i < data.length; i++){
                sequence.add(Integer.parseInt(data[i]));
              }
              
              animations.get(lineNum).setFrameSequences(sequence);//setting frame sequence of corresponding animation
            }
            else{//setting frame sequence to default frame sequence array [0, 1, 2, 3, 4,...etc]
              ArrayList<Integer> sequence = new ArrayList<Integer>();
              for (int j = 0; j < animations.get(lineNum).numFrames; j++){
                sequence.add(j);
              }
              animations.get(lineNum).setFrameSequences(sequence);//setting frame sequence of corresponding animation
            }
            
            lineNum++;//incrementing line number
          }
        }
      }catch (IOException e){
        e.printStackTrace();
        line = null;
      }
    }
    else{//if sprite does not have custom frame sequences
      for (int i = 0; i < animations.size(); i++){//creating default frame sqeuence array [0, 1, 2, 3, 4,...etc]
        ArrayList<Integer> sequence = new ArrayList<Integer>();
        for (int j = 0; j < animations.get(i).numFrames; j++){
          sequence.add(j);
        }
        animations.get(i).setFrameSequences(sequence);//setting frame sequence of corresponding animation
      }
    }
    
  }
}
