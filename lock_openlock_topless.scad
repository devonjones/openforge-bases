/*
 * Openlock Topless connection bay
 */

module openlock_topless_chamber(buffer=0, height=6) {
    translate([-buffer,-7,1.4]) cube([2+buffer,7*2,height+1]);
    hull() {
        translate([0,-6,1.4]) cube([2,6*2,height+1]);
        translate([3+0.01,-5,1.4]) cube([2,5*2,height+1]);
    }
    hull() {
        translate([5,-5,1.4]) cube([1,5*2,height+1]);
        translate([6,-5,1.4]) cube([1,5*2,height+1]);
    }
    translate([6,-6.4,-1]) cube([4.7,6.4*2,height+3.4]);
}

module openlock_topless_positive(height=6) {
    translate([0,-8,0.4]) cube([2,16,height-.4]); 
}

module openlock_topless_negative(supports=true, height=6) {
    difference() {
        openlock_topless_chamber(1, height=height);
    }
}
