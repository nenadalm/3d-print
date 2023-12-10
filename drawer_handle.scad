/*
 * Print settings:
 * ===============
 *
 * infill: 3d honeycomb, 25%
 */
 
$fn = 32;
tolerance = 0.07;

r = 2;
hole_distance = 100;
hole_d = 2.5;
hole_depth = 25;
size = 10;
knuckle_clearance = 25;

difference() {
  union() {
    translate([0, r, r]) {
      minkowski() {
        cube([hole_distance, size - 2 * r, size - 2 * r]);
        rotate([0, 90, 0])
          cylinder(r = r, h = size);
      }
    }
    translate([0, r, 0]) {
      cube([size, knuckle_clearance + size - r, size]);
      translate([hole_distance, 0, 0])
        cube([size, knuckle_clearance + size - r, size]);
    }
  }
  translate([size / 2, knuckle_clearance + size - hole_depth, size / 2])
    rotate([-90, 0, 0])
      cylinder(d = hole_d, h = hole_depth + 1);
  translate([hole_distance, 0, 0])
    translate([size / 2, knuckle_clearance + size - hole_depth, size / 2])
      rotate([-90, 0, 0])
        cylinder(d = hole_d, h = hole_depth + 1);
}