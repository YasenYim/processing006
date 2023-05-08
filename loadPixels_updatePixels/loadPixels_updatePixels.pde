
size(800, 600);

loadPixels();
for (int i=0; i<pixels.length; i++) {
  pixels[i]=color(i%width*0.5, i/width, 255);
}

updatePixels();



// i%width 计算出该像素的横坐标， 
// i/width 计算出该像素的纵坐标，
// 这里用横纵坐标来控制 红绿通道值，
// 所以，每个像素的位置决定了自己是什么颜色
// 更改 位置-->通道值 的数值映射方式，可以玩出很多效果
