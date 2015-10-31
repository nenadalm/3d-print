height = 19;
width = 14;
board_thickness = 1.6;
bottom_space = 3.5;

thickness = 1;

difference() {
    cube([width + thickness * 2, height + thickness * 2, board_thickness + thickness]);
    translate([thickness, thickness, thickness])
        cube([width, height, board_thickness]);
    translate([0, thickness, 0])
        cube([width + thickness, bottom_space, thickness + board_thickness]);
}
