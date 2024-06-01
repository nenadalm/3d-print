holder_d = 54;
inner_d = 35;
thickness = 1.5;
groove = [2.19 + thickness, 8.97];
depth = 10;
bolt_d = 2.3;
bolt_h = 5.66;
holder_height = 31.5;

$fn = 32;

socket_holder();
intersection() {
  holder();
  holder_glue();
}
intersection() {
  holder_glue();
  difference() {
    cylinder(d = holder_d, h = thickness + depth);
    translate([0, 0, -1])
      cylinder(d = inner_d, h = thickness + depth + 2);
  }
}

module holder_glue() {
  translate([0, -35 / 2 , 0])
    cube([inner_d, 35, holder_height + thickness]);
}

module holder() {
  h = holder_height;
  bolt_distance = 24.5;
  holder_thickness = thickness * 4;

  difference() {
    difference() {
      cylinder(d = holder_d, h = h + holder_thickness);
      translate([0, 0, -1])
        cylinder(d = holder_d - (holder_thickness * 2), h = h + holder_thickness + 2);
    }

    translate([0, -bolt_distance / 2, 18.2])
      rotate([0, 90, 0]) {
        cylinder(d = bolt_d, h = holder_d);
        translate([0, bolt_distance, 0])
          cylinder(d = bolt_d, h = holder_d);
      }
  }
}

module socket_holder() {
  bolt_distance = 17.57;
  cable_hole = [6.91, 14.85];

  // ring with base
  difference() {
    union() {
      difference() {
        cylinder(h = thickness + depth, d = inner_d + (thickness * 2));
        translate([0, 0, -1])
          cylinder(h = thickness + depth + 2, d = inner_d);
      }
      cylinder(h = thickness, d = inner_d);
    }
    
    // cable hole
    translate([-cable_hole[0] / 2, -cable_hole[1] / 2, -1])
      cube([cable_hole[0], cable_hole[1], thickness + 2]);
  }

  // socket grooves
  intersection() {
    translate([-thickness - (inner_d / 2), -groove[1] / 2, 0])
      cube([groove[0], groove[1], depth + thickness]);
    cylinder(h = thickness + depth, d = inner_d + thickness * 2);
  }
  rotate([0, 0, 180])
    intersection() {
      translate([-thickness - (inner_d / 2), -groove[1] / 2, 0])
        cube([groove[0], groove[1], depth + thickness]);
      cylinder(h = thickness + depth, d = inner_d + thickness * 2);
    }
  
  // stability grooves
  rotate([0, 0, 90])
    intersection() {
      translate([-thickness - (inner_d / 2), -groove[1] / 2, 0])
        cube([groove[0], groove[1], depth + thickness]);
      cylinder(h = thickness + bolt_h - 2.2, d = inner_d + thickness * 2);
    }
  rotate([0, 0, -90])
    intersection() {
      translate([-thickness - (inner_d / 2), -groove[1] / 2, 0])
        cube([groove[0], groove[1], depth + thickness]);
      cylinder(h = thickness + bolt_h - 2.2, d = inner_d + thickness * 2);
    }

  // bolt holes
  translate([-bolt_distance / 2, 0, thickness]) {
    bolt_thingy();
    translate([bolt_distance, 0, 0])
      bolt_thingy();
  }
}

module bolt_thingy() {
  h = bolt_h;
  difference() {
    cylinder(h = h, d = 6.02);
    translate([0, 0, -1])
      cylinder(h = h + 2, d = bolt_d);
  }
}