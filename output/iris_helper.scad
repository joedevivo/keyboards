difference() {
  translate([-3, 0, 0])
  union() {
    translate([0, 0, 1.5])
    cube([7, 55.06, 11], center=false);
    translate([17, 27.5, 10])
    union() {
      union() {
        translate([0, 8.7, 2.0])
        cube([20.4, 3, 4], center=true);
        translate([0, -8.7, 2.0])
        cube([20.4, 3, 4], center=true);
        translate([-8.7, 0, 2.0])
        cube([3, 20.4, 4], center=true);
        hull() {
          translate([-7.95, 0, 2.0])
          cube([1.5, 2.75, 4], center=true);
          translate([-7.2, 0, 1])
          rotate([90, 0, 0])
          cylinder(h = 2.75, r1 = 1, r2 = 1, center = true, $fn = 30);
        }
        translate([8.7, 0, 2.0])
        cube([3, 20.4, 4], center=true);
        hull() {
          translate([7.95, 0, 2.0])
          cube([1.5, 2.75, 4], center=true);
          translate([7.2, 0, 1])
          rotate([90, 0, 0])
          cylinder(h = 2.75, r1 = 1, r2 = 1, center = true, $fn = 30);
        }
      }
      translate([0, 0, 2.0])
      difference() {
        cube([20.4, 54.599999999999994, 4], center=true);
        cube([20.4, 20.4, 4], center=true);
      }
    }
    translate([7, 0, 0])
    cube([3, 55.06, 14], center=false);
    translate([25.3, 0, 0])
    cube([3, 55.06, 14], center=false);
    translate([7, 0, 0])
    cube([20.3, 4, 14], center=false);
    translate([7, 51.06, 0])
    cube([20.3, 4, 14], center=false);
    translate([7, 0, 0])
    cube([20.3, 55.06, 4], center=false);
  }
  translate([0, 25, 3])
  cube([10, 5, 5], center=false);
  translate([-10, -1, 0])
  cube([10, 100, 100], center=false);
  translate([0, -1, 0])
  cube([7, 100, 1.5], center=false);
  translate([0, -1, 12.5])
  cube([7, 100, 1.5], center=false);
  translate([0, 22.5, 12.5])
  cube([10, 10, 2], center=false);
  translate([3.125, 3.925, 0])
  cylinder(h = 14, r1 = 1.6, r2 = 1.6, center = false, $fn = 20);
  translate([3.125, 50.904999999999994, 0])
  cylinder(h = 14, r1 = 1.6, r2 = 1.6, center = false, $fn = 20);
}
