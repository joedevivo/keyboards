difference(){
  cube(size = [126.01, 77.85, 20]);
  union(){
    translate(v = [7, 0, 0]){
      translate(v = [0, 0, -2]){
        rotate(a = [5.147, 0, 0]){
          union(){
            translate(v = [0, 0, 4]){
              difference(){
                union(){
                  translate(v = [18.075, 16.775, 0]){
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                  translate(v = [94.265, 16.775, 0]){
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                  translate(v = [94.265, 52.665000000000006, 0]){
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                  translate(v = [14.645, 71.36500000000001, 0]){
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                  translate(v = [-1, 0, 1]){
                    cube(size = [114.01, 100, 100]);
                  }
                  translate(v = [-8, 0, 4]){
                    cube(size = [142.01, 100, 100]);
                  }
                  translate(v = [2, 4, 0]){
                    cube(size = [109.01, 177.85, 11.7]);
                  }
                  translate(v = [96.01, 68.85, -10]){
                    cube(size = [26, 17, 25]);
                  }
                }
                translate(v = [18.075, 16.775, 0]){
                  difference(){
                    cylinder($fn = 20, d = 8, h = 1);
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                }
                translate(v = [94.265, 16.775, 0]){
                  difference(){
                    cylinder($fn = 20, d = 8, h = 1);
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                }
                translate(v = [94.265, 52.665000000000006, 0]){
                  difference(){
                    cylinder($fn = 20, d = 8, h = 1);
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                }
                translate(v = [14.645, 71.36500000000001, 0]){
                  difference(){
                    cylinder($fn = 20, d = 8, h = 1);
                    translate(v = [0, 0, -2.05]){
                      cylinder($fn = 20, d = 1.85, h = 3.75);
                    }
                  }
                }
              }
            }
            union(){
              translate(v = [-1.5, 0, 0]){
                translate(v = [19.3, 43.5, 0]){
                  cube(size = [19.88, 133.44, 8]);
                }
              }
            }
            translate(v = [11.5, 37, 0]){
              cube();
            }
          }
        }
      }
      translate(v = [-10, -10, -150]){
        cube(size = [150, 150, 150]);
      }
    }
  }
}
