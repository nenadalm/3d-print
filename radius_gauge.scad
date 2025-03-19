$fn = 128;

first_layer_height = 0.2;
layer_height = 0.3;

text_depth = first_layer_height + layer_height; // 0.5
depth = first_layer_height + layer_height * 3; // 1.1

module gauge(w, h, r) {
  h2 = r - sqrt(r * r - (w / 2) * (w / 2));

  difference() {
    linear_extrude(depth) {
      difference() {
        translate([0, h / 2, 0])
          square([w, h], center = true);
        translate([0, r + h - h2, 0])
          circle(r = r);
      }
    }

    translate([0, 0, depth - text_depth])
      linear_extrude(depth) {
        translate([0, 4, 0])
          text(str(r), size = 4, valign="center", halign = "center", font="Noto Sans");
      }
  }
}

//gauge(w = 100, h = 20, r = 200);
//gauge(w = 100, h = 20, r = 350);
//gauge(w = 100, h = 20, r = 375);
//gauge(w = 100, h = 20, r = 400);
//gauge(w = 100, h = 20, r = 600);
//gauge(w = 100, h = 20, r = 800);
