$fn = 32;

tolerance = 0.6;
thickness = 3;

width = 85;
height = 56;
bottom_spacing = 3;
hole_d = 2.75;
outer_hole_d = 6.2;
board_thickness = 1.3;
components_height = 15.75;
bolt_hole = 2.5;

bolt_head = 5.25;
bolt_hole_d = 2.8;
bolt_depth = 10;

board_mount_positions = [
// Raspberry PI A, B rev2
    [tolerance + 25.5, tolerance + 18, 0],
    [2 * tolerance + width - 5, 2 * tolerance + height - 12.5, 0]

// Raspberry PI B+ and newer
//    [tolerance + 3.5, tolerance + 3.5, 0],
//    [tolerance + 3.5 + 58, tolerance + 3.5, 0],
//    [tolerance + 3.5, 2 * tolerance + height - 3.5, 0],
//    [tolerance + 3.5 + 58, 2 * tolerance + height - 3.5, 0]
];

//bottom_part();
//translate([0, -height -thickness * 2 - 10, 0])
    top_part();

module top_part() {
    outer_dimensions = [
        width + thickness * 2 + tolerance * 2,
        height + thickness * 2 + tolerance * 2,
        components_height + tolerance + thickness
    ];
    inner_dimensions = [
        width + tolerance * 2,
        height + tolerance * 2,
        components_height + tolerance
    ];

