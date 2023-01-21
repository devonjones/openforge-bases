include <lock_dragonlock.scad>
include <lock_infinitylock.scad>
include <lock_openlock.scad>
include <lock_openlock_topless.scad>
include <lock_magnetic.scad>
include <lock_flex_magnetic.scad>

/*
 * Connector Layout
 */
module center_connector_positive(edge, priority, lock, magnets, magnet_hole) {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_positive();
        } else if (priority == "lock" && lock == "openlock_topless") {
            openlock_topless_positive();
        } else if (PRIORITY == "lock" && lock == "infinitylock") {
            infinitylock_positive();
        } else if (PRIORITY == "lock" && lock == "dragonlock") {
            dragonlock_positive();
        } else if (PRIORITY == "lock" && lock == "dragonlocktriplex") {
            dragonlock_positive();
        } else {
            if (magnets == "magnetic") {
                magnetic_positive(magnet_hole);
            } else if (magnets == "flex_magnetic") {
                flex_magnetic_positive(magnet_hole);
            }
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_positive();
        } else if (priority == "lock" && lock == "openlock" && magnets == "none") {
            openlock_positive();
        } else if (priority == "lock" && lock == "openlock_topless" && magnets == "none") {
            openlock_topless_positive();
        } else if (priority == "lock" && lock == "infinitylock" && magnets == "none") {
            infinitylock_positive();
        } else if (priority == "lock" && lock == "dragonlocktriplex" && magnets == "none") {
            dragonlock_positive();
        } else {
            if (magnets == "magnetic") {
                magnetic_positive(magnet_hole);
            } else if (magnets == "flex_magnetic") {
                flex_magnetic_positive(magnet_hole);
            }
        }
    }
}

module center_connector_negative(edge, priority, lock, magnets, magnet_hole) {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_negative();
        } else if (priority == "lock" && lock == "openlock_topless") {
            openlock_topless_negative();
        } else if (priority == "lock" && lock == "infinitylock") {
            infinitylock_negative();
        } else if (priority == "lock" && lock == "dragonlock") {
            dragonlock_negative();
        } else if (priority == "lock" && lock == "dragonlocktriplex") {
            dragonlock_negative();
        } else {
            if (magnets == "magnetic") {
                magnetic_negative(magnet_hole);
            } else if (magnets == "flex_magnetic") {
                flex_magnetic_negative(magnet_hole);
            }
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_negative();
        } else if (priority == "lock" && lock == "openlock" && magnets == "none") {
            openlock_negative();
        } else if (priority == "lock" && lock == "openlock_topless" && magnets == "none") {
            openlock_topless_negative();
        } else if (priority == "lock" && lock == "infinitylock" && magnets == "none") {
            infinitylock_negative();
        } else if (priority == "lock" && lock == "dragonlocktriplex" && magnets == "none") {
            dragonlock_negative();
        } else {
            if (magnets == "magnetic") {
                magnetic_negative(magnet_hole);
            } else if (magnets == "flex_magnetic") {
                flex_magnetic_negative(magnet_hole);
            }
        }
    }
}

module joint_connector_positive(edge) {
    if(LOCK == "openlock" || LOCK == "triplex") {
        openlock_positive();
    } else if (LOCK == "openlock_topless") {
        openlock_topless_positive();
    } else if (LOCK == "infinitylock") {
        infinitylock_positive();
    } else if (LOCK == "dragonlock" || LOCK == "dragonlocktriplex") {
        dragonlock_positive();
    }
}

module joint_connector_negative(edge) {
    if(LOCK == "openlock" || LOCK == "triplex") {
        openlock_negative();
    } else if (LOCK == "openlock_topless") {
        openlock_topless_negative();
    } else if (LOCK == "infinitylock") {
        infinitylock_negative();
    } else if (LOCK == "dragonlock" || LOCK == "dragonlocktriplex") {
        dragonlock_negative();
    }
}

module connector_positive(square_basis, priority, lock, magnets, magnet_hole, right=true, center=true, left=true) {
    if (left) {
        translate([0,square_basis*(.5),0]) center_connector_positive(0, priority, lock, magnets, magnet_hole);
    }
    if (center) {
        translate([0,square_basis*(-.5),0]) center_connector_positive(0, priority, lock, magnets, magnet_hole);
    }
    if(right) {
        translate([0,0,0]) joint_connector_positive(0);
    }
}

module connector_negative(square_basis, priority, lock, magnets, magnet_hole, right=true, center=true, left=true, magnets) {
    if (left) {
        translate([0,square_basis*(.5),0]) center_connector_negative(0, priority, lock, magnets, magnet_hole);
    }
    if (center) {
        translate([0,0,0]) joint_connector_negative(0);
    }
    if(right) {
        translate([0,square_basis*(-.5),0]) center_connector_negative(0, priority, lock, magnets, magnet_hole);
    }
}


