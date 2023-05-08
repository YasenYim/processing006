int num=8;    //屏幕上一共八个小球
float[]xpos;  //八个横坐标放到一个数组里
float[]ypos;
float[]xspd;
float[]yspd;  //八个纵轴速度放到一个数组里
float margin=100;

void setup() {
  size(800, 600);
  colorMode(HSB);

  xpos=new float[num];  //初始化数组
  ypos=new float[num];
  xspd=new float[num];
  yspd=new float[num];
  for (int i=0; i<num; i++) {      //把具体的随机值放到每个小篮子里
    xpos[i]=random(margin,width-margin);
    ypos[i]=random(margin,height-margin);
    xspd[i]=random(-3,3);
    yspd[i]=random(-2,2);
  }
}

void draw() {
  
  for (int i=0; i<num; i++) {  //八个小球碰壁运动
    xpos[i]+=xspd[i];
    ypos[i]+=yspd[i];
    if(xpos[i]<margin || xpos[i]>width-margin){
      xspd[i]*=-1;
    }
    if(ypos[i]<margin || ypos[i]>height-margin){
      yspd[i]*=-1;
    }
  }
  

  loadPixels();    //载入所有像素颜色到一个数组里
  for (int i=0; i<pixels.length; i++) {  //对于每一个像素
    int x=i%width;      //先算出横纵坐标
    int y=i/width;

    float accum=0;  //计算此像素到八个小球的距离之和，accum用来累积距离
    for (int j=0; j<num; j++) {    //遍历八个小球
      float dist=dist(x, y, xpos[j], ypos[j]);  //算出到某一个小球的距离
      accum+=4000f/dist;  //这里可以有很多变体，我这里用倒数，使得距离越近，累积值越大，f表示float
    }

    pixels[i]=color(accum, accum, accum);  //用 accum 值映射颜色，这里也可以有很多变体
  }
  updatePixels();  //用更新后的颜色数据重新渲染屏幕
}
