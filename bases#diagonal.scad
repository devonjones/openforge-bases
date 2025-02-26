/* [Base Tile Size] */
x = 2; //[1,2,3,4,5,6,7,8]
y = 2; //[1,2,3,4,5,6,7,8]

/* [diagonal Basis] */
// What is the size in mm of a diagonal?
DIAGONAL_BASIS = "inch"; // [25mm:Dwarven Forge/Hirstarts, inch:OpenLOCK/Dragonlock/Dungeonworks, wyloch:Wyloch]

/* [Lock] */
// Dragonlock - connector between diagonals, pips on either side for stacking
// InfinityLock - connector between diagonals and in the middle of diagonals
// OpenLOCK - connector between diagonals
// OpenLOCK Triplex - connector between diagonals and in the middle of diagonals
// OpenLOCK Topless - openlock, but without a top
LOCK = "openlock";// [openlock,triplex,infinitylock,dragonlock,none]

// If Openlock, do we want supports?
SUPPORTS = "true"; // [true, false]

/* [Topless] */
// remove top of openlock bays
TOPLESS = "true"; // [true, false]

 /* [Magnets] */
// Use magnets or not.
MAGNETS = "flex_magnetic"; // [magnetic,flex_magnetic,none]
// Size of hole for magnet.  6 works well for 5mm buckyball style magnets.
MAGNET_HOLE = 6;

/* [Electronics] */
// Should this have enough space for electronics.
ELECTRONICS = "false";

/* [Priority] */
// Do you want lock or magnets to win when the two conflict
PRIORITY = "lock"; // [lock,magnets]

/* [Notch Options] */
// Removes a diagonal from the tile of notch_x by notch_y
NOTCH = "false"; // [true,false]
NOTCH_X = 2; // [1,2,3]
NOTCH_Y = 2; // [1,2,3]

CENTER = "false"; // [true, false]

HEIGHT = 6; // 6 is default

include <impl_diagonal.scad>

/*
 * Top Level Function
 */
module base_diagonal(x,y,diagonal_basis) {
    tmp_edge_width = MAGNET_HOLE >= 5.55 ? MAGNET_HOLE + 1 : 6.55;
    electronics = (x <= 2 || y <= 2) && ELECTRONICS == "true";
    edge_width = ((PRIORITY == "lock" && (x == 1 || y == 1)) || LOCK == "triplex" || LOCK == "openlock" && MAGNETS == "none" || LOCK == "openlock_topless" && MAGNETS == "none") || electronics ? tmp_edge_width : diagonal_basis/2 ;
    echo("edge_width: ", edge_width)

    difference() {
        union() {
            plain_diagonal(x,y,diagonal_basis,LOCK,edge_width);
        }
        connector_negative_diagonal_notch(x,y,diagonal_basis,edge_width) ;
    }
}

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];


basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75]
];
diagonal_basis_number = basis[keyLookup(basis, [DIAGONAL_BASIS])][1];
wall_width = 10.2*diagonal_basis_number/25;
echo("diagonal_basis_number: ", diagonal_basis_number);
echo("wall_width: ", wall_width);

// Compatability
valid_dragonlock_basis = (DIAGONAL_BASIS == "inch");
valid_infinitylock_basis = (DIAGONAL_BASIS == "inch");

if (LOCK == "dragonlock" && !valid_dragonlock_basis) {
    echo("ERROR: dragonlock is only compatible with inch basis");
} else if (LOCK == "infinitylock" && !valid_infinitylock_basis) {
    echo("ERROR: infinitylock is only compatible with inch basis");
} else {
    color("Grey") base_diagonal(x,y,diagonal_basis_number);
}

//plain_base(x,y,diagonal_basis_number,shape,7);