walls = 2;
layer_width = 0.4;

thickness = walls * layer_width;
clearance = 0.07;
loose_clearance = 0.14;

monster_token_d = 15;
monster_token_h = 3;
monster_token_n = 8;
monster_token_outside_box = [
  monster_token_d * monster_token_n + loose_clearance * 2 + thickness * 2,
  monster_token_d + loose_clearance * 2 + thickness * 2,
  monster_token_h + loose_clearance * 2 + thickness * 3
];

module monster_token_box() {
  inside_box = [
    monster_token_d * monster_token_n + loose_clearance * 2 + thickness + 1,
    monster_token_d + loose_clearance * 2,
    monster_token_h + loose_clearance * 2 + thickness + 1
  ];
  
  difference() {
    cube(monster_token_outside_box);
    translate([thickness, thickness, thickness])
      cube(inside_box);
    translate([monster_token_outside_box[0] / 4, -1, monster_token_outside_box[2] - thickness])
      cube([monster_token_outside_box[0] / 2, monster_token_outside_box[1] + 2, thickness + 1]);
    translate([-1, monster_token_outside_box[1] / 4, monster_token_outside_box[2] - thickness])
      cube([thickness + 2, monster_token_outside_box[1] / 2, thickness + 1]);
  }
}

module monster_token_lid() {
  outside_box = [
    monster_token_outside_box[0] - thickness - clearance,
    monster_token_outside_box[1] - thickness * 2 - clearance * 2,
    thickness
  ];
  depth = monster_token_h + loose_clearance * 2 + thickness * 2 - thickness - clearance;
  translate([thickness + clearance, thickness + clearance, 0]) {
    cube(outside_box);
    translate([outside_box[0] - thickness, 0, -depth])
      cube([outside_box[2], outside_box[1], depth]);
  }
  
  translate([monster_token_outside_box[0] / 4 + clearance, 0, outside_box[2] - thickness])
    cube([monster_token_outside_box[0] / 2 - clearance * 2, monster_token_outside_box[1], thickness]);
  translate([0, monster_token_outside_box[1] / 4 + clearance, 0])
      cube([outside_box[0], monster_token_outside_box[1] / 2 - clearance * 2, thickness]);
}

//monster_token_box();
//translate([0, 0, 6])
//  monster_token_lid();

for (i = [0:5]) {
  translate([0, (monster_token_outside_box[1] - thickness) * i, 0]) {
    monster_token_box();
    translate([0, 0, 6])
      monster_token_lid();
  }
}