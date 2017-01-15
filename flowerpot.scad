// Doksy:kitchen
bowl_h = 80;

// Doksy:living-room:table
//bowl_h = 150;

// Doksy:living-room:pc
//bowl_h = 140;

// Doksy:sleeping-room
//bowl_h = 95;

$fn = 32;

bowl_w = 180;
thickness = 3;
flowerpod_depth = 70;
hole_d = 8;
holes_count = 3;
bowl_pod_space = 8;

// computed params
flowerpod_w = bowl_w - bowl_pod_space * 2 - thickness;
flowerpod_h = bowl_h - bowl_pod_space * 2 - thickness;

bowl();
translate([thickness + bowl_pod_space, thickness + bowl_pod_space, thickness])
    flowerpod();

module flowerpod() {
    difference() {
        cube([flowerpod_w, flowerpod_h, flowerpod_depth]);
        translate([thickness, thickness, thickness])
            cube([flowerpod_w - thickness * 2, flowerpod_h - thickness * 2, flowerpod_depth - thickness]);

        for (n = [1:holes_count]) {
            translate([n * (flowerpod_w / (holes_count + 1)), flowerpod_h / 2, 0])
                cylinder(h = thickness, d = hole_d);
        }
        translate([0, flowerpod_h / 2 - hole_d / 2, 0])
            cube([flowerpod_w, hole_d, thickness / 2]);
    }
}

module bowl() {
    difference() {
        cube([bowl_w, bowl_h, flowerpod_depth]);
        translate([thickness, thickness, thickness])
            cube([bowl_w - thickness * 2, bowl_h - thickness * 2, flowerpod_depth - thickness]);
    }
}
