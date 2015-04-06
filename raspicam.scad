$fn = 32;

thickness = 2.5;

// raspberry pi
case_width = 85;
case_height = 56;
case_radius = 3;
case_hole_d = 2.75;
case_hole_d2 = 6.2;
raspi_thickness = 1.3;
case_depth = 22;
case_margin = 10;

box();
//bottom_part_print();
//right_part_print();
//front_part_print();
//left_part_print();
//rear_part_print();
//top_part_print();
//cam_holder();

module cam_holder() {
	depth = 3;
	width = 14.15;
	height = 14.15;
	hole_d = 7.45;
	hole_r = hole_d / 2;

	lens_width = 7.9;
	lens_height = 7.9;
	lens_depth = 5.25;

	difference() {
		cube([width, height, lens_depth]);
		translate([width / 2 - lens_width / 2, height / 2 - lens_height / 2, 0])
			cube([lens_width, lens_height, lens_depth]);
	}
}

module box() {
	rear_part();
	front_part();
	right_part();
	left_part();
	bottom_part();
	top_part();
}

module top_part_print() {
	translate([0, 0, -case_depth - thickness])
		top_part();
}

module rear_part_print() {
	translate([0, 0, case_width + thickness])
		rotate([0, 90, 0])
			difference() {
				rear_part();
				left_part();
				right_part();
			}
}

module left_part_print() {
	translate([0, 0, thickness])
		rotate([90, 0, 0])
			difference() {
				left_part();
				bottom_part();
				top_part();
			}
}

module right_part_print() {
	translate([0, 0, case_height + thickness])
		rotate([-90, 0, 0])
		difference() {
			right_part();
			bottom_part();
			top_part();
		}
}

module front_part_print() {
	translate([0, 0, thickness])
	rotate([0, -90, 0])
		difference() {
			front_part();
			right_part();
			translate([0, -case_height - thickness,0])
				right_part();
		}
}

module bottom_part_print() {
	bottom_part();
}

module rear_part() {
	height = 5;
	translate([case_width, -2 * thickness, -thickness])
		rotate([90, 0, 90]) {
			difference() {
				round_cube([case_height + 4 * thickness, case_depth + 4 * thickness, thickness], case_radius);
				translate([0, case_depth - height / 4 - height, 0]) {
					translate([thickness + case_height + thickness, 2 * thickness, 0])
						cube([thickness, height / 4 + 2, thickness]);
					translate([thickness, 2 * thickness, 0])
						cube([thickness, height / 4, thickness + 10]);
				}
				translate([2 * thickness + ((case_height - 52) / 2), 2 * thickness + 2.2, -2])
					cube([52, 16, thickness + 4]);
			}
		}
}

module front_part() {
	translate([-thickness, -2 * thickness, -thickness])
		rotate([90, 0, 90]) {
			difference() {
				round_cube([case_height + 4 * thickness, case_depth + 4 * thickness, thickness], case_radius);
				translate([2 * thickness + case_height / 2 - 10, 2 * thickness, 0])
					cube([20, 2.2, 3.5]);
				translate([2 * thickness + 1.15, 2 * thickness + 8, 0])
					cube([20, 2.2, 3.5]);
			}
		}
}

module top_part() {
	width = 20;
	offset = 10;

	switcher_width = 45;
	switcher_height = 42;
	switcher_board_thickness = 1.6;
	switcher_margin_bottom = 2.2;
	parts_depth = 9;

	translate ([0, 0, case_depth + thickness]) {
		difference() {
			round_cube([case_width, case_height, thickness], case_radius);
			translate([11, switcher_height + 2 * thickness, 0])
				cube([switcher_width + 2 * thickness, 4, thickness]);
		}

		translate([offset, - thickness, 0])
			round_cube([width, thickness * 2, thickness], case_radius);
		translate([case_width - width - offset, - thickness, 0])
			round_cube([width, thickness * 2, thickness], case_radius);
		translate([offset, - thickness + case_height, 0])
			round_cube([width, thickness * 2, thickness], case_radius);
		translate([case_width - width - offset, - thickness + case_height, 0])
			round_cube([width, thickness * 2, thickness], case_radius);

		translate([11, 0, thickness]) {
			difference() {
				cube([2 * thickness + switcher_width, 2 * thickness + switcher_height, switcher_margin_bottom + switcher_board_thickness]);
				translate([thickness, thickness, 0])
					cube([switcher_width, switcher_height, switcher_margin_bottom + switcher_board_thickness]);
			}

			translate([thickness, thickness, 0]) {
				linear_extrude(thickness) {
					polygon([[0, 0], [0, 5], [5, 0]]);
					polygon([[0, switcher_height], [0, switcher_height - 5], [5, switcher_height]]);
					polygon([[switcher_width, 0], [switcher_width, 5], [switcher_width - 5, 0]]);
					polygon([[switcher_width, switcher_height], [switcher_width - 5, switcher_height], [switcher_width, switcher_height - 5]]);
				}
			}
		}
	}
}

module left_part() {
	width = 10;
	height = 5;
	offset = 5;
	radius = 2.5;

