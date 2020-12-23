d = 48;
h = 3.7;
inner_d = 6.6;
$fn = 32;

inner_h = 7.02;
c_d = 2.7;
c_w = 3.5;
c_h = 12.3;

print_margin = 5;

//helmet_nut();
print_helmet_nut();

module print_helmet_nut() {
	nut_cylinder();
	translate([0, 0, h])
		difference() {
			thread();
			translate([-c_w / 2, -c_h / 2, inner_h - c_d])
				latch();
		}

	translate([d / 2 + print_margin, -c_h / 2, 0])
		latch();
}

module helmet_nut() {
	nut_cylinder();
	translate([0, 0, h]) {
		thread();
		translate([-c_w / 2, -c_h / 2, inner_h - c_d])
			latch();
	}
}

module nut_cylinder() {
	cylinder(h = 3.7, d = 48);
}

module thread() {
	cylinder(h = inner_h, d = inner_d);
}

module latch() {
	cube([c_w, c_h, c_d]);
}