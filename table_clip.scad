table_thickness = 17;
spring_z_position = 14;
top_overlap = 1;

height = 39;
width = 11;
thickness =2;

translate([0, 0, width])
    rotate([0, 90, 0]) {
        base();
        spring();
    }

module base() {
    length = height * 2 - thickness;
    angle = -60;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);

    cube([width, height, thickness]);
    translate([0, 0, -table_thickness - spring_z - spring_z_position])
        cube([width, thickness, table_thickness + spring_z + spring_z_position]);
}

module spring() {
    length = height * 2 - thickness;
    angle = -60;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);
    
    translate([0, 0, -spring_z - spring_z_position]) {
        spring_first_part();
        spring_second_part();
        spring_third_part();
    }
}

module spring_third_part() {
    length = height * 2 - thickness;
    angle = -60;
    cartesian = polar_to_cartesian(length, angle);
    x2_before_translate = polar_to_cartesian(length, angle);
    s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
    spring_z = s2[1] + height;
    spring_h = abs(height - table_thickness - height - spring_z);
    x1 = height - table_thickness;
    dx = abs(x1 - s2[0]);

    intersection() {
    spring_second_cylinder();

    translate([0, dx, -table_thickness])
            cube([width, height - dx, spring_h]);
    }
}

module spring_second_part() {
    intersection() {
        spring_first_cylinder();
        spring_second_cylinder();
    }
}

module spring_first_part() {
    length = height * 2 - thickness;
    angle = -60;
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

module spring_second_cylinder() {
    length = height * 2 - thickness;
    angle = -60;
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
