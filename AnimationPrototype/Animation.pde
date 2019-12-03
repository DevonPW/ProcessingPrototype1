//Animation Class
class Anim {
  Anim(){//default constructor
  }
  Anim(int n, String name_, int numFrames_, float fps_, int loopType_){//constructor
    num = n;
    name = name_;
    numFrames = numFrames_;
    fps = fps_;
    frameTime = 1000 / fps;//1000 milliseconds / frames per second
    loopType = loopType_;
    
    prevFrameTime = -1;
    currentFrameNum = 0;
  }
  
  //variables
  int num;//number of the animation
  String name;//name of the animation
  int numFrames;//number of frames in the animation
  float fps;//frame rate of animation
  float frameTime;//time to display each frame
  int loopType;//whether animation loops, boomerangs, or doesn't loop
  
  float prevFrameTime;//time at which animation last changed frames
  int currentFrameNum;//the frame of the animation which is currently being displayed
  int frameIncrement = 1;//number of frames to increment the animation, should be 1
  int[] frameSequence;//the order frames appear in the animation
  
  //methods
  boolean update(){//check for updates to animation
    if (prevFrameTime == -1){//animation is not started yet
      prevFrameTime = millis();//setting start time to current time
      return true;
    }
    else{//is already running
      if (millis() - prevFrameTime >= frameTime){
        //display next frame of animation
        prevFrameTime = millis();
        currentFrameNum += frameIncrement;
        //looping animations
        if (loopType == 1 && currentFrameNum >= numFrames){
          currentFrameNum = 0;//resetting to first frame
        }
        //boomerang animations
        else if (loopType == 2 && currentFrameNum >= numFrames || currentFrameNum < 0){
          frameIncrement *= -1;//reversing play order of animation
        }
        return true;//update frame
      }
      return false;//don't try to update frame
    }
  }
  
  void stop(){//stop running animation and reset to first frame
    prevFrameTime = -1;
    currentFrameNum = 0;
  }
  
  void pause(){//stop running animation, but will resume from current frame
    prevFrameTime = -1;
  }
  
  void setFrameSequences(int[] sequence){
    frameSequence = sequence;
  }
}
