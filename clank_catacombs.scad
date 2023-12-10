/**
 * Box compartments (leave thickness * 2 for optional lids?):
 * - 286x110x60
 * - 286x93x60
 *
 * components
 * - card: 66x92
 * - tile: 100x100
 * - small secret: d = 20, h = 1.5
 * - big secret: d = 27, h = 1.5
 * - coin 1: d = 20, h = 1.5
 * - coin 5: d = 22, h = 1.5
 * - coin 10: d = 26, h = 1.5
 * - shop item, idol: 20x20x1.5
 * - cube: 8x8x8
 * - artifact: hexagon side to side: 27.5
 * - prisoner: pentagon corner to corner: 34.5
 *
 * print settings:
 * - 3mm inner brim
 *
 */

$fn = 32;
clearance = 0.15; // 0.03, 0.05, 0.07
thickness = 0.8; // 2x nozzle width
layer_overlap = 1;
thumb_d = 25;
box_radius = 0;

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];

module filled_box(size, radius) {
  difference() {
    translate([radius, radius, radius]) {
      minkowski() {
        sphere(radius);
        cube([
          size[0] - 2 * radius,
          size[1] - 2 * radius,
          size[2] - radius,
        ]);
      }
    }
    translate([0, 0, size[2]]) {
      cube([
        size[0],
        size[1],
        radius,
      ]);
    }
  }
}

module box(size, radius, thickness = 2) {
  thickness2 = thickness * 2;
  radius2 = radius * 2;

  difference() {
    union() {
      filled_box([size[0], size[1], size[2] - layer_overlap], radius);
      cube(size);
    }
    translate([thickness, thickness, thickness]) {
      filled_box([
        size[0] - thickness2,
        size[1] - thickness2,
        size[2],
      ], radius);
    }
  }
}

module card_box(size, thickness = 2) {
  thickness2 = thickness * 2;

  difference() {
    cube(size);
    translate([thickness, thickness, thickness]) {
      cube([
        size[0] - thickness2,
        size[1] - thickness2,
        size[2],
      ]);
    }
    translate([size[0] / 2, 0, -layer_overlap]) {
      cylinder(d = thumb_d, h = size[2] + layer_overlap * 2);
    }
    translate([size[0] / 2, size[1], -layer_overlap]) {
      cylinder(d = thumb_d, h = size[2] + layer_overlap * 2);
    }
    translate([0, size[1] / 2, -layer_overlap]) {
      cylinder(d = thumb_d, h = size[2] + layer_overlap * 2);
    }
    translate([size[0], size[1] / 2, -layer_overlap]) {
      cylinder(d = thumb_d, h = size[2] + layer_overlap * 2);
    }
  }
}

// tokens
//box([20, 20, 10], 3, thickness);

// player pieces
//union() {
//  card_box([66 + thickness * 2, 92 + thickness * 2, 8 + thickness], thickness);
//  translate([0, 92 + thickness, 0])
//    box([66 + thickness * 2, 49 + thickness * 2, 8 + thickness], box_radius, thickness);
//}

// coins
//box([
//  91,
//  68 + thickness * 2,
//  11 + thickness
//], box_radius, thickness);
//translate([0, 68 + thickness, 0])
//  box([
//    91,
//    24 + thickness * 2,
//    11 + thickness
//  ], box_radius, thickness);
//translate([0, 68 + thickness + 24 + thickness, 0])
//  box([
//    91,
//    28 + thickness * 2,
//    11 + thickness
//  ], box_radius, thickness);

// secrets + prisoners + lockpicks
//box([
//  91,
//  68 + thickness * 2,
//  11 + thickness
//], box_radius, thickness);
//translate([91 - (30 + thickness * 2), 0, 0])
//  box([
//    30 + thickness * 2,
//    68 + thickness * 2,
//    11 + thickness
//  ], box_radius, thickness);
//translate([0, 68 + thickness, 0])
//  box([
//    91,
//    24 + thickness * 2,
//    11 + thickness
//  ], box_radius, thickness);
//translate([0, 68 + thickness + 24 + thickness, 0])
//  box([
//    91,
//    28 + thickness * 2,
//    11 + thickness
//  ], box_radius, thickness);
  
// lid
//difference() {
//  cube([
//    91,
//    68 + thickness + 24 + thickness + 28 + thickness * 2  + thickness * 2 + clearance * 2,
//    thickness + 5
//  ]);
//  translate([0, thickness, thickness])
//    cube([
//      91,
//      68 + thickness + 24 + thickness + 28 + thickness * 2 + clearance * 2,
//      thickness + 5
//    ]);
//}

module shelf() {
  difference() {
    cube([
      91,
      68 + thickness + 24 + thickness + 28 + thickness * 2  + thickness * 2 + clearance * 2,
      11 + thickness * 3 + clearance * 2
    ]);
    translate([0, thickness, thickness])
      cube([
        91,
        68 + thickness + 24 + thickness + 28 + thickness * 2 + clearance * 2,
        11 + thickness + clearance * 2
      ]);
  }
}

shelf();
translate([0, 0, 11 + thickness * 2 + clearance * 2])
  shelf();

module hex_grid(size = [100, 100, 10], d = 10, h = 10, thickness = 2) {
    offset = polar_to_cartesian((sqrt(3) / 2) * d + thickness, 30);
    
    ox = 2;
    oy = 3;
  
    for (row = [0:ox]) {
      for (col = [0:oy]) {
        translate([offset[0] * 2 * col, offset[1] * 2 * row, 0])
          cylinder(d = d, h = h, $fn = 6);
      }
    }

    for (row = [0:ox]) {
      for (col = [0:oy]) {
        translate([offset[0] + offset[0] * (col * 2), offset[1] * (row * 2 + 1), 0])
          cylinder(d = d, h = h, $fn = 6);
      }
    }
}

//difference() {
////  cube([100, 100, 2]);
//  hex_grid(thickness = 2);
//}