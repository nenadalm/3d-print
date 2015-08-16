use <lib/spring.scad>

// start parameters
table_thickness = 17;
height = 39;
width = 11;
thickness = 2;
spring_stretch = 3;
spring_angle = -60;
// end parameters

spring_z_position = table_thickness - spring_stretch;

length = height * 2 - thickness;
cartesian = polar_to_cartesian(length, spring_angle);
x2_before_translate = polar_to_cartesian(length, spring_angle);
s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
spring_z = s2[1] + height;

cube([thickness, height, width]);
cube([table_thickness + spring_z + spring_z_position, thickness, width]);

translate([table_thickness + spring_z + spring_z_position + thickness, 0, 0])
    rotate([0, 180, 0])
        rotate([0, 90, 0])
            spring(
                d = height * 2 - thickness * 2,
                width = width,
                angle = spring_angle,
                thickness = thickness
            );

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];
