
//按空格和a 来控制

int num;    //种子点的数量，也是格子的数量

float[]seedX;  //种子点的各个属性
float[]seedY;

float[]xspd;
float[]yspd;

color[]col;

int unit=40;  //每个种子点都在自己的小房间（小格子）里运动，这里是每个格子的尺寸
float range=1.5;  //种子点在x，y方向上的速度值都是一个 (-range,range) 之间的随机值
int wd, ht;  //格子的数量，wd是每排的数量，ht是每列的数量

boolean showAux=true;    //是否画网格线
boolean showVoronoi=false;  //是否渲染 voronoi

void setup() {
  size(800, 800);


  wd=width/unit;    //计算格子数量
  ht=height/unit;

  num=wd*ht;    //格子数量就是种子点数量

  seedX=new float[num];
  seedY=new float[num];
  xspd=new float[num];
  yspd=new float[num];
  col=new color[num];
  for (int i=0; i<num; i++) {
    int x=i%wd;
    int y=i/wd;

    seedX[i]=random(x*unit, (x+1)*unit);
    seedY[i]=random(y*unit, (y+1)*unit);

    col[i]=color(random(150, 255), random(150, 255), random(150, 255));

    
    xspd[i]=random(-range, range);
    yspd[i]=random(-range, range);
  }
}

void draw() {
  background(255);

  if (showAux) {
    colorCell();  //画辅助线网格
  }

  for (int i=0; i<num; i++) {    //对于每一个格子
    int x=i%wd;                //计算这个格子位于第几列，第几排，列和排的序号从0开始
    int y=i/wd;

    seedX[i]+=xspd[i];
    if (seedX[i]>(x+1)*unit || seedX[i]<x*unit) {    
      xspd[i]*=-1;          //碰到左右墙壁后弹回，注意这里每个格子的左右墙壁的横坐标都是不一样的
    }                        //用列号乘以格子宽度算出

    seedY[i]+=yspd[i];
    if (seedY[i]>(y+1)*unit || seedY[i]<y*unit) {
      yspd[i]*=-1;
    }
  }


  if (showVoronoi) {  //绘制voronoi
    loadPixels();
    for (int i=0; i<pixels.length; i++) {    
      int index=0;
      float minDist=999999;

      int x=i%width;  //像素点的位置
      int y=i/width;

      int cellX=x/unit;    //算出像素点所在格子是第几列，第几排
      int cellY=y/unit;


      //双层for循环，建立一个3*3=9个格子的小方阵，遍历这9个格子
      for (int cx=cellX-1; cx<=cellX+1; cx++) {    
        for (int cy=cellY-1; cy<=cellY+1; cy++) {
          if (cx>=0 && cx<wd && cy>=0 && cy<ht) {  //位于窗口边缘的格子凑不齐八个邻居，这一行代码用来确认某个邻居真的存在
            int j=cy*wd+cx;

            if (dist(x, y, seedX[j], seedY[j])<minDist) {    //从9个格子（种子点）中找到最近的种子点
              minDist=dist(x, y, seedX[j], seedY[j]);
              index=j;
            }
          }
        }
      }
      pixels[i]=color(map(minDist, 0, unit*1.0, 0, 255));
    }
    updatePixels();
  }


  if (showAux) {
    fill(0);
    for (int i=0; i<num; i++) {
      ellipse(seedX[i], seedY[i], 6, 6);
    }

    drawGrid();
  }
  surface.setTitle(nf(frameRate, 0, 2));
}


void drawGrid() {
  stroke(0);
  for (int x=0; x<wd; x++) {
    line(x*unit, 0, x*unit, height);
  }
  for (int y=0; y<ht; y++) {
    line(0, y*unit, width, y*unit);
  }
}

void keyPressed() {
  if (key==' ') {
    showVoronoi=!showVoronoi;
  }

  if (key=='a') {
    showAux=!showAux;
  }
}

void colorCell() {
  int xx=int(mouseX/unit);
  int yy=int(mouseY/unit);
  noStroke();
  fill(#7EE7F0);
  rect((xx-1)*unit, (yy-1)*unit, unit*3, unit*3);
  fill(#609CED);
  rect(xx*unit, yy*unit, unit, unit);
}
