/* [Base Tile Size] */
x = 4; //[1,2,3,4,5,6,7,8]
y = 4; //[1,2,3,4,5,6,7,8]

/* [Square Basis] */
// What is the size in mm of a square?
square_basis = "inch"; // [25mm:Dwarven Forge/Hirstarts, inch:OpenLOCK/Dragonlock/Dungeonworks, wyloch:Wyloch]

/* [Lock] */
// Dragonlock - connector between squares, pips on either side for stacking
// InfinityLock - connector between squares and in the middle of squares
// OpenLOCK - connector between squares
// OpenLOCK Triplex - connector between squares and in the middle of squares
lock = "openlock";// [openlock,triplex,infinitylock,dragonlock,none]

/* [Magnets] */
// Size of hole for magnet.  6 works well for 5mm buckyball style magnets.  0 to eliminate.
magnet_hole = 6;

/* [Priority] */
// Do you want lock or magnets to win when the two conflict
priority = "magnets"; // [lock,magnets]

/* [Shape] */
// What type of tile is this for
shape = "square"; // [square,diagonal,curved,alcove]

/* [Curved Options] */
// Options for curved, will be ignored if the tile type is not curved
// curvedconcave - concaved base instead of convex
// curvedlarge - 6x6 and 8x8 are made of 3 tiles, a, b & c
// curvedsquare - When you want a curved wall, with floors on both sides, but a square won't work
curvedconcave = "false"; // [true,false]
curvedlarge = "b"; // [a,b,c]
curvedsquare = "false"; // [true,false]

/* [Notch Options] */
// Removes a square from the tile of notch_x by notch_y
notch = "true"; // [true,false]
notch_x = 2; // [1,2,3]
notch_y = 2; // [1,2,3]

/* [Dynamic Floors] */
// Add support for dynamic floors
dynamic_floors = "false";  // [true,false]

/*
 * Dragonlock connection bay
 */
module dragonlock_nub() {
    hull() {
        translate([3.92,16.62,-1]) cube([4.85,4.85,1]);
        translate([3.92+.74,16.62+.74,0]) cube([4.85-.74*2,4.85-.74*2,1.03]);
    }
    translate([3.92+.74,16.62+.74,1]) cube([4.85-.74*2,4.85-.74*2,4.21]);
}

module dragonlock_interior_a(north=true,south=true,east=true,west=true) {
    module edge() {
        difference() {
            hull() {
                translate([3.17,-12.67,-1]) cube([8.512,12.67*2,6]);
                translate([3.145,-12.7,-1]) cube([8.512,12.67*2,6.206]);
            }
            translate([10.29,-12.8,5.206]) rotate([0,45,0]) cube([8.512,12.8*2,6.206]);
        }
    }
    
    translate([0,25.4,0]) {
        difference() {
            translate([12.7,-12.7,-1]) cube([50.8-12.7*2,50.8-12.7*2,6.206]);
            translate([25.4,0,0]) rotate([0,0,45]) translate([-.75,-30,-2]) cube([1.5,60,20]);
            translate([25.4,0,0]) rotate([0,0,-45]) translate([-.75,-30,-2]) cube([1.5,60,20]);
        }

        if (!west) {
            edge();
        }
        if (!south) {
            translate([25.4,-25.4,0]) rotate([0,0,90]) edge();
        }
        if (!east) {
            translate([50.8,0,0]) rotate([0,0,180]) edge();
        }
        if (!north) {
            translate([25.4,25.4,0]) rotate([0,0,270]) edge();
        }
        dragonlock_nub();
        translate([25.4,-25.4,0]) rotate([0,0,90]) dragonlock_nub();
        translate([50.8,0,0]) rotate([0,0,180]) dragonlock_nub();
        translate([25.4,25.4,0]) rotate([0,0,270]) dragonlock_nub();
    }
}

module dragonlock_interior_b(north=true,south=true,east=true,west=true) {
    translate([0,25.4,0]) {
        if (west) {
            dragonlock_negative();
        }
        if (south) {
            translate([25.4,-25.4,0]) rotate([0,0,90]) dragonlock_negative();
        }
        if (east) {
            translate([50.8,0,0]) rotate([0,0,180]) dragonlock_negative();
        }
        if (north) {
            translate([25.4,25.4,0]) rotate([0,0,270]) dragonlock_negative();
        }
    }
}


