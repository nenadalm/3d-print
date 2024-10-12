$fn = 32;

difference() {
  cylinder(h = 15, d1 = 29, d2 = 22);
  translate([0, 0, 7.5 + 3 + 3]) {
    cylinder(h = 8, d = 15);
    sphere(d = 15);
  }
  translate([0, 0, -1])
    cylinder(h = 15, d = 4);
  translate([0, 0, 3])
    cylinder(h = 15, d = 7);
}
