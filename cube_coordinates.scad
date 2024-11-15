// cube coordinates constraint: q + r + s = 0
Q = 0;
R = 1;
S = 2;

f0 = 0;
f1 = 1;
f2 = 2;
f3 = 3;
b0 = 4;
b1 = 5;
b2 = 6;
b3 = 7;

orientation_layout_pointy
= [sqrt(3.0), sqrt(3.0) / 2.0, 0.0, 3.0 / 2.0, sqrt(3.0) / 3.0, -1.0 / 3.0, 0.0, 2.0 / 3.0, 0.5];

orientation_layout_flat
= [3.0 / 2.0, 0.0, sqrt(3.0) / 2.0, sqrt(3.0), 2.0 / 3.0, 0.0, -1.0 / 3.0, sqrt(3.0) / 3.0, 0.0];

FLAT = "FLAT";
POINTY = "POINTY";

cube_direction_vectors = [
        [+1, 0, -1], [+1, -1, 0], [0, -1, +1],
        [-1, 0, +1], [-1, +1, 0], [0, +1, -1]
    ];

function cube_subtract(vectorA, vectorB) = [vectorA[Q] - vectorB[Q], vectorA[R] - vectorB[R], vectorA[S] - vectorB[S]];

function cube_distance(a, b) = let (vec = cube_subtract(a, b)) max(abs(vec[Q]), abs(vec[R]), abs(vec[S]));

function cube_add(vectorA, vectorB) = [vectorA[Q] + vectorB[Q], vectorA[R] + vectorB[R], vectorA[S] + vectorB[S]];

function cube_neighbor(vector, direction) = cube_add(vector, cube_direction_vectors[direction]);

// The side length of the hexagon is equal to the radius of the circumscribed circle.
function diameter_to_scale_factor(diameter) = diameter * sqrt(3)/3;

function orientation_matrix_from_label(orientationLabel=POINTY) = orientationLabel == POINTY ? orientation_layout_pointy : orientationLabel == FLAT ? orientation_layout_flat : undef;


function hex_to_translation(orientation = POINTY, point, diameter=1) =

assert(orientation, "You need to specify an orientation, either FLAT or POINTY")
assert(point, "point of form [s, q] is missing")
assert(diameter, "diameter missing")
let (orientationMatrix = orientation_matrix_from_label(orientation))
let (factor = diameter_to_scale_factor(diameter))
let (vector = cube_scale(point, factor))
    [
            orientationMatrix[f0] * vector[Q] + orientationMatrix[f1] * vector[R],
            orientationMatrix[f2] * vector[Q] + orientationMatrix[f3] * vector[R],
            0
    ];

function cube_scale(vectorA, factor) = [vectorA[Q] * factor, vectorA[R] * factor, -vectorA[Q] * factor - vectorA[R] * factor];

module hexagon_translations(N, diameter, orientation) {
    for (q = [-N:+N])
    for (r = [max(-N, -q - N): min(+N, -q + N)])
    let (point = [q, r, -q - r])
    translate(hex_to_translation(orientation, point, diameter))
        children(0);
}

module paralelogram_translations(width = 2, length = 2, diameter, orientation) {
    for (q = [0:width])
    for (r = [0:length])
    let (point = [q, r, -q - r])
    translate(hex_to_translation(orientation, point, diameter))
        children(0);

}


module triangle_translations(side = 3, diameter, orientation) {
    for (q = [0:side])
    for (r = [0:side - q])
    let (point = [q, r, -q - r])
    translate(hex_to_translation(orientation, point, diameter))
        children(0);

}

module rectangle_translations(left = -3, right = 3, top = -2, bottom = 2, diameter, orientation) {
    for (r = [top: bottom])
    let (r_offset = floor(r / 2.0))
    for (q = [left - r_offset:right - r_offset])
    let (point = [q, r, -q - r])
    translate(hex_to_translation(orientation, point, diameter))
        children(0);
}

module flat_top_rectangle_translations(left = -3, right = 3, top = -2, bottom = 2, diameter, orientation) {
    for (q = [left: right])
    let (q_offset = floor(q / 2.0))
    for (r = [top - q_offset:bottom - q_offset])
    let (point = [r, q, -q - r])
    translate(hex_to_translation(orientation, point, diameter))
        children(0);
}
