


// size of tool_post_shank: [width, depth, height]
tool_post_shank = [20,60,9.5];

bearing_diameter = 22.5;
bearing_height = 8;

bolt_diameter = 9;
bolt_height = 40;

tool_diameter = 10;



module lathe_tool(){
	difference(){
		union(){

			// tool post shank
			cube(tool_post_shank);

			// bearing block
			translate([-tool_post_shank[0]/2,-tool_post_shank[1]/3,-tool_post_shank[2]]){
				 cube([30,22,38]);
			}

		}

		// bearing cutouts
		translate([5,-bearing_diameter/1.5,15]) cylinder(h=bearing_height,r=bearing_diameter/2);
		translate([5,-bearing_diameter/1.5,-4]) cylinder(h=bearing_height,r=bearing_diameter/2);
		translate([-7,-39,15]) cube([bearing_diameter,bearing_diameter,bearing_height]);
		translate([-7,-39,-4]) cube([bearing_diameter,bearing_diameter,bearing_height]);

		// bolt cutout
		translate([5,-bearing_diameter/1.5,-10]) cylinder(h=bolt_height,r=bolt_diameter/2);
		translate([-15,-26,4.9]) cube([40,11,10.2]);
		translate([-15,-18,10]) rotate([0,90,0]) cylinder(h=40,r=tool_diameter/2);
	}
}



rotate([0,90,0]){
	lathe_tool();
}