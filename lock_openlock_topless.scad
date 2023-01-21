/*
 * Openlock Topless connection bay
 */
module openlock_topless_chamber(buffer=0) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,7]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,7]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,7]);
    }
    hull() {
        translate([5,-5,1.4]) cube([1,5*2,7]);
        translate([6,-5,1.4]) cube([1,5*2,7]);
    }
    translate([6,-6.4,-1]) cube([4.7,6.4*2,9.4]);
}

module openlock_topless_positive() {
    translate([0,-8,0.4]) cube([2,16,5.6]); 
}

module openlock_topless_negative(supports=true) {
    difference() {
        openlock_topless_chamber(1);
    }
}
