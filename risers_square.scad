include <impl_square.scad>

x = 2;
y = 2;
z = 4;

LOCK = "openlock";// [openlock,triplex,infinitylock,dragonlock,dragonlocktriplex,none]

module riser_square(x,y,square_basis) {
    tmp_edge_width = MAGNET_HOLE >= 5.55 ? MAGNET_HOLE + 1 : 6.55;
    edge_width = (PRIORITY == "lock" && (x == 1 || y == 1)) || LOCK == "triplex" || LOCK == "openlock" && MAGNETS == "none" || LOCK == "openlock_topless" && MAGNETS == "none" ? tmp_edge_width : square_basis/2;

    difference() {
        cube([x*square_basis_number, y*square_basis_number, z/2*square_basis_number]);
        if(LOCK != "none") {
            for ( i = [1 : z] ) {
                translate([0,0,(i-1)/2*square_basis_number]) connector_negative_square_notch(x,y,square_basis,edge_width);
            }
        } else {
            translate([-1,-1,-1]) cube([x*square_basis_number+2, y*square_basis_number+2, 7]);
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

riser_square(x,y,square_basis_number);