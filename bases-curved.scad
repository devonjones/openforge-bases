/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6,7,8]
y = 2; //[1,2,3,4,5,6,7,8]

/* [Square Basis] */
// What is the size in mm of a square?
SQUARE_BASIS = "inch"; // [25mm:Dwarven Forge/Hirstarts, inch:OpenLOCK/Dragonlock/Dungeonworks, wyloch:Wyloch, drc:Dragon's Rest]

/* [Lock] */
// Dragonlock - connector between squares, pips on either side for stacking
// InfinityLock - connector between squares and in the middle of squares
// OpenLOCK - connector between squares
// OpenLOCK Triplex - connector between squares and in the middle of squares
// OpenLOCK Topless - openlock, but without a top
LOCK = "openlock";// [openlock,triplex,infinitylock,dragonlock,none]

// If Openlock, do we want supports?
SUPPORTS = "true"; // [true, false]

/* [Topless] */
// remove top of openlock bays
TOPLESS = "true"; // [true, false]

/* [Magnets] */
// Use magnets or not.
MAGNETS = "flex_magnetic"; // [magnetic, flex_magnetic]
// Size of hole for magnet.  6 works well for 5mm buckyball style magnets.  0 to eliminate.
MAGNET_HOLE = 6;

/* [Priority] */
// Do you want lock or magnets to win when the two conflict
PRIORITY = "lock"; // [lock,magnets]

/* [Curved Options] */
// Options for curved, will be ignored if the tile type is not curved
// curvedlarge - 6x6 and 8x8 are made of 3 tiles, a, b & c
CURVED_LARGE = "b"; // [a,b,c]

/* [Notch Options] */
// Removes a square from the tile of notch_x by notch_y
NOTCH = "false"; // [true,false]
NOTCH_X = 2; // [1,2,3]
NOTCH_Y = 2; // [1,2,3]

CENTER = "false"; // [true, false]

HEIGHT = 6; // 6 is default

include <impl_curved.scad>

/*
 * Top Level Function
 */
module base_curved(x,y,square_basis) {
    tmp_edge_width = MAGNET_HOLE >= 5.55 ? MAGNET_HOLE + 1 : 6.55;
    edge_width = LOCK == "triplex" ? tmp_edge_width : square_basis/2 ;

    difference() {
        union() {
            plain_base_curved(x,y,square_basis,edge_width);
            connector_positive_curved(x,y,square_basis,edge_width) ;
        }
        connector_negative_curved(x,y,square_basis,edge_width) ;
    }
}

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];


basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75],
    ["drc", 38.1]
];
square_basis_number = basis[keyLookup(basis, [SQUARE_BASIS])][1];
wall_width = 12.7*square_basis_number/25;

// Compatability
valid_dragonlock_basis = (SQUARE_BASIS == "inch");
valid_infinitylock_basis = (SQUARE_BASIS == "inch");

if (LOCK == "dragonlock" && !valid_dragonlock_basis) {
    echo("ERROR: dragonlock is only compatible with inch basis");
} else if (LOCK == "infinitylock" && !valid_infinitylock_basis) {
    echo("ERROR: infinitylock is only compatible with inch basis");
} else {
    color("Grey") base_curved(x,y,square_basis_number);
}
