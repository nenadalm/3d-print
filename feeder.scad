//12*14

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

module cover_platform(d) {
    width = feeder_w - thickness;
    angle = 360 / chunks;
    for (i = [0:chunks - 1]) {
        rotate([0, 0, i * angle])
            translate([-width / 2, -thickness / 2, 0])
                cube([width, thickness, grille_fill_h]);
    }

    platform(d = d);
}

module in_between_platform() {
    angle = 360 / chunks;

    for (i = [0:chunks - 1]) {
        rotate([0, 0, angle * i])
            in_between_platform_part();
    }
}

module in_between_platform_part() {
    r = feeder_w / 2;
    angle = 360 / chunks;
    length = feeder_w * sin (angle / 2);
    v = sqrt(r * r - (length / 2) * (length / 2));
    vector = cartesian_from_polar(length = r, angle = angle);
    
    difference () {
        platform_substracted_sector(r = r, angle = angle);
        rotate([0, 0, angle / 2 - 90])
                translate([-length / 2 + thickness, v - thickness, 0])
                    cube([length - thickness * 2, thickness, grille_fill_h]);
    }

}

module platform(d) {
    r = d / 2;
    angle = 360 / chunks;

    for (i = [0:chunks - 1]) {
        rotate([0, 0, angle * i])
            platform_substracted_sector(r = r, angle = angle);
    }
}

module platform_substracted_sector(r, angle) {
    difference() {
        platform_sector(r, angle);
        platform_sector(r - thickness, angle);
    }
}

module platform_sector(r, angle) {
    c = r;
    A = cartesian_from_polar(length = c, angle = 0);
    B = cartesian_from_polar(length = c, angle = angle);

    linear_extrude(height = grille_fill_h)
        polygon(points = [
            [0, 0],
            B,
            A
        ]);
}

module feeder() {
    for (i = [0:2:feeder_fills_count - 1])
        translate([0, 0, i * grille_fill_h])
            platform(d = feeder_w);

    for (i = [1:2:feeder_fills_count - 1])
        translate([0, 0, i * grille_fill_h])
            in_between_platform();

    cover_platform(d = feeder_w);
    translate([0, 0, (feeder_fills_count - 1) * grille_fill_h]) {
        cover_platform(d = feeder_w);
    }
}

function cartesian_from_polar(length, angle) = [ length * cos(angle), length * sin(angle)];