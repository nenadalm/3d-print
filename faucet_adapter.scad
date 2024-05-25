$fn = 32;
layer_width = 0.4;

cylinder_d = 36;
cylinder_h = 29;
cylinder_thickness = 5;

top_h = 5;

module part1() {
  difference() {
    cylinder(d = cylinder_d, h = cylinder_h);
    translate([0, 0, -1])
      cylinder(d = cylinder_d - cylinder_thickness, h = cylinder_h + 2);
  }
}

module part2() {
  difference() {
    union() {
      cylinder(d = 39, h = top_h + 1.5);
      translate([-74 / 2, -54 / 2, 0])
        cube([74, 54, top_h]);
    }
    translate([0, 0, -5])
      cylinder(d = cylinder_d, h = top_h + 10);
  }
}

part1();
part2();