include <hexpack/hexpack-constants.scad>;
use <hexpack/hexpack.scad>;

$fn = 6;
part_diam = 10;
spacing = 0;

hexpack_hexagon_grid(N = 2, diameter = part_diam + spacing){
    cylinder(d = part_diam+1, h = 2, center = false, $fn=6);
}

translate([200, 0, 0])
union(){
color("red")
hexpack_parallelogram_gird(axis_shift=2, width = -2, length = 2, diameter = part_diam + spacing, orientation = FLAT, origin=[4,-1,-3]){
        cylinder(d = part_diam, h = 2, center = false);
    }

color("blue")
hexpack_parallelogram_gird(axis_shift=0, width = 2, length = 2, diameter = part_diam + spacing, orientation = FLAT, origin=[1, 1, -2]){
        cylinder(d = part_diam, h = 2, center = false);
    }
color("green")
hexpack_parallelogram_gird(axis_shift=1, width = 2, length = 2, diameter = part_diam + spacing, orientation = FLAT, origin=[1, -2, 1]){
        cylinder(d = part_diam, h = 2, center = false);
    }
    
color("magenta")
hexpack_parallelogram_gird(axis_shift=2, width = 2, length = 2, diameter = part_diam + spacing, orientation = FLAT, origin=[-2, 1, 1]){
        cylinder(d = part_diam, h = 2, center = false);
    }
color("cyan")    
hexpack_parallelogram_gird(axis_shift=0, width = -2, length = 2, diameter = part_diam + spacing, orientation = FLAT, origin=[-1,-3, 4]){
        cylinder(d = part_diam, h = 2, center = false);
    }
color("yellow")
hexpack_parallelogram_gird(axis_shift=1, width = -2, length = 2, diameter = part_diam + spacing, orientation = FLAT, origin=[-3, 4,-1]){
        cylinder(d = part_diam, h = 2, center = false);
    }
}
translate([100, 100, 0])
union(){
color("red")
hexpack_parallelogram_gird(axis_shift=2, width = -2, length = 2, diameter = part_diam + spacing, orientation = POINTY, origin=[4,-1,-3]){
        cylinder(d = part_diam, h = 2, center = false);
    }

color("blue")
hexpack_parallelogram_gird(axis_shift=0, width = 2, length = 2, diameter = part_diam + spacing, orientation = POINTY, origin=[1, 1, -2]){
        cylinder(d = part_diam, h = 2, center = false);
    }
color("green")
hexpack_parallelogram_gird(axis_shift=1, width = 2, length = 2, diameter = part_diam + spacing, orientation = POINTY, origin=[1, -2, 1]){
        cylinder(d = part_diam, h = 2, center = false);
    }
    
color("magenta")
hexpack_parallelogram_gird(axis_shift=2, width = 2, length = 2, diameter = part_diam + spacing, orientation = POINTY, origin=[-2, 1, 1]){
        cylinder(d = part_diam, h = 2, center = false);
    }
color("cyan")    
hexpack_parallelogram_gird(axis_shift=0, width = -2, length = 2, diameter = part_diam + spacing, orientation = POINTY, origin=[-1,-3, 4]){
        cylinder(d = part_diam, h = 2, center = false);
    }
color("yellow")
hexpack_parallelogram_gird(axis_shift=1, width = -2, length = 2, diameter = part_diam + spacing, orientation = POINTY, origin=[-3, 4,-1]){
        cylinder(d = part_diam, h = 2, center = false);
    }
}

translate([70, 0, 0])
    hexpack_triangle_grid(side = 5, diameter = part_diam + spacing, orientation = FLAT, axis_shift=2){
        cylinder(d = part_diam, h = 2, center = false);
    }

translate([-100, 0, 0])
    hexpack_rectangle_grid(left = -2, right = 2, top = -2, bottom = 2, diameter = part_diam + spacing, axis_shift=1, orientation = FLAT){
        cylinder(d = part_diam, h = 2, center = false);
    };

translate([-240, 0, 0]) {
    difference() {
        cube([60, 60, 2], center = true);
        translate(hexpack_compute_translation_vector(diameter = part_diam, point = cube_neighbor([0, 0, 0], 0)))
            color("red")
                cylinder(d = part_diam, h = 2, center = false);

        translate(hexpack_compute_translation_vector(diameter = part_diam, point = cube_neighbor([0, 0, 0], 1)))
            color("blue")
                cylinder(d = part_diam, h = 2, center = false);

        translate(hexpack_compute_translation_vector(diameter = part_diam, point = cube_neighbor([0, 0, 0], 2)))
            color("green")
                cylinder(d = part_diam, h = 2, center = false);
        translate(hexpack_compute_translation_vector(diameter = part_diam, point = cube_neighbor([0, 0, 0], 3)))
            color("magenta")
                cylinder(d = part_diam, h = 2, center = false);
        translate(hexpack_compute_translation_vector(diameter = part_diam, point = cube_neighbor([0, 0, 0], 4)))
            color("cyan")
                cylinder(d = part_diam, h = 2, center = false);
        translate(hexpack_compute_translation_vector(diameter = part_diam, point = cube_neighbor([0, 0, 0], 5)))
            color("yellow")
                cylinder(d = part_diam, h = 2, center = false);
    }
}