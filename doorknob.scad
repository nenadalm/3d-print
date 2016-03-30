$fn = 32;
//6, 4
tolerance = 0.2;

// doorknob
hole = [7.95 + tolerance * 2, 7.95 + tolerance * 2, 33];
d = 50;
cut = d/30;
holder_d = 17;
holder_h = 6;

// washer + plate
w = [50, 150, 3];
washer_d = d / 3;
washer_over = 2;
washer_h = 1;

// notch
s_d = d / 3;
s_v = d;

translate([0, -40, 0])
    plate();
translate([0, 0, washer_h + w[2]]) {
    rotate([180, 0, 0])
        washer();
    knob();
}

module security_door_knob_joiner() {
    cube([hole[0] - tolerance * 2, hole[1] - tolerance * 2, 13]);
}

module security_door_bottom_knob() {
    knob_bottom();
    translate([0, 0, d / 2]) {
        difference() {
            cylinder(d = 14.68 - tolerance * 2, h = 15);
            translate([-2, -14.68 / 2, 15 - 6.62])
                cube([4, 14.68, 6.62]);
            translate([-hole[0] / 2, -hole[1] / 2, 0])
                cube([hole[0], hole[1], 15]);
        }
}
}

module knob() {
    translate([0, 0, d / 2]) {
        rotate([180, 0, 0])
            knob_bottom();
        knob_top();
    }
}

module knob_bottom() {
    translate([0, 0, d / 2])
        rotate([180, 0, 0])
            difference() {
                difference() {
                    translate([0, 0, -cut])
                        difference() {
                            translate([0, 0, d / 2])
                                sphere(d = d);
                            translate([-d / 2, -d / 2, 0])
                                cube([d, d, cut]);
                        }
                    translate([-hole[0] / 2, -hole[1] / 2, 0])
                        cube(hole);
                }
                translate([-d / 2, -d / 2, d / 2])
                    cube([d, d, d / 2]);
                notch();
                translate([0, 0, 6])
                    rotate([90, 0, 0])
                        cylinder(d = 4, h = d / 2);
            }
}

module knob_top() {
    translate([0, 0, -d / 2])
            difference() {
                difference() {
                    translate([0, 0, -cut])
                        difference() {
                            translate([0, 0, d / 2])
                                sphere(d = d);
                            translate([-d / 2, -d / 2, 0])
                                cube([d, d, cut]);
                        }
                    translate([-hole[0] / 2, -hole[1] / 2, 0])
                        cube(hole);
                }
                translate([-d / 2, -d / 2, -cut])
                    cube([d, d, d / 2 + cut]);
                notch();
            }
}

module washer() {
    difference() {
        union() {
            cylinder(d = washer_d + washer_over * 2, h = washer_h);
            translate([0, 0, washer_h])
            cylinder(d = washer_d, h = w[2]);
        }
        translate([-hole[0] / 2, -hole[1] / 2, 0])
            cube([hole[0], hole[1], w[2] + washer_h]);
    }
}

module plate() {
    difference() {
        hull() {
            translate([0, 15, 0])
                cylinder(d = w[0], h = w[2]);
            translate([0, w[1] - 10, 0])
                cylinder(d = w[0], h = w[2]);
        }

        translate([0, 40, 0])
            cylinder(d = washer_d + tolerance * 2, h = w[2]);

        // bolts
        translate([0, 15, 0]) {
            translate([0, 0, w[2] - 2.26])
                cylinder(d1 = 4, d2 = 8, h = 2.26);
            cylinder(d1 = 3,  d2 = 4, h = w[2] - 2.26);
        }
        translate([0, w[1] - 10, 0]) {
            translate([0, 0, w[2] - 2.26])
               cylinder(d1 = 4, d2 = 8, h = 2.26);
            cylinder(d1 = 3,  d2 = 4, h = w[2] - 2.26);
        }

        // key
        translate([0, 7 / 2 + 40 + 65.5, 0])
        linear_extrude(height = w[2])
            hull() {
                circle(d = 7);
                translate([0, 19 - 7, 0])
                    circle(d = 7);
            }
    }
}

module notch() {
    for (a = [0:90:270])
        rotate([0, 0, a])
            notch_part();
}

module notch_part() {
    translate([-s_v, 0, d / 2 - cut])
        rotate([90, 0, 0])
            rotate_extrude()
                translate([s_d + s_d / 2 + s_v, 0, 0])
                    circle(d = s_d);
}

