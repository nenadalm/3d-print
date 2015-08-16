use <lib/spring.scad>

// start parameters
table_thickness = 17;
height = 39;
width = 11;
thickness = 2;
spring_stretch = 3;
spring_angle = -60;
angle = 0;
// end parameters

spring_z_position = table_thickness - spring_stretch;

length = height * 2 - thickness;
cartesian = polar_to_cartesian(length, spring_angle);
x2_before_translate = polar_to_cartesian(length, spring_angle);
s2 = [x2_before_translate[0], x2_before_translate[1] + height - table_thickness];
spring_z = s2[1] + height;

base_height = table_thickness + spring_z + spring_z_position;
c = base_height / cos(angle);
a  = sqrt(c * c - base_height * base_height);
spring_dir = angle < 0 ? -1 : 1;

cube([thickness, height, width]);
rotate([0, 0, angle])
    cube([c, thickness, width]);

translate([base_height + thickness, a * spring_dir, 0])
    rotate([0, 180, 0])
        rotate([0, 90, 0])
            spring(
                d = height * 2 - thickness * 2,
                width = width,
                angle = spring_angle,
                thickness = thickness
            );

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];
