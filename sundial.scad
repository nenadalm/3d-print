$fn = 32;

L = 50.12;

d = 150;
thickness = 2;

font_size = 10;
gmt_offset = 2;

function hour_angle(hours) = atan(sin(L) * tan(15 * hours));
function polar_to_cartesian(length, angle) = [length * cos(angle), length * sin(angle)];

module plate() {
  cylinder(d = thickness * 4, h = thickness);
  for (hours = [1:12]) {
    rotate([0, 0, hour_angle(hours)])
      translate([-thickness / 2, 0, 0])
        cube([thickness, d / 2, thickness]);
  }
  rotate([0, 0, hour_angle(-6)])
      translate([-thickness / 2, 0, 0])
        cube([thickness, d / 2, thickness]);

  alpha = 180 - 90 - L;
  translate([-thickness / 2, 0, thickness])
    rotate([90, 0, 90])
      linear_extrude(thickness)
        polygon(points=[
          [0, 0],
          [sin(alpha) * (d / 2), cos(alpha) * (d / 2)],
          [sin(alpha) * (d / 2), 0]
        ]);
}

module dial(gmt_offset) {
  for (hours = [1:12]) {
    linear_extrude(thickness)
      rotate([0, 0, -hour_angle(hours - gmt_offset)])
        translate([0, d / 2 + thickness * 2 - 0.5, 0])
          text(str(hours), halign = "center", size = font_size);
  }
  linear_extrude(thickness)
    rotate([0, 0, hour_angle(6)])
        translate([0, d / 2 + thickness * 2 - 0.5, 0])
          text(str(6 + gmt_offset), halign = "center", size = font_size);
  rotate_extrude(angle = 180)
    translate([d / 2 + thickness, 0, 0])
      square(thickness);
}

plate();
dial(gmt_offset);