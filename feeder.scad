$fn = 32;

thickness = 1;

feeder_w = 20;
feeder_h = 50;

grille_fill_h = 2;

feeder_fills_count = 11;
cover_count = 5;
chunks = 8;


sector_angle = (180 * thickness) / feeder_w;

feeder();

module feeder() {
    for (i = [0:2:feeder_fills_count - 1])
        translate([0, 0, i * grille_fill_h])
            step();

    for (i = [1:2:feeder_fills_count - 1])
        translate([0, 0, i * grille_fill_h])
            sectors();

    rotate([0, 0, 90])
        cover_grille();
    cover_grille();
    translate([0, 0, (feeder_fills_count - 1) * grille_fill_h]) {
        rotate([0, 0, 90])
            cover_grille();
        cover_grille();
    }
}

module cover_grille() {
    w = feeder_w / cover_count;
    r = feeder_w / 2;
    
    intersection() {
        last_pos = cover_count * w + thickness;
        margin_left = (feeder_w - last_pos) / 2;

        for (i = [0:cover_count]) {
            translate([i * w - (feeder_w / 2) + margin_left, -feeder_w / 2, 0])
                cube([thickness, feeder_w, grille_fill_h]);
        }
        cylinder(h = grille_fill_h, d = feeder_w);
    }
}

module sectors() {
    O = PI * feeder_w;
    angle = O / chunks;
    angle = 360 / chunks;

    intersection() {
        for (i = [0:chunks - 1])
            rotate([0, 0, i * angle])
                linear_extrude(height = grille_fill_h)
                    sector();
        step();
    }
}

module sector() {
    circle_sector(r = feeder_w / 2, angle = sector_angle);
}

module step() {
    difference() {
        cylinder(h = grille_fill_h, d = feeder_w);
        cylinder(h = grille_fill_h, d = feeder_w - thickness * 2);
    }
}

module circle_sector(r, angle) {
    c = r / cos(angle / 2);
    A = cartesian_from_polar(length = c, angle = 0);
    B = cartesian_from_polar(length = c, angle = angle);

    intersection() {
        circle(d = r * 2);
        polygon(points = [
            [0, 0],
            B,
            A
        ]);
    }
}

function cartesian_from_polar(length, angle) = [ length * cos(angle), length * sin(angle)];
