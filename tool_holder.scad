$fn = 32;

tolerance = 0.2;

w = 20;
max_d = 203;
inner_h = 120;
thickness = 2;
tool_distance = 2;

// [hole, size]
tool_list = [
  [7.2, 15],
  [7.2, 15.1],
  [7.6, 14.9],
  [7.6, 15.4],
  [9.2, 19.7],
  [9.4, 21.2],
  
  [3, 15],
  [7.2, 14.45],
  [6, 29.55],
  [11, 20]
];

// returns [[hole, position], ...]
function _tool_data(start = 0, i = 0, acc = []) =
  i == len(tool_list)
  ? acc
  : _tool_data(
    start + tool_list[i][1] + tool_distance,
    i + 1,
    concat(
      acc,
      [[tool_list[i][0], [0, start + tool_list[i][1] / 2, 0]]]
    )
  );

function _holder_depth(tool_data) =
  let (last_i = len(tool_data) - 1,
      res = tool_data[last_i][1][1]
      + tool_list[last_i][1] / 2)
    assert(res <= max_d)
    res;

tool_data = _tool_data();
holder_d = _holder_depth(tool_data);

union() {
  cube([thickness, holder_d, inner_h + thickness]);
  cube([w, thickness, inner_h + thickness]);
  translate([0, holder_d - thickness, 0])
    cube([w, thickness, inner_h + thickness]);
  translate([w - thickness, 0, 0])
    cube([thickness, holder_d, 10 + thickness]);
  difference() {
    cube([w, holder_d, thickness]);
    for (tool = _tool_data()) {
      translate([w / 2, 0, 0])
        translate(tool[1])
          cylinder(d = tool[0] + tolerance * 2, h = thickness);
    }
  }
}
