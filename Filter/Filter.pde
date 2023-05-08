PImage pic;

void setup() {
  size(1000, 600);
  colorMode(RGB);
  pic=loadImage("SH.jpg");
  pic.resize(width, height);

  image(pic, 0, 0);

  loadPixels();
  for (int i=0; i<pixels.length; i++) {
    //pixels[i]=color(hue(pixels[i]), 255, 255);
    pixels[i]=color(255-red(pixels[i]), 255-green(pixels[i]), 255);
    //color括号里的三个参数依次负责红绿蓝三个通道，这里通过 255-x 来使得红绿两个通道反色，蓝色通道不变
  }

  updatePixels();
}
