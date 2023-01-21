x = 2;
y = 2;
z = 4;
LOCK = "openlock";// [openlock,triplex,infinitylock,dragonlock,dragonlocktriplex,none]
CURVED_CONCAVE = "false"; // [true,false]
CURVED_LARGE = "b"; // [a,b,c]
CURVED_SQUARE = "false"; // [true,false]

include <impl_curved.scad>

/*
 * Top Level Function
 */
 
module riser_curved(x,y,square_basis) {
    tmp_edge_width = MAGNET_HOLE >= 5.55 ? MAGNET_HOLE + 1 : 6.55;
    edge_width = (PRIORITY == "lock" && (x == 1 || y == 1)) || LOCK == "triplex" || LOCK == "openlock" && MAGNETS == "none" || LOCK == "openlock_topless" && MAGNETS == "none" ? tmp_edge_width : square_basis/2;

    difference() {
        intersection() {
            cube([x*square_basis_number, y*square_basis_number, z/2*square_basis_number]);
            translate([0,0,-1]) scale([x,y,1]) cylinder(200,square_basis,square_basis,$fn=200);
        }
        if(LOCK != "none") {
            for ( i = [1 : z] ) {
                translate([0,0,(i-1)/2*square_basis_number]) connector_negative_curved(x,y,square_basis,edge_width);
            }
        } else {
            translate([-1,-1,-1]) cube([x*square_basis_number+2, y*square_basis_number+2, 7]);
        }
    }
}

module base_curved(x,y,square_basis) {
    difference() {
        intersection() {
            plain_square_positive(x,y,square_basis);
            hull() {
                translate([0,0,0.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([(x-.25/square_basis),(y-0.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        
        intersection() {
            plain_square_negative(x,y,square_basis,edge_width);
            translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
        }
    }




    difference() {
        union() {
            plain_base_curved(x,y,square_basis,edge_width);
            connector_positive_curved(x,y,square_basis,edge_width) ;
        }
        connector_negative_curved(x,y,square_basis,edge_width) ;
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

riser_curved(x,y,square_basis_number);