	translate([0, 0, -thickness])
		rotate([90, 0, 0]) {
			difference() {
				union() {
					round_cube([case_width, case_depth + thickness * 4, thickness], case_radius);
					translate([-width / 2, offset, 0])
						difference() {
							round_cube([width, height, thickness], radius);
							translate([width / 2 - thickness, 0, 0])
								cube([thickness, height / 4, thickness]);
						}
					translate([case_width -width / 2, offset, 0])
						difference() {
							round_cube([width, height, thickness], radius);
							translate([width / 2, 0, 0])
								cube([thickness, height / 4, thickness]);
						}
					translate([-width / 2, case_depth + thickness * 2 - offset, 0])
						difference()  {
							round_cube([width, height, thickness], radius);
							translate([width / 2 - thickness, height - height / 4, 0])
								cube([thickness, height / 4, thickness]);
						}
					translate([case_width -width / 2, case_depth + thickness * 2 - offset, 0])
						difference()  {
							round_cube([width, height, thickness], radius);
							translate([width / 2, height - height / 4, 0])
								cube([thickness, height / 4, thickness]);
						}
				}
				translate([case_width -width / 2, offset, 0]) {
					translate([0, height / 2.5, 0])
						cube([width, height / 5, thickness]);
					rotate([0, 0, 90])
						translate([1 - height / 2 - offset + 3 * (height / 5), -height / 5, 0])
							cube([-1 + height / 2 + offset, height / 5, thickness]);
				}
				translate([6, 2 * thickness + 2.2 + raspi_thickness, 0])
					cube([case_width - 25 - 6, 7, thickness]);
				translate([-width / 2, offset, 0]) {
					translate([0, height / 2.5, 0])
						cube([width, height / 5, thickness]);
					rotate([0, 0, 90])
						translate([1 - height / 2 - offset + 3 * (height / 5), -width, 0])
							cube([-1 + height / 2 + offset - height / 5, height / 5, thickness]);
				}
			}
		}
}

module right_part() {
	width = 10;
	height = 5;
	offset = 5;
	radius = 2.5;

	translate([0, case_height + thickness, -thickness])
		rotate([90, 0, 0]) {
			difference() {
				union() {
					round_cube([case_width, case_depth + thickness * 4, thickness], case_radius);
					translate([-width / 2, offset, 0])
						difference() {
							round_cube([width, height, thickness], radius);
							translate([width / 2 - thickness, 0, 0])
								cube([thickness, height / 4, thickness]);
						}
					translate([case_width -width / 2, offset, 0])
						difference() {
							round_cube([width, height, thickness], radius);
							translate([width / 2, 0, 0])
								cube([thickness, height / 4, thickness]);
						}
					translate([-width / 2, case_depth + thickness * 2 - offset, 0])
						difference()  {
							round_cube([width, height, thickness], radius);
							translate([width / 2 - thickness, height - height / 4, 0])
								cube([thickness, height / 4, thickness]);
						}
					translate([case_width -width / 2, case_depth + thickness * 2 - offset, 0])
						difference()  {
							round_cube([width, height, thickness], radius);
							translate([width / 2, height - height / 4, 0])
								cube([thickness, height / 4, thickness]);
						}
				}
				translate([-width / 2, offset, 0]) {
					translate([0, height / 2.5, 0])
						cube([width, height / 5, thickness]);
					rotate([0, 0, 90])
						translate([1 - height / 2 - offset + 3 * (height / 5), -width, 0])
							cube([-1 + height / 2 + offset - height / 5, height / 5, thickness]);
				}
				translate([case_width -width / 2, offset, 0]) {
					translate([0, height / 2.5, 0])
						cube([width, height / 5, thickness]);
					rotate([0, 0, 90])
						translate([1 - height / 2 - offset + 3 * (height / 5), -height / 5, 0])
							cube([-1 + height / 2 + offset, height / 5, thickness]);
				}
			}
		}
}

module bottom_part() {
	round_cube([case_width, case_height, thickness], case_radius);

	width = 20;
	offset = 10;
	translate([offset, - thickness, 0])
		round_cube([width, thickness * 2, thickness], case_radius);
	translate([case_width - width - offset, - thickness, 0])
		round_cube([width, thickness * 2, thickness], case_radius);
	translate([offset, - thickness + case_height, 0])
		round_cube([width, thickness * 2, thickness], case_radius);
	translate([case_width - width - offset, - thickness + case_height, 0])
		round_cube([width, thickness * 2, thickness], case_radius);

	translate([3.5, 3.5, 0])
		cylinder(thickness + 2.2, d = case_hole_d2);
	translate([3.5, case_height - 3.5, 0])
		cylinder(thickness + 2.2, d = case_hole_d2);
	translate([3.5 + 58, 3.5, 0])
		cylinder(thickness + 2.2, d = case_hole_d2);
	translate([3.5 + 58, case_height - 3.5, 0])
		cylinder(thickness + 2.2, d = case_hole_d2);

	translate([3.5, 3.5, 0])
		cylinder(thickness + 2.2 + raspi_thickness, d = case_hole_d);
	translate([3.5, case_height - 3.5, 0])
		cylinder(thickness + 2.2 + raspi_thickness, d = case_hole_d);
	translate([3.5 + 58, 3.5, 0])
		cylinder(thickness + 2.2 + raspi_thickness, d = case_hole_d);
	translate([3.5 + 58, case_height - 3.5, 0])
		cylinder(thickness + 2.2 + raspi_thickness, d = case_hole_d);
}

module round_cube(dimensions, radius) {
	// todo: doesn't work for smaller parts where d < x || d < y
	diameter = 2 * radius;
	if (dimensions[0] < diameter || dimensions[1] < diameter) {
		echo("[warning]: Round cubes with dimension lower than diameter doesn't works properly.");
	}

	hull() {
		translate([radius, radius, 0])
			cylinder(dimensions[2], radius, radius);
	   translate([dimensions[0] - radius, radius, 0])
			cylinder(dimensions[2], radius, radius);
		translate([radius, dimensions[1] - radius, 0])
			cylinder(dimensions[2], radius, radius);
		translate([dimensions[0] - radius, dimensions[1] - radius, 0])
			cylinder(dimensions[2], radius, radius);
		}
}