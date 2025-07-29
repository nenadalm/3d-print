/**
 * Print settings:
 *
 * perimeters: 3
 * bottom solid layers: 4
 */
$fn = 32;

bowl_w = 180;
bowl_h = 80 + 19;
bowl_depth = 25;

thickness = 3;
floperpot_depth = 60;

hole_d = 8;
holes_count = 3;
bowl_pod_space = 8;

// computed params
floperpot_w = bowl_w - bowl_pod_space * 2 - thickness;
floperpot_h = bowl_h - bowl_pod_space * 2 - thickness;

module floperpot() {
    difference() {
        cube([floperpot_w, floperpot_h, floperpot_depth]);
        translate([thickness, thickness, thickness])
            cube([floperpot_w - thickness * 2, floperpot_h - thickness * 2, floperpot_depth]);

        for (n = [1:holes_count]) {
          translate([n * (floperpot_w / (holes_count + 1)) - hole_d / 2, floperpot_h / 2 - hole_d / 2, -1])
                cube([hole_d, hole_d, thickness + 2]);
        }
        translate([-1, floperpot_h / 2 - hole_d / 2, -1])
            cube([floperpot_w + 2, hole_d, thickness / 2 + 1]);
    }
}

module bowl() {
    difference() {
        cube([bowl_w, bowl_h, bowl_depth]);
        translate([thickness, thickness, thickness])
            cube([bowl_w - thickness * 2, bowl_h - thickness * 2, bowl_depth]);
    }
}

//bowl();
//translate([thickness + bowl_pod_space, thickness + bowl_pod_space, thickness])
//    floperpot();

//bowl();
//floperpot();
