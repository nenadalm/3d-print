$fn = 32;

//tolerance = 0.15;
tolerance = 0.2;
thickness = 3;

width = 85;
height = 56;
bottom_spacing = 3;
hole_d = 2.75;
outer_hole_d = 6.2;
board_thickness = 1.3;
components_height = 15.75;
bolt_hole = 2.5;

side_height = components_height + bottom_spacing + board_thickness + tolerance * 2 + thickness;

case();
translate([0, 0, side_height])
    lid();

module lid() {
    difference() {
        translate([thickness + tolerance, thickness + tolerance, 0])
            cube([width + thickness, height, thickness]);
        translate([thickness + 6.3, height - thickness, 0])
            cube([17, tolerance + 6, thickness]);
        
        translate([thickness, thickness, 0])
            translate([thickness - bolt_hole / 4, thickness - bolt_hole  / 4])
                cylinder(d = bolt_hole, h = thickness);
        
        translate([thickness, height + tolerance + hole_d / 2 - thickness, 0])
        translate([thickness - bolt_hole / 4, thickness - bolt_hole  / 4])
                cylinder(d = bolt_hole, h = thickness);
    }
}

module case() {
    cube([width + tolerance * 2 + thickness * 2, height + tolerance * 2 + thickness * 2, thickness]);
        
    translate([tolerance + thickness, tolerance + thickness, thickness]) {
        translate([3.5, 3.5, 0]) board_mount();
        translate([3.5 + 58, 3.5, 0]) board_mount();
        translate([3.5, height - 3.5, 0]) board_mount();
        translate([3.5 + 58, height - 3.5, 0]) board_mount();
    }

    union() {
        translate([0, height + tolerance * 2 + thickness, thickness])
            cube([width + tolerance * 2 + thickness * 2, thickness, side_height]);

        difference() {
            translate([0, 0, thickness])
                cube([thickness, height + thickness * 2 + tolerance * 2, side_height]);
            translate([0, height / 2 + thickness + tolerance - 6, thickness])
                cube([thickness, 12, 4]);
        }

        translate([width - 25 + (thickness * 2 + bolt_hole) + thickness, 0, thickness])
            cube([25 - (thickness * 2 + bolt_hole) + tolerance + thickness, thickness, side_height]);

        translate([thickness, 0, thickness])
            cube([5 + tolerance, thickness, side_height]);

        translate([thickness, 0, thickness + 14])
            cube([width, thickness, side_height - 14]);
        
        translate([thickness, thickness, side_height - thickness])
        bolt_mount();
    translate([thickness, height + thickness + tolerance * 2, side_height - thickness])
        rotate([0, 0, -90])
            bolt_mount();
    }
}


module bolt_mount() {
    linear_extrude(height = thickness)
        difference() {
            polygon([
                [0, 0],
                [thickness * 2 + bolt_hole, 0],
                [0, thickness * 2 + bolt_hole],
            ]);
            translate([thickness - bolt_hole / 4, thickness - bolt_hole  / 4])
                circle(d = bolt_hole);
        }
    linear_extrude(height = 0.3)
        polygon([
            [0, 0],
            [thickness * 2 + bolt_hole, 0],
            [0, thickness * 2 + bolt_hole],
        ]);
}

module board_mount() {
    cylinder(d = outer_hole_d - tolerance * 2, h = bottom_spacing);
    translate([0, 0, bottom_spacing])
        cylinder(d = hole_d - tolerance * 2, h = board_thickness);
}
