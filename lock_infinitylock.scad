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
