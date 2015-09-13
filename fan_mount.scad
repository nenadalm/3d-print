$fn = 32;

hole_w = 8;
screw = 2.5;
fan_d1 = 43.3;
fan_d2 = 60.5;
fan_screw_d = 3.3;
fan_screws_outer_length = 40.6;

thickness = 4;


fan_screw_x = (fan_screws_outer_length - fan_screw_d) / 2;

fan_inner_d = fan_d1 + (fan_d2 - fan_d1) / 2;
fan_screw_y = sqrt(pow(fan_inner_d / 2, 2) - pow(fan_screw_x, 2));
    
w = hole_w + thickness * 2;
dx = (fan_d2 - fan_d1) / 2;
h = 10 + dx;

difference() {
    translate([-w / 2, fan_d2 / 2 - dx, 0])
        cube([w, h, thickness]);
    translate([-hole_w / 2, fan_d2 / 2 - dx, 0])
        cube([hole_w, h, thickness]);
    translate([-w / 2, fan_d2 / 2 + h - screw - dx, thickness / 2])
        rotate([0, 90, 0])
            cylinder(d = screw, h = w);
}

difference() {
    difference() {
        cylinder(d = fan_d2, h = thickness);
        cylinder(d = fan_d1, h = thickness);
    }

    translate([-fan_screw_x, fan_screw_y, 0]) 
        cylinder(d = fan_screw_d, h = thickness);    
    translate([fan_screw_x, fan_screw_y, 0])
            cylinder(d = fan_screw_d, h = thickness);

    translate([-fan_d2 / 2, -fan_d2 + fan_screw_y - screw * 2, 0])
        cube([fan_d2, fan_d2, thickness]);
}
