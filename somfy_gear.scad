/**
 * Print settings:
 *
 * infill: 100%
 *
 * Assembly:
 * - inner hole needs to be enlarged on lathe
 */

$fn = 64;

outer_d = 82.8;
inner_d = 23.7;//25;
base_height = 20;

other_gear_d = 21.5;
other_gear_w1 = 3;
other_gear_w2 = 1.5;
other_gear_depth = 3.8;

tooth_h = 4.3;
tooth_mid_h = 3.2;
tooth_top_w = 2.4; //2.7;
tooth_mid_w = 3.4;
tooth_base_w = 4.3; //4.7;
tooth_n = 45;
tooth_over = 5;
tooth_angle = -4;

lock_inner_d = 36.48;
lock_outer_d = 57.46;
lock_space = 8.15;
lock_h = 8.89;


edge_overhang = 0.92;
edge_overhang_h = 7;

edge_h = 4.8;
edge_w1 = 8.13;
edge_w2 = 4.25;

translate([0, 0, base_height + lock_h])
rotate([180, 0, 0])
    somfy_gear();

module other_gear_c() {
    rotate([0, 90 + tooth_angle, 0])
    translate([0, 0, -other_gear_w2 / 2 + tooth_base_w / 2]) {
        translate([0, 0, other_gear_w2])
            cylinder(
                d1 = other_gear_d,
                d2 = other_gear_d - other_gear_depth,
                h = (other_gear_w1 - other_gear_w2) / 2
            );
        cylinder(
            d = other_gear_d,
            h = other_gear_w2
        );
        rotate([180, 0, 0])
            cylinder(
                d1 = other_gear_d,
                d2 = other_gear_d - other_gear_depth,
                h = (other_gear_w1 - other_gear_w2) / 2
            );
    }
}

module top_ring() {
    difference() {
        translate([0, 0, -edge_h])
            cylinder(
                d = outer_d + edge_overhang * 2,
                h = edge_h
            );
        translate([0, 0, -edge_h])
            cylinder(
                d1 = outer_d - edge_w2 * 2 + edge_overhang * 2,
                d2 = outer_d -edge_w1 * 2 + edge_overhang * 2,
                h = edge_h
            );
    }
    difference() {
        cylinder(
            d1 = outer_d + edge_overhang * 2,
            d2 = outer_d,
            h = 2.2
        );
        cylinder(d = inner_d, h = 2.2);
    }
}

module almost_gear() {
    translate([0, 0, lock_h]) {
        base();
        difference() {
            tooths();
            translate([0, 0, -edge_h]) {
                cylinder(
                    d1 = outer_d -edge_w2 * 2 + edge_overhang * 2,
                    d2 = outer_d -edge_w1 * 2 + edge_overhang * 2,
                    h = edge_h
                );
            }
        }
        top_ring();
    }
    lock();
}

module somfy_gear() {
    d = ((360 / tooth_n) * 1) / 2;

    difference() {
        almost_gear();
        for (i = [0:tooth_n]) {
            coords = polar_to_cartesian(
                outer_d / 2 + other_gear_d / 2 - 4.6,
                (360 / tooth_n) * i + d
            );

            translate([
                coords[0],
                coords[1],
                other_gear_d / 2 + lock_h - edge_h
            ])
            rotate([0, 0, (360 / tooth_n) * i + d - 90])
            translate([-tooth_base_w / 4, 0, 0])
                translate([-1.5, 0, 0])
                other_gear_c();
        }
    }
}

module lock_space() {
    translate([-lock_space / 2, -lock_outer_d / 2, 0])
        cube([lock_space, lock_outer_d, lock_h]);
}

module lock() {
    difference() {
        cylinder(d = lock_outer_d, h = lock_h);
        cylinder(d = lock_inner_d, h = lock_h);
        lock_space();
    }
}

module tooths() {
    for (i = [0:tooth_n]) {
        coords = polar_to_cartesian(
            outer_d / 2 - tooth_h,
            (360 / tooth_n) * i
        );
        translate([coords[0], coords[1], 0])
            rotate([0, 0, (360 / tooth_n) * i - 90])
                translate([-tooth_base_w / 2, 0, 0])
                    tooth();
    }
}

module tooth() {
    th = base_height + edge_h;
    difference() {
        intersection() {
            rotate([0, tooth_angle, 0])
            translate([0, 0, -tooth_over])
            linear_extrude(height = th + tooth_over * 2)
                polygon(
                    points = [
                        [0, -tooth_over],
                        [0, 0],
                        [(tooth_base_w - tooth_mid_w) / 2, tooth_mid_h],
                        [(tooth_base_w - tooth_top_w) / 2, tooth_h],
                        [(tooth_base_w - tooth_top_w) / 2 + tooth_top_w, tooth_h],
                        [(tooth_base_w - tooth_mid_w) / 2 + tooth_mid_w, tooth_mid_h],
                        [tooth_base_w, 0],
                        [tooth_base_w, -tooth_over],
                    ]
                );
            translate([-(tooth_base_w * 10) / 2, -tooth_over, -edge_h])
                cube([tooth_base_w * 10, tooth_h + tooth_over, th]);
            }
    }
}

module base() {
    difference() {
        cylinder(d = outer_d - tooth_h * 2, h = base_height);
        cylinder(d = inner_d, h = base_height);
    }
}

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];