    difference() {
        union() {
            cube(outer_dimensions);
            translate([0, (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
            translate([0, outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
            translate([outer_dimensions[0], (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
            translate([outer_dimensions[0], outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
        }

        translate([thickness, thickness, thickness]) {
            cube(inner_dimensions);
        }
        translate([0, (bolt_hole_d + thickness) / 2, 0]) {
            _top_part__bolt_inner_hole(h = outer_dimensions[2]);
        }
        translate([0, outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
            _top_part__bolt_inner_hole(h = outer_dimensions[2]);
        }
        translate([outer_dimensions[0], (bolt_hole_d + thickness) / 2, 0]) {
            _top_part__bolt_inner_hole(h = outer_dimensions[2]);
        }
        translate([outer_dimensions[0], outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
            _top_part__bolt_inner_hole(h = outer_dimensions[2]);
        }

        lid_filament_saving(inner_dimensions = inner_dimensions);

        _top_part__a_b_rev2_holes(outer_dimensions = outer_dimensions);
    }
}

module bottom_part() {
    outer_dimensions = [
        width + thickness * 2 + tolerance * 2,
        height + thickness * 2 + tolerance * 2,
        thickness + bottom_spacing + tolerance + board_thickness + tolerance
    ];
    inner_dimensions = [
        width + tolerance * 2,
        height + tolerance * 2,
        bottom_spacing + tolerance + board_thickness + tolerance
    ];

    translate([thickness, thickness, thickness]) {
        for (i = board_mount_positions) {
            translate(i) _bottom_part__board_mount();
            translate([i[0] - outer_hole_d / 2, 0, -thickness])
                cube([outer_hole_d, inner_dimensions[1], thickness]);
        }
    }

    difference() {
        union() {
            cube(outer_dimensions);
            translate([0, (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
            translate([0, outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
            translate([outer_dimensions[0], (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
            translate([outer_dimensions[0], outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
                _bottom_part__bolt_outer_shell(h = outer_dimensions[2]);
            }
        }

        translate([thickness, thickness, thickness]) {
            cube(inner_dimensions);
        }
        translate([0, (bolt_hole_d + thickness) / 2, 0]) {
            _bottom_part__bolt_inner_hole(h = outer_dimensions[2]);
        }
        translate([0, outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
            _bottom_part__bolt_inner_hole(h = outer_dimensions[2]);
        }
        translate([outer_dimensions[0], (bolt_hole_d + thickness) / 2, 0]) {
            _bottom_part__bolt_inner_hole(h = outer_dimensions[2]);
        }
        translate([outer_dimensions[0], outer_dimensions[1] - (bolt_hole_d + thickness) / 2, 0]) {
            _bottom_part__bolt_inner_hole(h = outer_dimensions[2]);
        }

        lid_filament_saving(inner_dimensions = inner_dimensions);

        _bottom_part__a_b_rev2_holes(outer_dimensions = outer_dimensions);
    }
}

module _top_part__a_b_rev2_holes(outer_dimensions) {
    // hdmi
    hdmi_dimensions = [15.1 + 2 * tolerance, thickness, 6.15 + tolerance];
    translate([
        thickness + 37.5,
        outer_dimensions[1] - hdmi_dimensions[1],
        outer_dimensions[2] - hdmi_dimensions[2]
    ]) {
        cube(hdmi_dimensions);
    }

    // jack
    jack_dimensions = [6.7 + tolerance * 2, thickness, 3 + 6.7 + tolerance];
    translate([
        outer_dimensions[0] - thickness - tolerance * 2 - jack_dimensions[0] - 14 - 2.65,
        0,
        outer_dimensions[2] - jack_dimensions[2]
    ]) {
        cube(jack_dimensions);
    }

    // composite
    composite_dimensions = [8.3 + tolerance * 2, thickness, 4 + 8.3 + tolerance];
    translate([
        thickness + tolerance + 40.6 + 0.75,
        0,
        outer_dimensions[2] - composite_dimensions[2]
    ])
    cube(composite_dimensions);

    // ethernet
    ethernet_dimensions = [thickness + bolt_hole_d + thickness, 15.4 + tolerance * 2, 13 + tolerance * 2];
    translate([
        outer_dimensions[0] - thickness,
        outer_dimensions[1] - ethernet_dimensions[1] - thickness - 2,
        outer_dimensions[2] - ethernet_dimensions[2]
    ]) {
        cube(ethernet_dimensions);
    }

    // usb
    usb_dimensions = [thickness , 13.25 + tolerance * 2, 15.3 + tolerance];
    translate([
        outer_dimensions[0] - usb_dimensions[0],
        thickness + 18.8,
        outer_dimensions[2] - usb_dimensions[2]
    ]) {
        cube(usb_dimensions);
    }

    // micro usb
    translate([-outer_hole_d, outer_dimensions[1] - 2.4 - thickness - tolerance - 10, outer_dimensions[2] - 5]) {
        cube([thickness + outer_hole_d, 10, 7]);
    }
}

module _top_part__bolt_inner_hole(h) {
    _bottom_part__bolt_inner_hole(h = h);
    cylinder(d = bolt_head, h = h - bolt_depth / 2);
}

module _bottom_part__a_b_rev2_holes(outer_dimensions) {
    // mem card
    translate([
            0,
            outer_dimensions[1] - thickness - tolerance - 27.8 - tolerance - 11.5,
            outer_dimensions[2] - 5 + tolerance * 2
        ]) {
            cube([thickness, 27.8 + tolerance * 2, 5 + tolerance * 2]);
        }

    // micro usb
    translate([-outer_hole_d, 2.4 + thickness + tolerance, thickness + bottom_spacing - 1]) {
        cube([thickness + outer_hole_d, 10, 7]);
    }
}

module _bottom_part__board_mount() {
    cylinder(d = outer_hole_d - tolerance * 2, h = bottom_spacing);
    translate([0, 0, bottom_spacing])
        cylinder(d = hole_d - tolerance * 2, h = board_thickness);
}

module _bottom_part__bolt_outer_shell(h) {
    cylinder(h = h, d = bolt_hole_d + thickness);
}

module _bottom_part__bolt_inner_hole(h) {
    cylinder(h = h, d = bolt_hole_d);
}

module lid_filament_saving(inner_dimensions) {
    spaces = 5;
    space_x = (inner_dimensions[0] - (thickness * (spaces - 1))) / spaces;
    translate([thickness, thickness, 0]) {
        for (i = [0:spaces - 1]) {
            translate([thickness * i + space_x * i, 0, 0]) {
                cube([
                    space_x,
                    inner_dimensions[1],
                    inner_dimensions[2]
                ]);
            }
        }
    }
}
