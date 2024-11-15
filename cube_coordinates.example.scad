include <cube_coordinates/cube_coordinates.scad>;

$fn = 100;
part_diam = 10;
spacing = 1;

hexagon_translations(N = 2, diameter = part_diam + spacing, orientation = FLAT){
    cylinder(d = part_diam, h = 2, center = false); // can be any shape
}

translate([-70, 0, 0])
    paralelogram_translations(width = 2, length = 2, diameter = part_diam + spacing, orientation = FLAT){
        cylinder(d = part_diam, h = 2, center = false); // can be any shap
    }

translate([70, 0, 0])
    triangle_translations(side = 3, diameter = part_diam + spacing, orientation = POINTY){
        cylinder(d = part_diam, h = 2, center = false); // can be any shape
    }

translate([140, 0, 0])
    rectangle_translations(left = -2, right = 2, top = -2, bottom = 2, diameter = part_diam + spacing, orientation = POINTY){
        cylinder(d = part_diam, h = 2, center = false); // can be any shape
    };

translate([-140, 0, 0])
    rectangle_translations(left = -2, right = 2, top = -2, bottom = 2, diameter = part_diam + spacing, orientation = FLAT){
        cylinder(d = part_diam, h = 2, center = false); // can be any shape
    };

translate([-240, 0, 0]) {
    difference() {
        cube([200, 200, 2], center = true);
        translate(hex_to_translation(diameter = part_diam, point = cube_neighbor([0, 0], 0)))
            color("purple")
                cylinder(d = part_diam, h = 2, center = false);

        translate(hex_to_translation(diameter = part_diam, point = cube_neighbor([0, 0, 0], 1)))
            color("purple")
                cylinder(d = part_diam, h = 2, center = false);

        translate(hex_to_translation(diameter = part_diam, point = cube_neighbor([0, 0, 0], 2)))
            color("purple")
                cylinder(d = part_diam, h = 2, center = false);
        translate(hex_to_translation(diameter = part_diam, point = cube_neighbor([0, 0, 0], 3)))
            color("purple")
                cylinder(d = part_diam, h = 2, center = false);
        translate(hex_to_translation(diameter = part_diam, point = cube_neighbor([0, 0, 0], 4)))
            color("purple")
                cylinder(d = part_diam, h = 2, center = false);
        translate(hex_to_translation(diameter = part_diam, point = cube_neighbor([0, 0, 0], 5)))
            color("purple")
                cylinder(d = part_diam, h = 2, center = false);
    }
}