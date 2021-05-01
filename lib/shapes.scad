module shapes_wedge(size) {
  width = size[0];
  depth = size[1];
  height = size[2];
  polyhedron(
    points = [
      [0, 0, 0],
      [width, 0, 0],
      [width, depth, 0],
      [0, depth, 0],
      [0, 0, height],
      [width, 0, height]
    ],
    faces = [
      [0, 1, 2, 3],
      [0, 4, 5, 1],
      [0, 3, 4],
      [1, 5, 2],
      [4, 3, 2, 5]
    ]
  );
}
