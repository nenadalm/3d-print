use <lib/spring.scad>

// start parameters
table_thickness = 17;
height = 39;
width = 11;
thickness = 2;
spring_stretch = 3;
spring_angle = -60;
angle = -19;
edge_over = 1.5;
edge_over_length = 12;
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

P = [0, 0];
A = [0, thickness];
v = P - A;

Bl = thickness;
Bangle = (90 - 180 - angle) * -1;
Bc = polar_to_cartesian(length = Bl, angle = Bangle);
Bc1 = [Bc[1], Bc[0]];

n = P - Bc1;
cc = (-n[0] * Bc1[0] - n[1] * Bc1[1]) * -1;
yy = thickness - edge_over;
xx = -(n[1] * yy - cc) / n[0];

yy2 = yy + edge_over;
xx2 = -(n[1] * yy2 - cc) / n[0];

difference() {
    cube([thickness, height, width]);
    union() {
        translate([yy, xx, 0])
            cube([edge_over, edge_over_length, width]);
        linear_extrude(height = width)
            polygon(points = [
                [yy, xx],
                [yy2, xx2],
                [yy2, xx2 + xx - xx2 + 1]
            ]);
    }
}

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
