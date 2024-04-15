include <impl_wall.scad>

x = 2;
z = 2;
half = false;

LOCK = "openlock";// [openlock,triplex,infinitylock,dragonlock,dragonlocktriplex,none]

module riser_wall(x,half,square_basis) {
    tmp_edge_width = MAGNET_HOLE >= 5.55 ? MAGNET_HOLE + 1 : 6.55;
    edge_width = (PRIORITY == "lock" && (x == 1)) || LOCK == "triplex" || LOCK == "openlock" && MAGNETS == "none" || LOCK == "openlock_topless" && MAGNETS == "none" ? tmp_edge_width : square_basis/2;
    h = half ? 0.5 : 0;

    difference() {
        translate([0,-0.25*square_basis_number,0]) cube([(x+h)*square_basis_number, 0.5*square_basis_number, z/2*square_basis_number]);
        for ( i = [1 : z] ) {
            translate([0,0,(i-1)/2*square_basis_number]) connector_wall_negative(x,half,square_basis,edge_width);
        }
        if (z > 4) {
            translate([0,0,height_basis[keyLookup(height_basis, ["high"])][1]]) openlock_sidelock_negative();
            translate([(x+h)*square_basis,0,height_basis[keyLookup(height_basis, ["high"])][1]]) rotate([0,0,180])  openlock_sidelock_negative();
        }
        if (z > 3) {
            translate([0,0,height_basis[keyLookup(height_basis, ["medium"])][1]]) openlock_sidelock_negative();
            translate([(x+h)*square_basis,0,height_basis[keyLookup(height_basis, ["medium"])][1]]) rotate([0,0,180])  openlock_sidelock_negative();
        }
        if (z > 1) {
            translate([0,0,height_basis[keyLookup(height_basis, ["low"])][1]]) openlock_sidelock_negative();
            translate([(x+h)*square_basis,0,height_basis[keyLookup(height_basis, ["low"])][1]]) rotate([0,0,180])  openlock_sidelock_negative();
        }
    }
}

SQUARE_BASIS = "inch";
MAGNETS = "none";
MAGNET_HOLE = 0;
TOPLESS = "false";
PRIORITY = "lock";
NOTCH = "false";

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];
basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75]
];
square_basis_number = basis[keyLookup(basis, [SQUARE_BASIS])][1];
wall_width = 10.2*square_basis_number/25;

height_basis = [
    ["low", 8.9],
    ["medium", 27.9],
    ["high", 46.9]
];

riser_wall(x,half,square_basis_number);