module dragonlock_positive() {
    translate([0,-7.8418,0.4]) cube([2,7.8418*2,5.6]);
    //translate([3.92-1,16.62-1,0.4]) cube([6.85,6.85,5.6]);
    //translate([3.92-1,-16.62-1-4.85,0.4]) cube([6.85,6.85,5.6]);
}

module dragonlock_negative(supports=true) {
    difference() {
        translate([-1,-6.8418,1.3695]) cube([5.1,6.8418*2,3.225]);
        if(supports) {
            translate([-1.1,-.32,0]) cube([4.262,.627,5]);
        }
    }
    difference() {
        hull() {
            translate([3.17,-12.67,-1]) cube([8.512,12.67*2,6]);
            translate([3.145,-12.7,-1]) cube([8.512,12.67*2,6.206]);
        }
        translate([10.29,-12.8,5.206]) rotate([0,45,0]) cube([8.512,12.8*2,6.206]);
        translate([3,-3.9095,-1.1]) cube([10,3.9095*2,2.4695]);
        translate([3,-4.7685,-1.1]) rotate([0,0,39.15]) cube([5,5,2.4695]);
        mirror([0,1,0]) translate([3,-4.7685,-1.1]) rotate([0,0,39.15]) cube([5,5,2.4695]);
        translate([7,-2.12,-1]) cube([5,2.12*2,10]);
        translate([8.069,0,-1]) cylinder(10,2.815,2.811,$fn=50); 
        translate([8.069,0,-1.1]) cylinder(2.4695,4.62,4.62,$fn=50);
        translate([11.69,3.9,-1.1]) rotate([0,0,180-12]) cube([2.1,1,1.1]);
        translate([11.69,-3.9,-1.1]) rotate([0,0,90+12]) cube([1,2.1,1.1]);
    }
}

/*
 * Infinity Lock connection bay
 */
module infinitylock_positive() {
    translate([0,-6.6,0.4]) cube([2,6.6*2,5.6]); 
}

module infinitylock_negative() {
    translate([-1,-5.6,1.4]) cube([2.6,5.6*2,4.2]);

    hull() {
        translate([0,-3.83,1.4]) cube([1.6,3.83*2,4.2]);
        translate([0,-3.36,1.4]) cube([2.15,3.36*2,4.2]);
    }
    translate([0,-3.36,1.4]) cube([2.8,3.36*2,4.2]);
    hull() {
        translate([2.7,-3.36,1.4]) cube([2.7,3.36*2,4.2]);
        translate([3.84,-3.83,1.4]) cube([1,3.83*2,4.2]);
    }
    translate([4.8,-3.83,-1]) cube([3.44,3.83*2,6.6]);
}

/*
 * Openlock connection bay
 */
module openlock_chamber(buffer=0) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.2]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.2]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,4.2]);
    }
    hull() {
        translate([5,-5,1.4]) cube([1,5*2,4.2]);
        translate([6,-5,1.4]) cube([1,5*2,4.7]);
    }
    translate([6,-6.4,-1]) cube([4.7,6.4*2,7.1]);
}

module openlock_supports() {
    module support() {
        translate([-1.1,2.05,1.2]) cube([3.1,1,4.6]);
        hull() {
            translate([-1.1,2.05,1.4]) cube([3.1,1,2.1]);
            translate([-1.1,2.05-.2,1.9]) cube([3.1,1.4,1.1]);
        }
        hull() {
            translate([-1.1,2.05,3.5]) cube([3.1,1,2.1]);
            translate([-1.1,2.05-.2,4.0]) cube([3.1,1.4,1.1]);
        }
    }
    support();
    mirror([0,1,0]) support();
}

module openlock_positive() {
    translate([0,-8,0.4]) cube([2,16,5.6]); 
}

module openlock_negative(supports=true) {
    difference() {
        openlock_chamber(1);
        if(supports) {
            openlock_supports();
        }
    }
}

/*
 * Magnets
 */
module magnet_positive(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,0]) cylinder(.41,magnet_hole/2+1-.25,magnet_hole/2+1, $fn=100);
        translate([magnet_hole/2+1,0,0.4]) cylinder(5.6,magnet_hole/2+1,magnet_hole/2+1, $fn=100);
    }
}

