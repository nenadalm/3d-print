table_thickness = 17;
height = 39;
width = 11;
thickness =2;
spring_stretch = 3;
spring_angle = -60;

spring_z_position = table_thickness - spring_stretch;


translate([0, 0, width])
    rotate([0, 90, 0]) {
        base(angle = spring_angle);
        spring(angle = spring_angle);
    }

module base(angle) {
    length = height * 2 - thickness;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);

    cube([width, height, thickness]);
    translate([0, 0, -table_thickness - spring_z - spring_z_position])
        cube([width, thickness, table_thickness + spring_z + spring_z_position]);
}

module spring(angle) {
    length = height * 2 - thickness;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);
    
    translate([0, 0, -spring_z - spring_z_position]) {
        spring_first_part(angle = angle);
        spring_second_part(angle = angle);
        spring_third_part(angle = angle);
    }
}

module spring_third_part(angle) {
    length = height * 2 - thickness;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);
    x1 = height - table_thickness;
    dx = abs(x1 - s2[0]);

    intersection() {
    spring_second_cylinder(angle = angle);

    translate([0, dx, -table_thickness])
            cube([width, height - dx, spring_h]);
    }
}

module spring_second_part(angle) {
    intersection() {
        spring_first_cylinder();
        spring_second_cylinder(angle);
    }
}

module spring_first_part(angle) {
    length = height * 2 - thickness;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);
    x1 = height - table_thickness;

    intersection() {
        spring_first_cylinder();
        translate([0, 0, -table_thickness])
            cube([width, abs(x1 - s2[0]), spring_h]);
    }
}

module spring_first_cylinder() {
    translate([0, 0, height - table_thickness])
        spring_cylinder();
}

module spring_second_cylinder(angle) {
    length = height * 2 - thickness;
    cartesian = polar_to_cartesian(length, angle);

    translate([0, cartesian[0], cartesian[1]])
        translate([0, 0, height - table_thickness])
            spring_cylinder();
}

module spring_cylinder() {
    rotate([0, 90, 0])
        difference() {
            cylinder(h = width, d = height * 2);
            cylinder(h = width, d = height * 2 - thickness * 2);
        }
}

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];
