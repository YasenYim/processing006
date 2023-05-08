int num=40;  //种子点的数量

float[]seedX;  //每个种子点的位置横坐标都放在一个数组里
float[]seedY;

float[]xspd;    //每个种子点的速度
float[]yspd;

color[]col;    //每个种子点的颜色

void setup() {
  size(800, 600);

  seedX=new float[num];  //初始化数组
  seedY=new float[num];
  xspd=new float[num];
  yspd=new float[num];
  col=new color[num];
  for (int i=0; i<num; i++) {  //为每一个小篮子赋值
    seedX[i]=random(width);
    seedY[i]=random(height);
    col[i]=color(random(150, 255), random(150, 255), random(150, 255));

    xspd[i]=random(-3, 3);
    yspd[i]=random(-3, 3);
  }
}


void draw() {
  for (int i=0; i<num; i++) {    //更新每一个种子点的位置
    seedX[i]+=xspd[i];
    if (seedX[i]>width || seedX[i]<0) {    //碰到左右墙壁后弹回
      xspd[i]*=-1;
    }

    seedY[i]+=yspd[i];
    if (seedY[i]>height || seedY[i]<0) {
      yspd[i]*=-1;
    }
  }

  loadPixels();              //把屏幕上所有像素的颜色载入到一个数组里
  for (int i=0; i<pixels.length; i++) {    //遍历每个像素点
    int index=0;              //求离当前像素点最近的种子点的编号
    float minDist=999999;    //先把一个极大的数假设为初始时的"离最近的种子点的距离"

    int x=i%width;          //每个像素的横纵坐标
    int y=i/width;
    for (int j=0; j<num; j++) {    //遍历一遍种子点

      if (dist(x, y, seedX[j], seedY[j])<minDist) {  //如果遇到更近的种子点
        minDist=dist(x, y, seedX[j], seedY[j]);    //就刷新"储存最近种子点"信息的变量
        index=j;
      }
    }

    pixels[i]=col[index];    //用最近的种子点对应的颜色来为当前像素点着色
  }
  updatePixels();    

  fill(0);
  for (int i=0; i<num; i++) {    //画出所有种子点
    ellipse(seedX[i], seedY[i], 6, 6);
  }
  
  surface.setTitle(nf(frameRate,0,2));  //把当前程序运行帧率写到窗口标题上，小数点后面保留两位数字
}

void mousePressed(){    //如果点击鼠标，程序停止刷新
  noLoop();
}