module magnet_negative(magnet_hole=5.5) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
        translate([magnet_hole/2+1,0,-1]) cylinder(10,.9,.9,$fn=50);
    }
}

/*
 * Connector Layout
 */
module center_connector_positive(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_positive();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_positive();
        } else {
            magnet_positive(magnet_hole);
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_positive();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_positive();
        } else {
            magnet_positive(magnet_hole);
        }
    }
}

module center_connector_negative(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_negative();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_negative();
        } else {
            magnet_negative(magnet_hole);
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_negative();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_negative();
        } else {
            magnet_negative(magnet_hole);
        }
    }
}

module joint_connector_positive(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if(lock == "openlock" || lock == "triplex") {
        openlock_positive();
    } else if (lock == "infinitylock") {
        infinitylock_positive();
    }
}

module joint_connector_negative(edge, ordinal, magnet_hole=5.5, lock, priority="lock") {
    if(lock == "openlock" || lock == "triplex") {
        openlock_negative();
    } else if (lock == "infinitylock") {
        infinitylock_negative();
    }
}

/*
 * Dynamic Floor Bases
 */
module df_positive_square(x,y,square_basis, edge_width) {
    cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([square_basis*x-square_basis/2-4.75,0,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([0,square_basis*y-square_basis/2-4.75,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([square_basis*x-square_basis/2-4.75,square_basis*y-square_basis/2-4.75,0]) cube([square_basis/2+4.75,square_basis/2+4.75,6]);
    translate([square_basis/2+3.75,square_basis/2+3.75,0]) cube([square_basis*x-(square_basis/2+3.75)*2,square_basis*y-(square_basis/2+3.75)*2,6]);
    if (x > 2) {
        for ( i = [2 : x-1] ) {
            translate([(i-.5)*square_basis-9.5/2,0,0]) cube([9.5,square_basis/2+4.75,6]);
            translate([(i-.5)*square_basis-9.5/2,square_basis*y-square_basis/2-4.75,0]) cube([9.5,square_basis/2+4.75,6]);
        }
    }
    if (y > 2) {
        for ( i = [2 : y-1] ) {
            translate([0,(i-.5)*square_basis-9.5/2,0]) cube([square_basis/2+4.75,9.5,6]);
            translate([square_basis*x-square_basis/2-4.75,(i-.5)*square_basis-9.5/2,0]) cube([square_basis/2+4.75,9.5,6]);
        }
    }
}

module df_positive(x,y,square_basis, shape, edge_width) {
    if(shape == "square") {
        df_positive_square(x,y,square_basis,edge_width);
    } else if (shape == "curved") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.a") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.b") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.c") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "diagonal") {
        echo("Diagonal does not support Dynamic Floors");
    }
}

module df_negative_square(x,y,square_basis,edge_width) {
    for ( i = [0 : x-1] ) {
        for ( j = [0 : y-1] ) {
            translate([i*square_basis, j*square_basis,0]) translate([square_basis/2,square_basis/2,6-2.1]) cylinder(2.5,5.5/2,5.5/2, $fn=100);
        }
    }
}

module df_negative(x,y,square_basis, shape, edge_width) {
    if(shape == "square") {
        df_negative_square(x,y,square_basis,edge_width);
    } else if (shape == "curved") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.a") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.b") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "curvedlarge.c") {
        echo("Curved does not support Dynamic Floors");
    } else if (shape == "diagonal") {
        echo("Diagonal does not support Dynamic Floors");
    }
}

/*
 * Connector Positive
 */
module connector_positive(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    if(shape == "square") {
        connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority);
    } else if (shape == "curved") {
        if(x == 6 && y == 6) {
            connector_positive_curved_large_6(square_basis,edge_width);
        } else if (x == 8 && y == 8) {
            connector_positive_curved_large_8(square_basis,edge_width);
        } else if (x > 4 || y > 4) {
            echo("Curved does not support ", x, "x", y);
        } else {
            connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        }
    } else if (shape == "diagonal") {
        connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if (shape == "alcove") {
        connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,west=false,east=false,north=false);
    }
}

