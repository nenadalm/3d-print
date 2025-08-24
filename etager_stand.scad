$fn = 128;

clearance = 0.07;
layer_height = 0.3;

bowl_r = 375;
bolt_d = 5;
bolt_head_h = 3;
bolt_head_d = 9.4;
thickness = 2;
stand_h = 15;

difference() {
  cylinder(h = stand_h, d = 100);
  translate([0, 0, bowl_r + thickness + bolt_head_d])
    sphere(r = bowl_r);
  translate([0, 0, -1])
    cylinder(h = stand_h + 2, d = bolt_d + clearance * 2);
  translate([0, 0, -1])
    cylinder(h = bolt_head_d + 1, d = bolt_head_d + clearance * 2);  
}
translate([0, 0, thickness + bolt_head_d - layer_height])
  cylinder(h = layer_height, d = 100);