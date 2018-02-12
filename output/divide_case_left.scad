difference() {
  cube([126.01, 77.85, 20], center=false);
  union()
  translate([7, 0, 0]) {
    translate([0, 0, -2])
    rotate([5.147, 0, 0])
    union() {
      translate([0, 0, 4])
      difference() {
        union() {
          translate([18.075, 16.775, 0])
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
          translate([94.265, 16.775, 0])
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
          translate([94.265, 52.665000000000006, 0])
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
          translate([14.645, 71.36500000000001, 0])
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
          translate([-1, 0, 1])
          cube([114.01, 100, 100], center=false);
          translate([-8, 0, 4])
          cube([142.01, 100, 100], center=false);
          translate([2, 4, 0])
          cube([109.01, 177.85, 11.7], center=false);
          translate([96.01, 68.85, -10])
          cube([26, 17, 25], center=false);
        }
        translate([18.075, 16.775, 0])
        difference() {
          cylinder(h = 1, r1 = 4.0, r2 = 4.0, center = false, $fn = 20);
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
        }
        translate([94.265, 16.775, 0])
        difference() {
          cylinder(h = 1, r1 = 4.0, r2 = 4.0, center = false, $fn = 20);
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
        }
        translate([94.265, 52.665000000000006, 0])
        difference() {
          cylinder(h = 1, r1 = 4.0, r2 = 4.0, center = false, $fn = 20);
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
        }
        translate([14.645, 71.36500000000001, 0])
        difference() {
          cylinder(h = 1, r1 = 4.0, r2 = 4.0, center = false, $fn = 20);
          translate([0, 0, -2.05])
          cylinder(h = 3.75, r1 = 0.925, r2 = 0.925, center = false, $fn = 20);
        }
      }
      union()
      translate([-1.5, 0, 0])
      translate([19.3, 43.5, 0])
      cube([19.88, 133.44, 8], center=false);
      translate([11.5, 37, 0])
      cube([85, 12, 10], center=false);
    }
    translate([-10, -10, -150])
    cube([150, 150, 150], center=false);
  }
}