module connector_positive_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    if(notch == "true") {
        connector_positive_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=north,south=false,east=east,west=false);
        if(south) {
            translate([square_basis*notch_x,0,0]) connector_positive_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
            translate([0,square_basis*notch_y,0]) connector_positive_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
        }
        if(west) {
            translate([square_basis*notch_x,0,0]) connector_positive_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
            translate([0,square_basis*notch_y,0]) connector_positive_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
        }
    } else {
        connector_positive_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north,south,east,west);
    }
}

module connector_positive_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    for ( i = [0 : y-1] ) {
        if(west) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_positive(y,i,magnet_hole,lock,priority);
        }
        if(east) {
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,i,magnet_hole,lock,priority);
        }
    }
    if (y > 1) {
        for ( i = [1 : y-1] ) {
            if(west) {
                translate([0,square_basis*i,0]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
            if(east) {
                translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
        }
    }
    for ( i = [0 : x-1] ) {
        if(south) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_positive(x,i,magnet_hole,lock,priority);
        }
        if(north) {
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_positive(x,i,magnet_hole,lock,priority);
        }
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            if(south) {
                translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
            if(north) {
                translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_positive(y,i,magnet_hole,lock,priority);
            }
        }
    }
}

module connector_positive_curved_large_6(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_positive_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        translate([square_basis*6/2, square_basis*6/2,0]) connector_positive_square(6/2-1,6/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_positive_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module connector_positive_curved_large_8(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_positive_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        translate([square_basis*8/2, square_basis*8/2,0]) connector_positive_square(8/2-1,8/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_positive_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 8x8 only supports a, b & c");
    }
}

module connector_positive_large_6_a(square_basis,edge_width,magnet_hole,lock,priority) {
    translate([0,square_basis*5,0]) connector_positive_square(2,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    translate([square_basis*2,square_basis*3,0]) connector_positive_square(1,2,square_basis,edge_width,magnet_hole,lock,priority,north=false);
}

module connector_positive_large_8_a(square_basis,edge_width,magnet_hole,lock,priority) {
    translate([0,square_basis*6,0]) connector_positive_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    translate([0,square_basis*6,0]) translate([square_basis*4,square_basis*(1)-square_basis/2,0]) rotate([0,0,180]) center_connector_positive(y,x,magnet_hole,lock,priority);
}

/*
 * Connector Negative
 */
module connector_negative(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) {
    if(shape == "square") {
        connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority);
        
    } else if (shape == "curved") {
        if(x == 6 && y == 6) {
            connector_negative_curved_large_6(square_basis,edge_width);
        } else if (x == 8 && y == 8) {
            connector_negative_curved_large_8(square_basis,edge_width);
        } else if (x > 4 || y > 4) {
            echo("Curved does not support ", x, "x", y);
        } else {
            connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
        }
    } else if (shape == "diagonal") {
        connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if (shape == "alcove") {
        connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,west=false,east=false,north=false);
    }
}

module connector_negative_square(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    if(notch == "true") {
        connector_negative_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=north,south=false,east=east,west=false);
        if(south) {
            translate([square_basis*notch_x,0,0]) connector_negative_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
            translate([0,square_basis*notch_y,0]) connector_negative_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=true,east=false,west=false);
        }
        if(west) {
            translate([square_basis*notch_x,0,0]) connector_negative_square_impl(notch_x,notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
            translate([0,square_basis*notch_y,0]) connector_negative_square_impl(x-notch_x,y-notch_y,square_basis,edge_width,magnet_hole,lock,priority,north=false,south=false,east=false,west=true);
        }
    } else {
        connector_negative_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north,south,east,west);
    }
}

module connector_negative_square_impl(x,y,square_basis,edge_width,magnet_hole,lock,priority,north=true,south=true,east=true,west=true) {
    for ( i = [0 : y-1] ) {
        if(west) {
            translate([0,square_basis*(i+1)-square_basis/2,0]) center_connector_negative(y,i,magnet_hole,lock,priority);
        }
        if(east) {
            translate([square_basis*x,square_basis*(i+1)-square_basis/2,0]) rotate([0,0,180]) center_connector_negative(y,i,magnet_hole,lock,priority);
        }
    }
    if (y > 1) {
        for ( i = [1 : y-1] ) {
            if(west) {
                translate([0,square_basis*i,0]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
            if(east) {
                translate([square_basis*x,square_basis*i,0]) rotate([0,0,180]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
        }
    }
    for ( i = [0 : x-1] ) {
        if(south) {
            translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_negative(x,i,magnet_hole,lock,priority);
        }
        if(north) {
            translate([square_basis*(i+1)-square_basis/2,square_basis*y,0]) rotate([0,0,-90]) center_connector_negative(x,i,magnet_hole,lock,priority);
        }
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            if(south) {
                translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
            if(north) {
                translate([square_basis*i,square_basis*y,0]) rotate([0,0,-90]) joint_connector_negative(y,i,magnet_hole,lock,priority);
            }
        }
    }
}

module connector_negative_curved_large_6(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_negative_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        translate([square_basis*6/2, square_basis*6/2,0]) connector_negative_square(6/2-1,6/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_negative_large_6_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module connector_negative_curved_large_8(square_basis, edge_width) {
    if(curvedlarge == "a") {
        connector_negative_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
    } else if(curvedlarge == "b") {
        translate([square_basis*8/2, square_basis*8/2,0]) connector_negative_square(8/2-1,8/2-1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            connector_negative_large_8_a(square_basis,edge_width,magnet_hole,lock,priority);
        }
    } else {
        echo("Curved 8x8 only supports a, b & c");
    }
}

module connector_negative_large_6_a(square_basis,edge_width,magnet_hole,lock,priority) {
    translate([0,square_basis*5,0]) connector_negative_square(2,1,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    translate([square_basis*2,square_basis*3,0]) connector_negative_square(1,2,square_basis,edge_width,magnet_hole,lock,priority,north=false);
}

module connector_negative_large_8_a(square_basis,edge_width,magnet_hole,lock,priority) {
    translate([0,square_basis*6,0]) connector_negative_square(4,2,square_basis,edge_width,magnet_hole,lock,priority,east=false,north=false);
    translate([0,square_basis*6,0]) translate([square_basis*4,square_basis*(1)-square_basis/2,0]) rotate([0,0,180]) center_connector_negative(y,x,magnet_hole,lock,priority);
}

/*
 * Plain base exterior
 */
module plain_base(x,y,square_basis,lock,shape,edge_width) {
    if(shape == "square") {
        plain_square(x,y,square_basis,lock,edge_width);
    } else if (shape == "curved") {
        if(x == 6 && y == 6) {
            plain_curved_large_6(square_basis,edge_width);
        } else if (x == 8 && y == 8) {
            plain_curved_large_8(square_basis,edge_width);
        } else if (x > 4 || y > 4) {
            echo("Curved does not support ", x, "x", y);
        } else {
            if (curvedconcave == "true") {
                plain_curved_concave(x,y,square_basis,lock,edge_width);
            } else {
                plain_curved(x,y,square_basis,lock,edge_width);
            }
        }
    } else if (shape == "diagonal") {
        plain_diagonal(x,y,square_basis,lock,edge_width);
    } else if (shape == "alcove") {
        plain_alcove(x,y,square_basis,lock,edge_width);
    }
}

module plain_square(x,y,square_basis,lock,edge_width) {
    difference() {
        plain_square_positive(x,y,square_basis,edge_width);
        if(lock == "dragonlock") {
            dragonlock_square_negative_a(x,y);
            dragonlock_square_negative_b(x,y);
        } else {
            plain_square_negative(x,y,square_basis,edge_width);
        }
    }
}

module plain_square_positive(x,y,square_basis) {
    difference() {
        hull() {
            translate([0,0,0.4]) cube([square_basis*x, square_basis*y, 6-.39]);
            translate([0.25,0.25,0]) cube([square_basis*x-.5, square_basis*y-.5, 1]);
        }
        if(notch == "true") {
            translate([-1,-1,-1]) cube([square_basis*notch_x+1, square_basis*notch_y+1, 8]);
            hull() {
                translate([-1,-1,0]) cube([square_basis*notch_x+1, square_basis*notch_y+1, .4]);
                translate([-1,-1,-0.01]) cube([square_basis*notch_x+1.25, square_basis*notch_y+1.25, 0.01]);
            }
        }
    }
}

module plain_square_negative(x,y,square_basis,edge_width) {
    intersection() {
        translate([edge_width,edge_width,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2),square_basis*y-((edge_width+1)*2),8]);
        difference() {
            translate([edge_width,edge_width,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2),square_basis*y-((edge_width+1)*2),8]);
            translate([0,0,0.4]) cube([square_basis*notch_x+edge_width+1, square_basis*notch_y+edge_width+1, 6]);
            translate([0.25,.25,0]) cube([square_basis*notch_x+edge_width+1-.5, square_basis*notch_y+edge_width+1-.5, .4]);
        }
    }
}

module dragonlock_square_negative_a(x,y) {
    for(i = [2:2:x]) {
        for(j = [2:2:y]) {
            north = j == y;
            south = j == 2;
            west = i == 2;
            east = i == x;
            translate([25.4*(i-2),25.4*(j-2),0]) dragonlock_interior_a(north=north, south=south, west=west, east=east);
        }
    }
}

module dragonlock_square_negative_b(x,y,north=true,south=true,east=true,west=true) {
    for(i = [2:2:x]) {
        for(j = [2:2:y]) {
            northi = j == y;
            southi = j == 2;
            westi = i == 2;
            easti = i == x;
            translate([25.4*(i-2),25.4*(j-2),0]) dragonlock_interior_b(north=(north && northi), south=(south && southi), west=(west && westi), east=(east && easti));
        }
    }
}

module plain_curved(x,y,square_basis,lock,edge_width) {
    difference() {
        intersection() {
            plain_square_positive(x,y,square_basis);
            hull() {
                translate([0,0,0.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([(x-.25/square_basis),(y-0.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        
        if (lock == "dragonlock") {
            intersection() {
                dragonlock_square_negative_a(x,y);
                union() {
                    translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                    translate([0,square_basis*(y-1),0]) dragonlock_nub();
                    translate([50.8,25.4,0]) rotate([0,0,180]) dragonlock_nub();
                }
            }
            dragonlock_square_negative_b(x,y,north=false,south=true,east=false,west=true);
        } else {
            intersection() {
                plain_square_negative(x,y,square_basis,edge_width);
                translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
}

module plain_curved_concave(x,y,square_basis,lock,edge_width) {
    difference() {
        difference() {
            plain_square_positive(x,y,square_basis);
            hull() {
                translate([x*square_basis,y*square_basis,0.4]) scale([x-wall_width/square_basis,y-wall_width/square_basis,1]) cylinder(5.62,square_basis,square_basis,$fn=200);
                translate([x*square_basis,y*square_basis,-0.01]) scale([(x-.25/square_basis)-wall_width/square_basis,(y-0.25/square_basis)-wall_width/square_basis,1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        
        if (lock == "dragonlock") {
            difference() {
                union() {
                    dragonlock_square_negative_a(x,y);
                    dragonlock_square_negative_b(x,y,north=false,south=true,east=false,west=true);
                }
                difference() {
                    translate([x*square_basis,y*square_basis,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                    translate([0,square_basis*(y-1),0]) dragonlock_nub();
                    translate([square_basis*(x),25.4,0]) rotate([0,0,180]) dragonlock_nub();
                }
            }
        } else {
            difference() {
                plain_square_negative(x,y,square_basis,edge_width);
                translate([x*square_basis,y*square_basis,-1]) scale([x,y,1]) cylinder(8,square_basis,square_basis,$fn=200);
            }
        }
    }
}

module plain_curved_large_6(square_basis, edge_width) {
    if(curvedlarge == "a") {
        plain_curved_large_6_a(square_basis,edge_width);
    } else if(curvedlarge == "b") {
        plain_curved_large_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            plain_curved_large_6_a(square_basis,edge_width);
        }
    } else {
        echo("Curved 6x6 only supports a, b & c");
    }
}

module plain_curved_large_8(square_basis, edge_width) {
    if(curvedlarge == "a") {
        plain_curved_large_8_a(square_basis,edge_width);
    } else if(curvedlarge == "b") {
        plain_curved_large_b(x,y,square_basis,edge_width);
    } else if(curvedlarge == "c") {
        rotate([0,0,-90]) mirror([1,0,0]) {
            plain_curved_large_8_a(square_basis,edge_width);
        }
    } else {
        echo("Curved 8x8 only supports a, b & c");
    }
}

module plain_curved_large_6_a(square_basis,edge_width) {
    x = 6;
    y = 6;
    innerx = 3;
    innery = 3;

    difference() {
        union() {
            difference() {
                intersection() {
                    translate([0,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
                    hull() {
                        translate([0,0,0.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                        translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(0.4,square_basis,square_basis,$fn=200);
                    }
                }
                intersection() {
                    translate([0,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
                    translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
                }
            }
            hull() {
                translate([0,innery*square_basis,0.4]) cube([square_basis*(innerx-1)+edge_width+1, square_basis*(innery-1)+edge_width+1, 5.6]);
                translate([0.25,innery*square_basis+.25,0]) cube([square_basis*(innerx-1)+edge_width+1-.5, square_basis*(innery-1)+edge_width+1-.5, .4]);
            }
        }
        union() {
            translate([-1,innery*square_basis-1,-1]) cube([square_basis*(innerx-1)+1, square_basis*(innery-1)+1, 8]);
            hull() {
                translate([-1,innery*square_basis-1,0]) cube([square_basis*(innerx-1)+1, square_basis*(innery-1)+1, .4]);
                translate([-1,innery*square_basis-1,-0.01]) cube([square_basis*(innerx-1)+1.25, square_basis*(innery-1)+1.25, 0.01]);
            }
        }
    }
}

module plain_curved_large_8_a(square_basis,edge_width) {
    x = 8;
    y = 8;
    
    difference() {
        intersection() {
            hull() {
                translate([0,6*square_basis,0]) plain_square_positive(4,2,square_basis);
            }
            hull() {
                translate([0,0,.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        intersection() {
            translate([0,6*square_basis,0]) plain_square_negative(4,2,square_basis,edge_width);
            translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
        }
    }
}

module plain_curved_large_b(x,y,square_basis,edge_width) {
    innerx = x/2;
    innery = y/2;

    difference() {
        intersection() {
            translate([innerx*square_basis,innery*square_basis,0]) plain_square_positive(innerx,innery,square_basis);
            hull() {
                translate([0,0,.4]) scale([x,y,1]) cylinder(5.6,square_basis,square_basis,$fn=200);
                translate([0,0,0]) scale([x-(.25/square_basis),y-(.25/square_basis),1]) cylinder(.4,square_basis,square_basis,$fn=200);
            }
        }
        intersection() {
            translate([innerx*square_basis,innery*square_basis,0]) plain_square_negative(innerx,innery,square_basis,edge_width);
            translate([0,0,-1]) scale([((x*square_basis)-edge_width)/square_basis,((y*square_basis)-edge_width)/square_basis,1]) cylinder(8,square_basis,square_basis,$fn=200);
        }
    }
}

module plain_diagonal(x,y,square_basis,lock,edge_width) {
    hyp = sqrt(square_basis*x*square_basis*x+square_basis*y*square_basis*y);
    difference() {
        intersection() {
            plain_square_positive(x,y,square_basis);
            translate([x*square_basis,0,0]) rotate([0,0,atan(x/y)]) {
                translate([0,0,0.4]) cube([wall_width/2,hyp,5.6]);
                translate([0.25,0.25,0]) cube([wall_width/2-.5,hyp-.5,.4]);
                mirror([1,0,0]) cube([hyp,hyp,6]);
            }
        }
        if (lock == "dragonlock") {
            dragonlock_square_negative_a(x,y);
            dragonlock_square_negative_b(x,y,north=false,south=true,east=false,west=true);
        } else {
            plain_square_negative(x,y,square_basis,edge_width);
        }
    }
    intersection() {
        translate([x*square_basis,0,0]) rotate([0,0,atan(x/y)]) {
            hull() {
                translate([0,0,0.4]) cube([wall_width/2,hyp,56]);
                translate([0,0.25,0])cube([wall_width/2-.25,hyp-.5,0.4]);
            }
            mirror([1,0,0]) cube([wall_width/2,hyp,6]);
        }
        difference() {
            hull() {
                translate([0,0,0.4]) cube([square_basis*x, square_basis*y, 5.6]);
                translate([0.25,0.25,0]) cube([square_basis*x-.5, square_basis*y-.5, .4]);
            }
            if(lock == "dragonlock") {
                dragonlock_square_negative_b(x,y,north=false,east=false);
                translate([0,square_basis*(y-1),0]) dragonlock_nub();
                translate([50.8,25.4,0]) rotate([0,0,180]) dragonlock_nub();
            }
        }
    }
}

module plain_alcove(x,y,square_basis,lock,edge_width) {
    mult = 25 / 10.2;
    wall_width = square_basis / mult;
    
    module semicircle() {
        hull() {
            difference() {
                translate([square_basis, 0, .4]) cylinder(5.6,x*square_basis/2+wall_width,x*square_basis/2+wall_width,$fn=200);
                translate([-wall_width-1,-x*square_basis-wall_width,-1]) cube([x*square_basis+wall_width*2+2,x*square_basis+wall_width,8]);
            }
            difference() {
                translate([square_basis, 0, 0]) cylinder(.4,x*square_basis/2+wall_width-.25,x*square_basis/2+wall_width-.25,$fn=200);
                translate([-wall_width-1,-x*square_basis-wall_width+.25,-1]) cube([x*square_basis+wall_width*2+2,x*square_basis+wall_width,8]);
            }
        }
    }

    if(lock == "dragonlock") {
        difference() {
            semicircle();
            dragonlock_square_negative_a(x,x, west=false, east=false, north=false, center=false);
            dragonlock_square_negative_b(x,x, west=false, east=false, north=false);
        }
    } else {
        difference() {
            plain_square_positive(x,x/2,square_basis,edge_width);
            translate([-1,8,-1]) cube([x*square_basis+2,x*square_basis,8]);
            plain_square_negative(x,x/2,square_basis,edge_width);
        }
        difference() {
            semicircle();
            translate([x*square_basis/2,0,-1]) cylinder(8,x*square_basis/2-.25, x*square_basis/2-.25,$fn=200);
        }
    }
}

/*
 * Top Level Function
 */
module base(x,y,square_basis,
        shape="square",magnet_hole=6,lock="false",priority="magnets",dynamic_floors="false",curvedconcave="false") {
    df = dynamic_floors == "true" ? true : false;
    edge_width = magnet_hole >= 5.55 ? magnet_hole + 1 : 6.55;

    difference() {
        union() {
            plain_base(x,y,square_basis,lock,shape,edge_width);
            if(df) {
                df_positive(x,y,square_basis,shape,edge_width);
            }
            connector_positive(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) ;
        }
        if(df) {
            df_negative(x,y,square_basis, shape, edge_width);
        }
        connector_negative(x,y,square_basis,shape,edge_width,magnet_hole,lock,priority) ;
    }
}

function keyLookup (data, key) = search(key, data, num_returns_per_match=1)[0];


basis = [
    ["25mm", 25],
    ["inch", 25.4],
    ["wyloch", 31.75]
];
square_basis_number = basis[keyLookup(basis, [square_basis])][1];
wall_width = 10.2*square_basis_number/25;

// Compatability
valid_dragonlock_x = (x % 2 == 0);
valid_dragonlock_y = (y % 2 == 0);
valid_dragonlock_basis = (square_basis == "inch");

valid_infinitylock_basis = (square_basis == "inch");

if(lock == "dragonlock" && !valid_dragonlock_x) {
    echo("ERROR: dragonlock can only work with tiles that have squared evenly dividible by 2");
} else if (lock == "dragonlock" && !valid_dragonlock_y) {
    echo("ERROR: dragonlock can only work with tiles that have squared evenly dividible by 2");
} else if (lock == "dragonlock" && !valid_dragonlock_basis) {
    echo("ERROR: dragonlock is only compatible with inch basis");
} else if (lock == "infinitylock" && !valid_infinitylock_basis) {
    echo("ERROR: infinitylock is only compatible with inch basis");
} else {
    color("Grey") base(x,y,square_basis_number,shape=shape,magnet_hole=magnet_hole,lock=lock,priority=priority,dynamic_floors=dynamic_floors);
}

//plain_base(x,y,square_basis_number,shape,7);