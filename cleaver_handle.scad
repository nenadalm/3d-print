/*
 * Print settings
 * ==============
 *
 * infill: honeycomb: 20%
 */

tang_w0 = 3.5;
tang_w1 = 5.8;
tang_w2 = 5.8;

tolerance = 0.2;

difference() {
    translate([0, 0, 80 + 52])
        rotate([0, 90, 0])
            handle();
    translate([0, 10 - 16, 80 + 52 - 128.5])
        tang();
}

module tang() {
    polyhedron(
        points=[
            [-tang_w0 / 2 - tolerance, 0, 0],
            [-tang_w0 / 2 - tolerance, 4.5, 0],
            [tang_w0 / 2 + tolerance, 4.5, 0],
            [tang_w0 / 2 + tolerance, 0, 0],

            [-tang_w1 / 2 - tolerance, 0, 120.8],
            [-tang_w1 / 2 - tolerance, 12.7, 120.8],
            [tang_w1 / 2 + tolerance, 12.7, 120.8],
            [tang_w1 / 2 + tolerance, 0, 120.8],

            [-tang_w2 / 2 - tolerance, 0, 128.5],
            [-tang_w2 / 2 - tolerance, 16, 128.5],
            [tang_w2 / 2 + tolerance, 16, 128.5],
            [tang_w2 / 2 + tolerance, 0, 128.5],
        ],
        faces=[
            [3, 2, 1, 0],
            [0, 1, 5, 4],
            [1, 2, 6, 5],
            [2, 3, 7, 6],
            [4, 7, 3, 0],
            [4, 5, 9, 8],
            [5, 6, 10, 9],
            [6, 7, 11, 10],
            [8, 11, 7, 4],
            [8, 9, 10, 11],
        ]
    );
}

module handle() {
    union() {
        difference() {
            rotate([0, 90, 0])
                rotate_extrude()
                    rotate([0, 0, 90])
                        translate([15, 10, 0])
                            sinusoid(
                                points = 32,
                                period = 160,
                                amplitude = 10,
                                thickness = 1
                            );
            translate([80 + 52, 0, 0])
                rotate([0, 90, 0])
                    cylinder(d = 40, h = 160);
        }
        rotate([0, 90, 0])
            cylinder(d = 20, h = 80 + 52);
    }
}

module sinusoid(points, period, amplitude, thickness) {
    intersection() {
        difference() {
            polygon(points = sinusoid_vectors(points = points, period = period, a = amplitude));
        }
        square([period / 2, amplitude]);
    }

    translate([-asin(thickness / amplitude) / (360 / period), 0, 0])
        intersection() {
            difference() {
                polygon(points = sinusoid_vectors(points = points, period = period, a = amplitude));
            }
            translate([period / 2, -amplitude, 0])
                square([period / 2, amplitude]);
        }
}

/**
 * @param points Total amount of points
 * @param period Length of the period
 * @param a Amplitude of the sinusoid
 *
 * @return vector Vector of [x, y] vectors
 */
function sinusoid_vectors(points, period, a = 1, res = []) =
    points == len(res)
        ? res
        : sinusoid_vectors(
            points = points,
            period = period,
            a = a,
            res = concat(
                res,
                [
                    [
                        current_point(i = len(res), n = points, size = period),
                        a * sin(current_point(i = len(res), n = points, size = 360))
                    ]
                ]
            )
        );

/**
 * @param i Current point (numbered from 0)
 * @param n Total amount of points
 * @param size Size to split by "n" points
 *
 * @return number
 */
function current_point(i, n, size) = (size / (n - 1)) * i;
