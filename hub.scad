// params
bearing_d = 22;
bearing_h = 7;
bearingHole_d = 8;
spool_d = 32;
spool_h = 86;
// endparams

base_h = (96 - spool_h) / 2;

module innerHole(d, h) {
	d = d + 0.5;
	n = max(round(2 * d),3);
   rotate([0,0,180])
		cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

difference() {
	cylinder(d = spool_d + 6, h = base_h);
	innerHole(d = bearingHole_d + 1, h = base_h);
}

translate([0, 0, base_h])
	difference() {
		cylinder(d = spool_d, h = bearing_h);
		innerHole(d = bearing_d, h = bearing_h);
	}
