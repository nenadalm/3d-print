use <spring.scad>

$fn = 32;

// start parameters
amplitude = 11;
table_thickness = 17;
height = 39;
width = 11;
thickness = 2;
spring_stretch = 3;
angle = -19;
edge_over = 1.5;
edge_over_length = 11.4;
// end parameters

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];

length = height * 2 - thickness;

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

spring_adj = polar_to_cartesian(thickness / 2, angle + 90);
_b = table_thickness + amplitude - spring_stretch + thickness + thickness / 2;
_c = _b / cos(angle);
_a = sin(angle) * _c;

translate([-edge_over, 0, 0])
    cube([edge_over, edge_over_length + xx + thickness, width]);

difference() {
    cube([thickness, height, width]);
    union() {
        translate([yy, xx, -1])
            cube([edge_over + 1, edge_over_length, width + 2]);
        translate([0, 0, -1])
          linear_extrude(height = width + 2)
              polygon(points = [
                  [yy, xx],
                  [yy2, xx2],
                  [yy2 + 1, xx2],
                  [yy2 + 1, xx2 + xx - xx2 + 1],
                  [yy2, xx2 + xx - xx2 + 1],
              ]);
    }
}

rotate([0, 0, angle])
    cube([_c  + polar_to_cartesian(thickness / 2, angle)[1], thickness, width]);

translate([_b, _a + (thickness / sin(90 + angle)) / 2, 0])
  rotate([0, 0, 90])
      linear_extrude(width)
        sine_wave(amplitude = amplitude, length = height, omega = 0.25, thickness = thickness);
