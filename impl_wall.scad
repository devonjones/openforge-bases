include <connectors.scad>

/*
 * Connector Positive
 */
module connector_wall_positive_square(x,square_basis,edge_width) {
    for ( i = [0 : x-1] ) {
        translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,-90]) center_connector_wall_positive(x);
    }
}

/*
module connector_positive_square_notch(x,y,square_basis,edge_width,north=true,south=true,east=true,west=true) {
    if(NOTCH == "true") {
        connector_positive_square(x,y,square_basis,edge_width,north=north,south=false,east=east,west=false);
        if(south) {
            translate([square_basis*NOTCH_X,0,0]) connector_positive_square(x-NOTCH_X,y-NOTCH_Y,square_basis,edge_width,north=false,south=true,east=false,west=false);
            translate([0,square_basis*NOTCH_Y,0]) connector_positive_square(NOTCH_X,NOTCH_Y,square_basis,edge_width,north=false,south=true,east=false,west=false);
        }
        if(west) {
            translate([square_basis*NOTCH_X,0,0]) connector_positive_square(NOTCH_X,NOTCH_Y,square_basis,edge_width,north=false,south=false,east=false,west=true);
            translate([0,square_basis*NOTCH_Y,0]) connector_positive_square(x-NOTCH_X,y-NOTCH_Y,square_basis,edge_width,north=false,south=false,east=false,west=true);
        }
    } else {
        connector_positive_square(x,y,square_basis,edge_width,north,south,east,west);
    }
}*/

/*
 * Connector Negative
 */
module connector_wall_negative(x,half,square_basis,edge_width) {
    h = half ? 0.5 : 0;
    for ( i = [0 : x-1] ) {
        translate([square_basis*(i+1)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_wall_negative(x, PRIORITY, LOCK, MAGNETS, MAGNET_HOLE);
    }
    if (x > 1) {
        for ( i = [1 : x-1] ) {
            translate([square_basis*i,0,0]) rotate([0,0,90]) joint_connector_wall_negative(x);
        }
    }
    if (half) {
        translate([square_basis*(x+h)-square_basis/2,0,0]) rotate([0,0,90]) center_connector_wall_negative(x, PRIORITY, LOCK, MAGNETS, MAGNET_HOLE);
    }
}

/*
module connector_negative_square_notch(x,y,square_basis,edge_width,north=true,south=true,east=true,west=true) {
    if(NOTCH == "true") {
        connector_negative_square(x,y,square_basis,edge_width,north=north,south=false,east=east,west=false);
        if(south) {
            translate([square_basis*NOTCH_X,0,0]) connector_negative_square(x-NOTCH_X,y-NOTCH_Y,square_basis,edge_width,north=false,south=true,east=false,west=false);
            translate([0,square_basis*NOTCH_Y,0]) connector_negative_square(NOTCH_X,NOTCH_Y,square_basis,edge_width,north=false,south=true,east=false,west=false);
        }
        if(west) {
            translate([square_basis*NOTCH_X,0,0]) connector_negative_square(NOTCH_X,NOTCH_Y,square_basis,edge_width,north=false,south=false,east=false,west=true);
            translate([0,square_basis*NOTCH_Y,0]) connector_negative_square(x-NOTCH_X,y-NOTCH_Y,square_basis,edge_width,north=false,south=false,east=false,west=true);
        }
    } else {
        connector_negative_square(x,y,square_basis,edge_width,north,south,east,west);
    }
}
*/

/*
 * Plain base exterior
 */
/*
module plain_square(x,y,square_basis,edge_width) {
    difference() {
        plain_square_positive(x,y,square_basis);
        edge = LOCK == "dragonlock" ? square_basis/2 : edge_width;
        plain_square_negative(x,y,square_basis,edge);
    }
}

module plain_square_positive(x,y,square_basis) {
    difference() {
        hull() {
            translate([0,0,0.4]) cube([square_basis*x, square_basis*y, 6-.39]);
            translate([0.25,0.25,0]) cube([square_basis*x-.5, square_basis*y-.5, 1]);
        }
        if(NOTCH == "true") {
            translate([-1,-1,-1]) cube([square_basis*NOTCH_X+1, square_basis*NOTCH_Y+1, 8]);
            hull() {
                translate([-1,-1,0]) cube([square_basis*NOTCH_X+1, square_basis*NOTCH_Y+1, .4]);
                translate([-1,-1,-0.01]) cube([square_basis*NOTCH_X+1.25, square_basis*NOTCH_Y+1.25, 0.01]);
            }
        }
    }
}

module plain_square_negative(x,y,square_basis,edge_width) {
    intersection() {
        translate([edge_width,edge_width,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2),square_basis*y-((edge_width+1)*2),8]);
        difference() {
            translate([edge_width,edge_width,0]) translate([1,1,-1]) cube([square_basis*x-((edge_width+1)*2),square_basis*y-((edge_width+1)*2),8]);
            if(NOTCH == "true") {
                translate([0,0,0.4]) cube([square_basis*NOTCH_X+edge_width+1, square_basis*NOTCH_Y+edge_width+1, 6]);
                translate([0.25,.25,0]) cube([square_basis*NOTCH_X+edge_width+1-.5, square_basis*NOTCH_Y+edge_width+1-.5, .4]);
            }
        }
    }
}
*/