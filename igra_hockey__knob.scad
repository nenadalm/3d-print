$fn = 32;
clearance = 0.07;

hole_d = 4 + clearance * 2;

h = 14;
d1 = 8;
d2 = 6;

antislip_w = 0.4;

y = antislip_w;
x = sqrt(pow(d1 / 2, 2) - pow(y, 2));
ctp = cartesian_to_polar(x, y);
angle = ctp[1];
steps = floor(180 / angle) - 1;
step_angle = 180 / steps;

difference() {
  union() {
    cylinder(h = 2, d = 10);
    translate([0, 0, 2])
      antislip_cylinder(d1 = d1, d2 = d2, h = h);
  }
  translate([0, 0, -1]) {
    cylinder(d = hole_d, h = h + 1);
  }
}

module antislip_cylinder(d1, d2, h) {
  cylinder(d1 = d1, d2 = d2, h = h);
  for (i = [0 : 2 : steps - 1]) {
    rotate([0, 0, i * step_angle])
      translate([- (d1 / 2) - antislip_w , -antislip_w / 2, 0])
        cylinder_part(d1 + antislip_w * 2, d2 + antislip_w * 2, h, antislip_w);
  }
}

module cylinder_part(w1, w2, h, d) {
  w2_offset = (w1 - w2) / 2;
  
  polyhedron(
    points = [
      [0, 0, 0],
      [w1, 0, 0],
      [w1, d, 0],
      [0, d, 0],
      [w2_offset, 0, h],
      [w2 + w2_offset, 0, h],
      [w2 + w2_offset, d, h],
      [w2_offset, d, h],
    ],
    faces = [
      [0, 1, 2, 3],
      [7, 6, 5, 4],
      [4, 5, 1, 0],
      [5, 6, 2, 1],
      [6, 7, 3, 2],
      [0, 3, 7, 4]
    ]
  );
}

function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];

function cartesian_to_polar(x, y) = [sqrt(pow(x, 2) + pow(y, 2)), atan(y / x)];
