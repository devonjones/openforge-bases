/*
 * Flex Magnet
 */
module flex_magnetic_positive(magnet_hole=6, height=6) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,0]) cylinder(.41,magnet_hole/2+1-.25,magnet_hole/2+1, $fn=100);
        translate([magnet_hole/2+1,0,0.4]) cylinder(height-.4,magnet_hole/2+1,magnet_hole/2+1, $fn=100);
        hull() {
            translate([0.25,-magnet_hole/2-1+.25,0]) cube([magnet_hole/2+1-.25,magnet_hole+2-.5,1]);
            translate([0,-magnet_hole/2-1,.4]) cube([magnet_hole/2+1,magnet_hole+2,height-.4]);
        }
    }
}

module flex_magnetic_negative(magnet_hole=6, height=6) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,1]) cylinder(height+2,magnet_hole/2,magnet_hole/2, $fn=100);
        translate([1,-magnet_hole/2,1]) cube([magnet_hole/2,magnet_hole,height+2]);
        translate([magnet_hole/2+1,0,-1]) cylinder(10,.9,.9,$fn=50);
        translate([1,-.9,-1]) cube([magnet_hole/2,.9*2,10]);
    }
}

module flex_magnetic_hex(square_basis, magnet_hole=6, height=6) {
    if (magnet_hole > 0) {
        hull() {
            translate([square_basis/2,0,0]) rotate([0,0,90]) translate([magnet_hole/2+1,0,1]) cylinder(height+2,magnet_hole/2,magnet_hole/2, $fn=100);
            rotate([0,0,-120]) mirror([1,0,0]) translate([square_basis/2,0,0]) rotate([0,0,90]) translate([magnet_hole/2+1,0,1]) cylinder(height+2,magnet_hole/2,magnet_hole/2, $fn=100);
        }
        translate([square_basis/2,0,0]) rotate([0,0,90]) union() {
            //translate([magnet_hole/2+1,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
            translate([1,-magnet_hole/2,1]) cube([magnet_hole/2,magnet_hole,height+2]);
            translate([magnet_hole/2+1,0,-1]) cylinder(10,.9,.9,$fn=50);
            translate([1,-.9,-1]) cube([magnet_hole/2,.9*2,10]);
        }
        rotate([0,0,-120]) mirror([1,0,0]) translate([square_basis/2,0,0]) rotate([0,0,90]) union() {
            //translate([magnet_hole/2+1,0,1]) cylinder(8,magnet_hole/2,magnet_hole/2, $fn=100);
            translate([1,-magnet_hole/2,1]) cube([magnet_hole/2,magnet_hole,height+2]);
            translate([magnet_hole/2+1,0,-1]) cylinder(10,.9,.9,$fn=50);
            translate([1,-.9,-1]) cube([magnet_hole/2,.9*2,10]);
        }
    }
}
