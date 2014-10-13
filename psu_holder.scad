// star parameters
frame_thickness = 5;
// end parameters

//12
//25

m3_diameter = 3.75;
m3_nut_diameter = 6.3;
original_frame_thickness = 7;
y_margin = original_frame_thickness - frame_thickness;

module psu_clamp(holeDistance = 25) {
  thickness=5;
  difference() {
    union() {
      // PSU side
      cube([65,thickness,20]);
      translate([0,-15 + y_margin,0]) cube([65,15 - y_margin,10]);
    }
    // cutout for frame
    translate([5,-11 + y_margin,0]) cube([55,frame_thickness,10]);
    translate([10,-21 + y_margin,0]) cube([45,10,10]);
    // hole for PSU mount
    translate([45 - holeDistance,7,15]) rotate([90,0,0]) cylinder(10,1.75,1.75,$fn=32);
    translate([45,7,15]) rotate([90,0,0]) cylinder(10,1.75,1.75,$fn=32);
    // bolt for clamp and nut trap
    translate([-1,0,5]) rotate([0,90,0]) cylinder(25,1.75,1.75,$fn=32);
    translate([17,0,5]) rotate([0,90,0]) cylinder(3,3.25,3.25,$fn=6);
    translate([17,-9,2.15]) cube([3,10,5.7]);
    translate([11,-10,0]) cube([0.75,40,20]);
  }
}

psu_clamp(12);  // bottom clamp
translate([0,-30,0]) psu_clamp(); // top clamp