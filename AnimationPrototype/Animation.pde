//Animation Class
class Anim {
  Anim(){//default constructor
  }
  Anim(int n, String name_, int numFrames_, float fps_, boolean loop_){//constructor
    num = n;
    name = name_;
    numFrames = numFrames_;
    fps = fps_;
    frameTime = 1000 / fps;//1000 milliseconds / frames per second
    loop = loop_;
    
    prevFrameTime = -1;
    currentFrameNum = 0;
  }
  
  //variables
  int num;//number of the animation
  String name;//name of the animation
  int numFrames;//number of frames in the animation
  float fps;//frame rate of animation
  float frameTime;//time to display each frame
  boolean loop;//whether animation loops or not
  
  float prevFrameTime;//time at which animation last changed frames
  int currentFrameNum;//the frame of the animation which is currently being displayed
  
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
        currentFrameNum++;
        if (currentFrameNum >= numFrames && loop == true){
          currentFrameNum = 0;//resetting to first frame
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
}
