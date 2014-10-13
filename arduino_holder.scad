// arduino
width = 101.6;
height = 53.3;
thickness = 2;
hole_d = 3.2;
// end arduino

sth = 5;

union() {

difference() {
	difference() {
		translate([-sth, -sth, -thickness]) {
			cube([width + sth * 2, height + sth * 2, thickness * 2]);
		}

		// arduino shelf
		translate([0, 0, -thickness]) cube([width, height, thickness * 2]);
}
}

// holes
difference() {
	translate([14 - hole_d, 0, -thickness]) hole_holder();
	translate([14, 2.5, -thickness]) hole();
}
difference() {
	translate([15.3 - hole_d, height - hole_d * 2, -thickness]) hole_holder();
	translate([15.3, height - 2.5, -thickness]) hole();
}
difference() {
	translate([99.7 - hole_d * 2, 0, -thickness]) hole_holder();
	translate([99.7 - hole_d, 2.5, -thickness]) hole();
}

psu_mount();

}

module hole_holder() {
	cube([hole_d * 2, hole_d * 2, thickness]);
}

module hole() {
	cylinder(h = thickness, d = hole_d, $fn = 32);
}

module psu_mount() {
	difference() {
		translate([0, -sth, thickness]) cube([85, 5, 10]);
		translate([10, 0.5, 7]) rotate([90, 0, 0]) cylinder(h = 6, r = 1.75, $fn=32);
		translate([75, 0.5, 7]) rotate([90, 0, 0]) cylinder(h = 6, r = 1.75, $fn=32);
	}
}
