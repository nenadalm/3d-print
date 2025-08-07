walls = 2;
layer_width = 0.4;

thickness = walls * layer_width;
clearance = 0.07;
loose_clearance = 0.14;

card_width=63;
card_height=89;
deck_height=38;

outside_box = [
  card_height + loose_clearance * 2 + thickness * 2,
  deck_height + loose_clearance * 2 + thickness * 2,
  card_width + loose_clearance * 2 + thickness * 3
];

module box() {
  inside_box = [
    card_height + loose_clearance * 2,
    deck_height + loose_clearance * 2,
    card_width + loose_clearance * 2 + thickness + 1,
  ];
  
  difference() {
    cube(outside_box);
    translate([thickness, thickness, thickness])
      cube(inside_box);
    translate([outside_box[0] / 4, -1, outside_box[2] - thickness])
      cube([outside_box[0] / 2, outside_box[1] + 2, thickness + 1]);
    translate([-1, outside_box[1] / 4, outside_box[2] - thickness])
      cube([outside_box[0] + 2, outside_box[1] / 2, thickness + 1]);
  translate([outside_box[0] / 2, -1, outside_box[2]])
      rotate([-90, 0, 0])
        cylinder(h = outside_box[1] + 2, d = outside_box[0] / 2 - thickness * 2, $fn = 84);  
  }
}

module box_lid() {
    outside_box_lid = [
      outside_box[0] - thickness * 2 - clearance * 2,
      outside_box[1] - thickness * 2 - clearance * 2,
      thickness
    ];
  
  translate([thickness + clearance, thickness + clearance])
    cube(outside_box_lid);
  
  translate([outside_box[0] / 4 + clearance, 0, outside_box_lid[2] - thickness])
    cube([outside_box[0] / 2 - clearance * 2, outside_box[1], thickness]);
  translate([0, outside_box[1] / 4 + clearance, 0])
      cube([outside_box[0], outside_box[1] / 2 - clearance * 2, thickness]);
}

box();
translate([0, 0, outside_box[2]])
  box_lid();