module sine_wave(amplitude, length, thickness = 1, phase = 0, omega = 1) {
  steps = 32;
  step = 360 / steps;
  l_step = length / steps;

  points = [
    for (i = [0:1:steps])
      [i * l_step, amplitude * sin(omega * (i * step) + phase)]
  ];

  for (i = [0:1:steps - 1]) {
    hull() {
      translate(points[i])
        circle(d = thickness);
      translate(points[i + 1])
        circle(d = thickness);
    }
  }
}
