module spring(d, width, angle, thickness) {
    T = polar_to_cartesian(d + thickness, angle);
    tw = abs((T[0] - thickness) / 2);

    spring_first_part(d = d, tw = tw, width=width, angle = angle, thickness = thickness);
    spring_second_part(d = d, T = T, width=width, angle = angle, thickness = thickness);
    spring_third_part(d = d, T = T, tw = tw, width=width, angle = angle, thickness = thickness);
}

module spring_third_part(d, T, tw, width, angle, thickness) {
    intersection() {
        spring_second_cylinder(d = d, T = T, width = width, angle = angle, thickness = thickness);
        translate([0, tw, 0])
            cube([width, d / 2 + thickness - tw, d / 2]);
    }
}

module spring_second_part(d, T, width, angle, thickness) {
    intersection() {
        spring_first_cylinder(d = d, width = width, thickness = thickness);
        spring_second_cylinder(d = d, T = T, width = width, angle = angle, thickness = thickness);
    }
}

module spring_first_part(d, tw, width, angle, thickness) {
    intersection() {
        spring_first_cylinder(d = d, width = width, thickness = thickness);
        cube([width, tw, d / 2]);
    }
}

module spring_first_cylinder(d, width, thickness) {
    translate([0, 0, d / 2 + thickness])
        spring_cylinder(d = d, width = width, thickness = thickness);
}

module spring_second_cylinder(d, T, width, angle, thickness) {
    translate([0, T[0], T[1]])
        // + thickness is wrong - it should be translated in 2 axis
        translate([0, 0, d / 2 + thickness])
            spring_cylinder(d = d, width = width, thickness = thickness);
}

module spring_cylinder(d, width, thickness) {
    rotate([0, 90, 0])
        difference() {
            cylinder(h = width, d = d + thickness * 2);
            cylinder(h = width, d = d);
        }
}

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];
