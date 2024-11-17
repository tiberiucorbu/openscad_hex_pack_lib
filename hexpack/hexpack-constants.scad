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
SQRT3=sqrt(3.0);
SQRT3_HALF=SQRT3/2;
SQRT3_THIRD=SQRT3/3;

orientation_layout_pointy
= [SQRT3, SQRT3_HALF, 0.0, 3.0 / 2.0, SQRT3_THIRD, -1.0 / 3.0, 0.0, 2.0 / 3.0, 0.5];

orientation_layout_flat
= [3.0 / 2.0, 0.0, sqrt(3.0) / 2.0, sqrt(3.0), 2.0 / 3.0, 0.0, -1.0 / 3.0, SQRT3_THIRD, 0.0];

FLAT = "FLAT";
POINTY = "POINTY";

cube_direction_vectors = [
        [+1, 0, -1], [+1, -1, 0], [0, -1, +1],
        [-1, 0, +1], [-1, +1, 0], [0, +1, -1]
    ];
