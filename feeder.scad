$fn = 32;

thickness = 1;

feeder_w = 41;
feeder_h = 50;

grille_fill_h = 2;
grille_space_h = 4;

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
            in_between_platform_part(h = grille_space_h);
    }
}

module in_between_platform_part(h = grille_fill_h) {
    r = feeder_w / 2;
    angle = 360 / chunks;
    length = feeder_w * sin (angle / 2);
    v = sqrt(r * r - (length / 2) * (length / 2));
    vector = cartesian_from_polar(length = r, angle = angle);
    
    difference () {
        platform_substracted_sector(r = r, angle = angle, h = h);
        rotate([0, 0, angle / 2 - 90])
                translate([-length / 2 + thickness, v - thickness, 0])
                    cube([length - thickness * 2, thickness, h]);
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

module platform_substracted_sector(r, angle, h = grille_fill_h) {
    A = cartesian_from_polar(length = r, angle = 0);
    B = cartesian_from_polar(length = r, angle = angle);
    r2 = r - thickness;
    C = cartesian_from_polar(length = r2, angle =0);
    D = cartesian_from_polar(length = r2, angle = angle);

    linear_extrude(height = h)
        polygon(points = [
            B,
            A,
            C,
            D,
        ]);
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
    step = grille_space_h + grille_fill_h;
    for (i = [1:1:feeder_fills_count / 2 - 1])
        translate([0, 0, i * step])
            platform(d = feeder_w);

    for (i = [0:1:feeder_fills_count / 2 - 1])
        translate([0, 0, i * step + grille_fill_h])
            in_between_platform();

    cover_platform(d = feeder_w);
    translate([0, 0, round(feeder_fills_count / 2 - 1) * step]) {
        cover_platform(d = feeder_w);
    }
}

function cartesian_from_polar(length, angle) = [ length * cos(angle), length * sin(angle)];
