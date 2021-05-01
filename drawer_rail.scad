use <lib/shapes.scad>;

$fn = 32;

tolerance = 0.05;

groove_h = 8;
groove_w = 9.1;
w = 19.1;
d = 320;
h = 18;

half_d = d / 2;

joint_space = 3;
joint_size = [
  w - groove_w - 2 * joint_space,
  20,
  h - 2 * joint_space
];

first_screw = 15;
second_screw = 236;

wedge_h = 2;

module screw_hole() {
  union() {
    cylinder(h = 2, d1 = 7, d2 = 4);
    translate([0, 0, 2])
      cylinder(h = 2, d = 4);
    translate([0, 0, 2 + 2])
      cylinder(h = 30, d = 3);
  }
}

module joint() {
  translate([tolerance, 0, tolerance])
    cube([
      joint_size[0] - 2 * tolerance,
      joint_size[1] - 2 * tolerance,
      joint_size[2] - 2 * tolerance
    ]);
}

module joint_hole() {
  cube(joint_size);
}

module half() {
  difference() {
    cube([w, half_d, h]);
    translate([w - groove_w, 0, h / 2 - groove_h / 2])
      cube([groove_w, half_d, groove_h]);
  }
}

module first_half() {
  union() {
    difference() {
      half();
      translate([w - groove_w, first_screw, h / 2])
        rotate([0, -90, 0])
          screw_hole();
    }
    translate([
        joint_space,
        half_d,
        joint_space
      ])
      joint();
  }
}

module _second_half() {
  difference() {
    half();
    translate([
        joint_space,
        0,
        joint_space
      ])
      joint_hole();
  }
}

module second_half() {
  difference() {
    _second_half();
    translate([w, 0, h / 2 - groove_h / 2])
      rotate([180, 0, 180])
        shapes_wedge([groove_w, 20, wedge_h]);
    translate([w - groove_w, 0, h / 2 + groove_h / 2])
        shapes_wedge([groove_w, 20, wedge_h]);
    translate([w - groove_w, second_screw - half_d, h / 2])
      rotate([0, -90, 0])
        screw_hole();
  }
}

rotate([90, 0, 0]) first_half();
translate([0, 0, half_d]) rotate([-90, 0, 0]) second_half();
