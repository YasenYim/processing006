/*
胜利方法：

11000
11011
00111
01110
01101

*/


boolean[]state;  //我这里规定 true 是白色，false是黑色，这个25个元素的数组记录了25个格子的颜色信息

void setup(){
  size(500,500);
  state=new boolean[25];
  for(int i=0;i<state.length;i++){
    state[i]=true;    
  }
  
  for(int i=0;i<state.length;i++){  //用每个小篮子里的状态值填充相应的颜色
    if(state[i]){
      fill(255);
    }else{
      fill(0);
    }
    
    rect(i%5*100+5,i/5*100+5,90,90);
  }
    
}

void draw(){  //draw 里虽然是空的，但是这一段必不可少。有了void draw，程序才会持续刷新，持续监听鼠标动态
  
}

void mousePressed(){        //mousePressed() 描述的是鼠标按下之后会执行什么命令

  int col=int(mouseX/100);  //计算鼠标所在的格子的行号和列号
  int row=int(mouseY/100);
  int index=row*5+col;      //用行号列号算出对应的数组里的编号
  
  state[index]=!state[index];  //把鼠标所在的格子反色，
                               //注意！这里只是先修改小篮子里的值，目前还没有涂色
                               //修改篮子里的值是必要的，判断胜负时需要检查每一个小篮子里的值
  
  
  
  if(col>0){                    //修改上下左右的邻居的值
    state[index-1]=!state[index-1];
  }
  if(col<4){
    state[index+1]=!state[index+1];
  }
  if(row>0){
    state[index-5]=!state[index-5];    //注意这里如何用加减法来获取邻居格子在数组里的编号
  }
  if(row<4){
    state[index+5]=!state[index+5];
  }
  
  
  for(int i=0;i<state.length;i++){  //遍历一遍25个格子，根据状态给每个格子涂色
    if(state[i]){
      fill(255);
    }else{
      fill(0);
    }
    
    rect(i%5*100+5,i/5*100+5,90,90);
  }
  
  
  boolean win=true;      //判断胜负，这里先假设赢了
  for(int i=0;i<state.length;i++){  //遍历25个格子，
    if(state[i]==true){    //如果有任何一个格子是白色的，
      win=false;           //则假设不成立
      break;               //立刻中断循环
    }
  }                      //如果整个循环没有被中断，说明假设成立。
                          
  
  
  if(win){                //根据刚才检查出来的胜负状态决定是否在屏幕上写字
    textSize(48);
    fill(255,255,0);
    textAlign(CENTER,CENTER);
    text("Congratulations!",width/2,height/2);
  }
}
