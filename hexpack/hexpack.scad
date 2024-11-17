include <hexpack-constants.scad>;

function cube_subtract(vectorA, vectorB) = [
  vectorA - vectorB
];

function cube_distance(a, b) = 
  let (vec = cube_subtract(a, b)) 
    max(abs(vec[Q]), abs(vec[R]), abs(vec[S]));

function cube_add(vectorA, vectorB) = vectorA + vectorB;

function cube_scale(vector, factor) =
  let (vector = assert_cube_coordinate(vector))
  vector * factor;


function cube_neighbor(vector, direction) = 
    let (vector = assert_cube_coordinate(vector))
    cube_add(vector, cube_direction_vectors[direction]);

function diameter_to_scale_factor(diameter) = diameter * SQRT3_THIRD;

function orientation_matrix_from_label(orientationLabel=POINTY) = orientationLabel == POINTY ? orientation_layout_pointy : orientationLabel == FLAT ? orientation_layout_flat : undef;

function axial_mat_to_cube(point) = [point[0], point[1], - point[0] - point[1]];

function assert_cube_coordinate(point) = 
  assert(point[Q] + point[R] + point[S] == 0, "coordinate is not fullfiling q + r + s = 0 constraint")
  point;

function hexpack_compute_translation_vector(point, diameter, orientation=POINTY, origin=[0, 0, 0], axis_shift=0) =
let(origin = assert_cube_coordinate(origin))
let(point = assert_cube_coordinate(point))
assert(orientation, "You need to specify an orientation, either FLAT or POINTY")
assert(point, "point of form [s, q, r] is missing")
assert(diameter, "diameter missing")
let (orientationMatrix = orientation_matrix_from_label(orientation))
// not ideal but works at some extent, a more elegant sollution would be to use matrixes to pad the axes
let (point = [point[axis_shift%3], point[(axis_shift+1)%3], point[(axis_shift+2)%3]])
//echo(point, cube_direction_vectors[axis_shift], point * cube_direction_vectors[axis_shift])
//let (point = point * cube_direction_vectors[axis_shift])

let (point = cube_add(point, origin))
let (factor = diameter_to_scale_factor(diameter))
let (point = cube_scale(point, factor))
    [
            orientationMatrix[f0] * point[Q] + orientationMatrix[f1] * point[R],
            orientationMatrix[f2] * point[Q] + orientationMatrix[f3] * point[R],
            0
    ];


module hexpack_position_cell(q, r, diameter, orientation=POINTY, origin=[0, 0, 0], axis_shift=0) {  
  let (point = axial_mat_to_cube(point=[q, r]))
    translate(hexpack_compute_translation_vector(point, diameter, orientation, origin, axis_shift))
    rotate([0, 0, orientation == POINTY ? 30:0])
    children(0);
  }

module hexpack_hexagon_grid(N, diameter, orientation = POINTY, origin=[0, 0, 0], axis_shift=0) {
    for (q = [-N:+N])
    for (r = [max(-N, -q - N): min(+N, -q + N)])
    hexpack_position_cell(q, r, diameter, orientation, origin, axis_shift)
          children(0);
}

module hexpack_parallelogram_gird(width, length, diameter, orientation=POINTY, origin=[0, 0, 0], axis_shift=0) {
    for (q = width<0?[width:0]:[0:width])
    for (r = length<0?[length:0]:[0:length])
    hexpack_position_cell(q, r, diameter, orientation, origin, axis_shift)
          children(0);
}


module hexpack_triangle_grid(side = 3, diameter, orientation=POINTY, origin=[0, 0, 0], axis_shift=0) {
    assert(side>0, "side should be greatear than 0")
    let (side = side - 1 )
    for (q = [0:side])
    for (r = [0:side - q])
    hexpack_position_cell(q, r, diameter, orientation, origin, axis_shift)
        children(0);
}

module hexpack_rectangle_grid(left, right, top, bottom, diameter, orientation=POINTY, origin=[0, 0, 0], axis_shift=0) {
    for (r = [top: bottom])
    let (r_offset = floor(r / 2.0))
    for (q = [left - r_offset:right - r_offset])
    hexpack_position_cell(q, r, diameter, orientation, origin, axis_shift)
        children(0);
}
