walls = 5;
layer_width = 0.4;

thickness = walls * layer_width;
clearance = 0.07;

bed_h = 40;
lamp_d = 140;
rubber_h = 0.7;
clamp_h = 50;

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];

a = lamp_d - bed_h + 2 * thickness + 2 * clearance + 2 * rubber_h;
b = clamp_h;
Cangle= atan(a/b);
angle= 180 - Cangle;
shift = polar_to_cartesian(thickness, angle);

Ax = bed_h + thickness + 2 * clearance + 2 * rubber_h;
Ay = 0;
Bx = lamp_d;
By = clamp_h;

Ax2 = Ax + shift[0];
Ay2 = Ay + shift[1];
Bx2 = Bx + shift[0];
By2 = By + shift[1];

v = [Bx2 - Ax2, By2 - Ay2];
n = [v[1] * -1, v[0]];
c = -n[0] * Bx2 - n[1] * By2;

x = bed_h + thickness + 2 * clearance + thickness + 2 * rubber_h;
y = (-c - n[0] * x) / n[1];

y2 = clamp_h - thickness;
x2 = (-c - n[1] * y2) / n[0];

difference() {
  cube([bed_h + 2 * thickness + 2 * clearance + 2 * rubber_h, clamp_h, lamp_d]);
  translate([thickness, -thickness, -1])
    cube([bed_h + thickness + 1 + 2 * rubber_h, clamp_h, lamp_d + 2]);
}

difference() {
  linear_extrude(lamp_d)
    polygon(points = [
      [bed_h + thickness + 2 * clearance + 2 * rubber_h, 0],
      [lamp_d, clamp_h],
      [bed_h + thickness + 2 * clearance + 2 * rubber_h, clamp_h],
    ]);
  translate([0, 0, -1])
    linear_extrude(lamp_d + 2)
      polygon(points = [
        [x, y],
        [x2, y2],
        [bed_h + thickness + 2 * clearance + thickness + 2 * rubber_h, clamp_h - thickness],
      ]);
}