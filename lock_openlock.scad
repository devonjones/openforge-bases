/*
 * Openlock connection bay
 */

module openlock_chamber(buffer=0) {
    add = TOPLESS == "true" ? 10 : 0;
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,4.2+add]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,4.2+add]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,4.2+add]);
    }
    hull() {
        translate([5,-5,1.4]) cube([1,5*2,4.2+add]);
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
    if (TOPLESS != "true") {
        support();
        mirror([0,1,0]) support();
    }
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

module openlock_wall_negative(supports=true) {
    translate([0,0,0]) difference() {
        translate([0,0,1.4]) linear_extrude(height=4.2) {
            polygon([
                [-7.35,7],[-5.35,7],[-5.35,6],
                [-2.35,5],[2.35,5],
                [5.35,6],[5.35,7],[7.35,7],
                [7.35,-7],[5.35,-7],[5.35,-6],
                [2.35,-5],[-2.35,-5],
                [-5.35,-6],[-5.35,-7],[-7.35,-7]]);
        }
        if(supports) {
            translate([-6.35,0,0]) openlock_supports();
            rotate([0,0,180]) translate([-6.35,0,0]) openlock_supports();
        }
    }
}

module openlock_wall_positive() {
    translate([-6.35,-8,0.4]) cube([12.7,16,5.6]); 
}

module openlock_sidelock_negative() {
    
    translate([0,0,7]) rotate([90,0,0]) translate([0,0,-2.1]) linear_extrude(height=4.2) {
        polygon([[-1,-7],[-1,7],[2,7],[2,6],[5,5],[5.9,5],[5.9,5.26],[5.9+4.53,5.26],
            [5.9+4.53,-5.26],[5.9,-5.26],[5.9,-5],[5,-5],[2,-6],[2,-7]]);
    }
}

module openlock_sidelock_positive() {
    translate([0,-3.1,-8]) cube([11.43,6.2,16]);
}