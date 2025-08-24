/**
 * print settings:
 * - perimeters: 4
 */

$fn = 32;

thickness = 1.6;

bolt_angle = 360 / 5;
bolt_l = 17;
bolt_d = 2;

d = 48;
h = 30;

d1 = 18;
h1 = 12;

d2 = 25;
h2 = h1 + 6;

d3 = 28;
h3 = h2 + 7;

d4 = 32 + 5 * bolt_d;

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];

difference() {
  cylinder(h = h, d = d, $fn = 16);
  translate([0, 0, thickness])
    cylinder(h = h , d = d1);
  for (i = [0, 90]) {
    rotate([0, 0, i])
      translate([-d1 / 2 - 10, -1.5, thickness])
        cube([d1 + 20, 3, h]);
  }
  translate([0, 0, thickness + h1])
    cylinder(h = h, d = d2);
  translate([0, 0, thickness + h2])
    cylinder(h = h, d = d3);
  for (i = [0:4]) {
    coord = polar_to_cartesian(bolt_l, bolt_angle * i + 26);
    translate([coord[0], coord[1], thickness])
      cylinder(d = bolt_d, h = h);
  }
  translate([0, 0, thickness + h3])
    cylinder(h = h, d = d4);
}
