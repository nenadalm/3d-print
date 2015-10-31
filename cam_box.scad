width = 48;
height = 16;

left_space = 17;
right_space = 20;
board_thickness = 1.4;
cables_height = 3;
thickness = 2;
space_between_parts = 10;

hole_depth = board_thickness + cables_height;

//assembled_parts();
individual_parts();

module individual_parts() {
    translate([0, height + thickness * 4 + space_between_parts, 0])
        bottom_part();
    top_part();
}

module assembled_parts() {
    translate([thickness, height + thickness * 3, thickness * 2 + hole_depth])
        rotate([180, 0 , 0])
            bottom_part();
    top_part();
}

module top_part() {
    difference() {
        cube([width + thickness * 4, height + thickness * 4, hole_depth + thickness * 2]);

        translate([thickness, thickness, thickness])
            cube([width + thickness * 2, height + thickness * 2, hole_depth + thickness]);
        translate([thickness * 2, 0, thickness])
            cube([left_space, height + thickness * 4, hole_depth + thickness]);
        translate([thickness * 2 + width - right_space, 0, thickness])
            cube([right_space, height + thickness * 4, hole_depth + thickness]);
    }
}

module bottom_part() {
    difference() {
        cube([width + thickness * 2, height + thickness * 2, hole_depth + thickness]);

        translate([thickness, thickness, thickness])
            cube([width, height, hole_depth]);
        translate([thickness, 0, thickness])
            cube([left_space, height + thickness * 2, hole_depth]);
        translate([thickness + width - right_space, 0, thickness])
            cube([right_space, height + thickness * 2, hole_depth]);
    }
}