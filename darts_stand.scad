$fn = 32;

tip_d = 3;
tip_h = 27;
spacing = 18;

cols = 3;
rows = 3;

difference() {
  cube([(rows + 1) * spacing, (cols + 1) * spacing, tip_h]);
  for (col = [1:cols]) {
    for (row = [1:rows]) {
      translate([col * spacing, row * spacing, -1])
        cylinder(h = tip_h + 2, d = tip_d);
    }
  }
}