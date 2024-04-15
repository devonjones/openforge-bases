/*
 * Magnets
 */
 
module magnetic_positive(magnet_hole=6, height=6) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,0]) cylinder(.41,magnet_hole/2+1-.25,magnet_hole/2+1, $fn=100);
        translate([magnet_hole/2+1,0,0.4]) cylinder(height-.4,magnet_hole/2+1,magnet_hole/2+1, $fn=100);
    }
}

module magnetic_negative(magnet_hole=6, height=8) {
    if (magnet_hole > 0) {
        translate([magnet_hole/2+1,0,1]) cylinder(height+2,magnet_hole/2,magnet_hole/2, $fn=100);
        translate([magnet_hole/2+1,0,-1]) cylinder(10,.9,.9,$fn=50);
    }
}

