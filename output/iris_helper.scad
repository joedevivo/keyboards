difference(){
  translate(v = [-3, 0, 0]){
    union(){
      translate(v = [0, 0, 1.5]){
        cube(size = [7, 55.06, 11]);
      }
      translate(v = [17, 27.5, 10]){
        union(){
          union(){
            translate(v = [0, 8.7, 2.0]){
              cube(center = true, size = [20.4, 3, 4]);
            }
            translate(v = [0, -8.7, 2.0]){
              cube(center = true, size = [20.4, 3, 4]);
            }
            translate(v = [-8.7, 0, 2.0]){
              cube(center = true, size = [3, 20.4, 4]);
            }
            hull(){
              translate(v = [-7.95, 0, 2.0]){
                cube(center = true, size = [1.5, 2.75, 4]);
              }
              translate(v = [-7.2, 0, 1]){
                rotate(a = [90, 0, 0]){
                  cylinder($fn = 30, center = true, h = 2.75, r = 1);
                }
              }
            }
            translate(v = [8.7, 0, 2.0]){
              cube(center = true, size = [3, 20.4, 4]);
            }
            hull(){
              translate(v = [7.95, 0, 2.0]){
                cube(center = true, size = [1.5, 2.75, 4]);
              }
              translate(v = [7.2, 0, 1]){
                rotate(a = [90, 0, 0]){
                  cylinder($fn = 30, center = true, h = 2.75, r = 1);
                }
              }
            }
          }
          translate(v = [0, 0, 2.0]){
            difference(){
              cube(center = true, size = [20.4, 54.599999999999994, 4]);
              cube(center = true, size = [20.4, 20.4, 4]);
            }
          }
        }
      }
      translate(v = [7, 0, 0]){
        cube(size = [3, 55.06, 14]);
      }
      translate(v = [25.3, 0, 0]){
        cube(size = [3, 55.06, 14]);
      }
      translate(v = [7, 0, 0]){
        cube(size = [20.3, 4, 14]);
      }
      translate(v = [7, 51.06, 0]){
        cube(size = [20.3, 4, 14]);
      }
      translate(v = [7, 0, 0]){
        cube(size = [20.3, 55.06, 4]);
      }
    }
  }
  translate(v = [0, 25, 3]){
    cube(size = [10, 5, 5]);
  }
  translate(v = [-10, -1, 0]){
    cube(size = [10, 100, 100]);
  }
  translate(v = [0, -1, 0]){
    cube(size = [7, 100, 1.5]);
  }
  translate(v = [0, -1, 12.5]){
    cube(size = [7, 100, 1.5]);
  }
  translate(v = [0, 22.5, 12.5]){
    cube(size = [10, 10, 2]);
  }
  translate(v = [3.125, 3.925, 0]){
    cylinder($fn = 20, d = 3.2, h = 14);
  }
  translate(v = [3.125, 50.904999999999994, 0]){
    cylinder($fn = 20, d = 3.2, h = 14);
  }
}