module center_connector_wall_positive(edge, priority, lock, magnets, magnet_hole) {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_wall_positive();
        } else if (priority == "lock" && lock == "openlock_topless") {
            openlock_topless_positive();
        } else if (PRIORITY == "lock" && lock == "infinitylock") {
            infinitylock_positive();
        } else if (PRIORITY == "lock" && lock == "dragonlock") {
            dragonlock_positive();
        } else if (PRIORITY == "lock" && lock == "dragonlocktriplex") {
            dragonlock_positive();
        } else {
            if (magnets == "magnetic") {
                magnetic_positive(magnet_hole);
            } else if (magnets == "flex_magnetic") {
                flex_magnetic_positive(magnet_hole);
            }
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_wall_positive();
        } else if (priority == "lock" && lock == "openlock" && magnets == "none") {
            openlock_positive();
        } else if (priority == "lock" && lock == "openlock_topless" && magnets == "none") {
            openlock_topless_positive();
        } else if (priority == "lock" && lock == "infinitylock" && magnets == "none") {
            infinitylock_positive();
        } else if (priority == "lock" && lock == "dragonlocktriplex" && magnets == "none") {
            dragonlock_positive();
        } else {
            if (magnets == "magnetic") {
                magnetic_positive(magnet_hole);
            } else if (magnets == "flex_magnetic") {
                flex_magnetic_positive(magnet_hole);
            }
        }
    }
}

module center_connector_wall_negative(edge, priority, lock, magnets, magnet_hole) {
    if (edge == 1) {
        if (priority == "lock" && (lock == "openlock" || lock == "triplex")) {
            openlock_wall_negative();
        } else if (priority == "lock" && lock == "openlock_topless") {
            echo("Not Implemented");
        } else if (priority == "lock" && lock == "infinitylock") {
            echo("Not Implemented");
        } else if (priority == "lock" && lock == "dragonlock") {
            echo("Not Implemented");
        } else if (priority == "lock" && lock == "dragonlocktriplex") {
            echo("Not Implemented");
        } else {
            if (magnets == "magnetic") {
                echo("Not Implemented");
            } else if (magnets == "flex_magnetic") {
                echo("Not Implemented");
            }
        }
    } else {
        if (priority == "lock" && lock == "triplex") {
            openlock_wall_negative();
        } else if (priority == "lock" && lock == "openlock" && magnets == "none") {
            openlock_wall_negative();
        } else if (priority == "lock" && lock == "openlock_topless" && magnets == "none") {
            echo("Not Implemented");
        } else if (priority == "lock" && lock == "infinitylock" && magnets == "none") {
            echo("Not Implemented");
        } else if (priority == "lock" && lock == "dragonlocktriplex" && magnets == "none") {
            echo("Not Implemented");
        } else {
            if (magnets == "magnetic") {
                echo("Not Implemented");
            } else if (magnets == "flex_magnetic") {
                echo("Not Implemented");
            }
        }
    }
}

module joint_connector_wall_positive(edge) {
    if(LOCK == "openlock" || LOCK == "triplex") {
        openlock_wall_positive();
    } else if (LOCK == "openlock_topless") {
        echo("Not Implemented");
    } else if (LOCK == "infinitylock") {
        echo("Not Implemented");
    } else if (LOCK == "dragonlock" || LOCK == "dragonlocktriplex") {
        echo("Not Implemented");
    }
}

module joint_connector_wall_negative(edge) {
    if(LOCK == "openlock" || LOCK == "triplex") {
        openlock_wall_negative();
    } else if (LOCK == "openlock_topless") {
        echo("Not Implemented");
    } else if (LOCK == "infinitylock") {
        echo("Not Implemented");
    } else if (LOCK == "dragonlock" || LOCK == "dragonlocktriplex") {
        echo("Not Implemented");
    }
}

module connector_wall_positive() {
    if (left) {
        translate([0,square_basis*(.5),0]) center_connector_wall_positive(0, priority, lock, magnets, magnet_hole);
    }
    if (center) {
        translate([0,square_basis*(-.5),0]) center_connector_wall_positive(0, priority, lock, magnets, magnet_hole);
    }
    if(right) {
        translate([0,0,0]) joint_connector_wall_positive(0);
    }
}

module connector_wall_negative() {
    if (left) {
        translate([0,square_basis*(.5),0]) center_connector_wall_negative(0, priority, lock, magnets, magnet_hole);
    }
    if (center) {
        translate([0,0,0]) joint_connector_wall_negative(0);
    }
    if(right) {
        translate([0,square_basis*(-.5),0]) center_connector_wall_negative(0, priority, lock, magnets, magnet_hole);
    }
}