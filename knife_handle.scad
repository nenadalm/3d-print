$fn = 2048;

clearance = 0.07;

width = 16;
height = 27;
length = 110;

tang_width = 3;
tang_height = 5;
tang_length = 55;

guard_r = 90;

intersection() {
difference() {
  linear_extrude(length) {
    translate([0, width / 2, 0]) {
      hull() {
        circle(d = width);
        translate([0, height - width, 0]) {
          circle(d = width);
        }
      }
    }
  }
  translate([-tang_width / 2 - clearance, -tang_height / 2 + height / 2 -clearance, length - tang_length + 1]) {
    cube([tang_width + clearance * 2, tang_height + clearance * 2 + 1, tang_length]);
  }
  translate([-tang_width / 2 - clearance - 1, -tang_height / 2 + height / 2 -clearance - 4, length - 4 + 1]) {
    cube([tang_width + clearance * 2 + 2, tang_height + clearance * 2 + 8 + 1, 4]);
  }
//  translate([-tang_width / 2 - clearance, -(tang_height + 4) / 2 + height / 2, length - 4 + 1])
//    cube([tang_width + clearance * 2, tang_height + clearance * 2 + 4, 4]);
}

translate([-width / 2, height / 2, -guard_r + length])
  rotate([0, 90, 0])
    cylinder(h = width, r = guard_r);
}
