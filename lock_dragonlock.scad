/*
 * Dragonlock connection bay
 */

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
}

module dragonlock_negative(supports=true) {
    difference() {
        union() {
            translate([-1,-6.8418,1.3695]) cube([5.1,6.8418*2,3.225]);
            hull() {
                translate([3.17,-7.62,-1]) cube([7.9634,7.62*2,4.81]);
                translate([3.17,-7.62,-1]) cube([7.735,7.62*2,5.5945]);
            }
        }
        if(supports) {
            translate([-1.1,-.25,0]) cube([4.262,.5,5]);
            translate([-1.1,3.59-.25,0]) cube([7.1,.5,5]);
            translate([-1.1,-3.59-.25,0]) cube([7.1,.5,5]);
        }
        translate([3,-3.9095,-1.1]) cube([10,3.9095*2,2.4695]);
        translate([3,-4.7685,-1.1]) rotate([0,0,39.15]) cube([5,5,2.4695]);
        mirror([0,1,0]) translate([3,-4.7685,-1.1]) rotate([0,0,39.15]) cube([5,5,2.4695]);
        translate([7,-2.12,-1]) cube([5,2.12*2,10]);
        translate([8.069,0,-1]) cylinder(10,2.815,2.811,$fn=50);

        difference() {
            translate([8.069,0,-1.1]) cylinder(2.4695,4.62,4.62,$fn=50);
            translate([3,-5,-1.2]) cube([10,10,1.2]);
        }
    }
}
