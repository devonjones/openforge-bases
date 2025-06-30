include <impl_square.scad>

module plain_angled_corner_60(square_basis,edge_width) {
    module half() {
        difference() {
            rotate([0,0,60]) difference() {
                plain_square(2,2,square_basis,edge_width);
                translate([square_basis*2,square_basis*1,-1]) rotate([0,0,30]) cube([square_basis*1+2, square_basis*2+2, HEIGHT+2]);
            }
            rotate([0,0,90]) translate([0,0,-1]) cube([square_basis*3,square_basis*3,8]);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module connector_angled_corner_60_positive(square_basis,edge_width) {
    module half() {
        rotate([0,0,60]) {
            connector_positive_strip(2, square_basis, edge_width, left=false, right=true);
            translate([square_basis*2,0,0]) rotate([0,0,90]) connector_positive_strip(1, square_basis, edge_width);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module connector_angled_corner_60_negative(square_basis,edge_width) {
    module half() {
        rotate([0,0,60]) {
            connector_negative_strip(2, square_basis, edge_width, left=false, right=true);
            translate([square_basis*2,0,0]) rotate([0,0,90]) connector_negative_strip(1, square_basis, edge_width);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module plain_angled_corner_120(square_basis,edge_width) {
    module half() {
        difference() {
            rotate([0,0,30]) translate([-square_basis,0,0]) plain_square(2,1,square_basis,edge_width);
            rotate([0,0,90]) translate([-square_basis,0,-1]) cube([square_basis*3,square_basis*3,8]);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module connector_angled_corner_120_positive(square_basis,edge_width) {
    module half() {
        rotate([0,0,30]) {
            connector_positive_strip(1, square_basis, edge_width, left=false, right=true);
            translate([square_basis,0,0]) rotate([0,0,90]) connector_positive_strip(1, square_basis, edge_width);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module connector_angled_corner_120_negative(square_basis,edge_width) {
    module half() {
        rotate([0,0,30]) {
            connector_negative_strip(1, square_basis, edge_width, left=false, right=true);
            translate([square_basis,0,0]) rotate([0,0,90]) connector_negative_strip(1, square_basis, edge_width);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module plain_angled_corner_240(square_basis,edge_width) {
    module half() {
        difference() {
            rotate([0,0,-30]) translate([-square_basis,0,0]) plain_square(2,1,square_basis,edge_width);
            rotate([0,0,90]) translate([-square_basis,0,-1]) cube([square_basis*3,square_basis*3,8]);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module connector_angled_corner_240_positive(square_basis,edge_width) {
    module half() {
        rotate([0,0,-30]) {
            connector_positive_strip(1, square_basis, edge_width, left=false, right=true);
            translate([square_basis,0,0]) rotate([0,0,90]) connector_positive_strip(1, square_basis, edge_width);
        }
    }
    half();
    mirror([1,0,0]) half();
}

module connector_angled_corner_240_negative(square_basis,edge_width) {
    module half() {
        rotate([0,0,-30]) {
            connector_negative_strip(1, square_basis, edge_width, left=false, right=true);
            translate([square_basis,0,0]) rotate([0,0,90]) connector_negative_strip(1, square_basis, edge_width);
        }
    }
    half();
    mirror([1,0,0]) half();
}
