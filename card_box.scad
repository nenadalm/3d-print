walls = 2;
layer_width = 0.4;

thickness = walls * layer_width;
clearance = 0.07;
loose_clearance = 0.14;

//deck_size = [63, 89, 38]; // Star Realms
deck_size = [61, 104, 10]; // german-suited

card_width = deck_size[0];
card_height = deck_size[1];
deck_height = deck_size[2];

outside_box = [
  card_height + loose_clearance * 2 + thickness * 2,
  deck_height + loose_clearance * 2 + thickness * 2,
  card_width + loose_clearance * 2 + thickness * 2
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
  translate([outside_box[0] / 2, -1, outside_box[2]])
      rotate([-90, 0, 0])
        cylinder(h = outside_box[1] + 2, d = outside_box[0] / 2 - thickness * 2, $fn = 84);  
  }
}

box();