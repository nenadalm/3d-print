$fn = 64;
tolerance = 0.2;

thickness = 2.83;
outer_d = 67.5;
overhang = 2.34;

height = 130.19;
top_fill = 5.77;
bottom_fill = 5.77;

spacing = 1.6;

outer_circles_n = 38;
inner_lines_n = 74;

inner_stuff_thickness = 1.5;
inner_stuff_w = 6;

filter();
translate([0, 0, height - 1.65])
    top_ring();

module top_ring() {
    difference() {
        cylinder(d = outer_d + 4.2, h = 1.65);
        cylinder(d = outer_d + tolerance * 2, h = 1.65);
    }
}

module filter() {
    translate([-outer_d / 2 + thickness / 2, -inner_stuff_thickness / 2])
        cube([inner_stuff_w + thickness / 2, inner_stuff_thickness, height]);
    translate([outer_d / 2 - thickness - inner_stuff_w, -inner_stuff_thickness / 2])
        cube([inner_stuff_w + thickness / 2, inner_stuff_thickness, height]);
    translate([inner_stuff_thickness / 2, outer_d / 2 - thickness - inner_stuff_w, 0])
        rotate([0, 0, 90])
            cube([inner_stuff_w + thickness / 2, inner_stuff_thickness, height]);
    translate([inner_stuff_thickness / 2, -outer_d / 2 + thickness / 2, 0])
        rotate([0, 0, 90])
            cube([inner_stuff_w + thickness / 2, inner_stuff_thickness, height]);

    translate([0, 0, height - top_fill])
        difference() {
            cylinder(h = top_fill, d = outer_d);
            cylinder(h = top_fill, d = outer_d - thickness * 2);
        }
    translate([0, 0, bottom_fill + spacing])
        for (i = [0:outer_circles_n]) {
            translate([0, 0, 2 * i * spacing])
                ring();
        }
    difference() {
        intersection() {
            cylinder(h = height, d = outer_d);
            for (i = [0:inner_lines_n]) {
                coords = polar_to_cartesian(
                    outer_d / 2 - thickness / 2,
                    (360 / inner_lines_n) * i
                );
                translate([coords[0], coords[1], 0])
                    rotate([0, 0, (360 / inner_lines_n) * i + 90])
                        line();
            }
        }
        cylinder(h = height, d = outer_d - thickness * 2);
    }
    cylinder(h = bottom_fill, d = outer_d);
}

module ring() {
    difference() {
        cylinder(h = spacing, d = outer_d);
        cylinder(h = spacing, d = outer_d - thickness * 2);
    }
}

module line() {
    translate([-spacing / 2, -thickness / 2 - 2, 0])
        cube([spacing, thickness + 4, height]);
}

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];
