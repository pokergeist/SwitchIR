/*
 * SwitchIR Board Enclosure Lid
 */

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

include <common.scad>

lid_height = 6;
lid_overlap  = 2.5;
lid_overlaps = 5.0;

$fn = 90;

// build it

color("cornflowerblue")
lid();

//---------------------

// modules

module lid() {
  difference() {
    down(box_wall) {
      cuboid([box_x, box_y, lid_height+lid_overlap],
             align=V_TOP, fillet=0.5, edges=EDGES_TOP);
      cuboid([box_x+box_walls, box_y+box_walls, lid_height],
             align=V_TOP, fillet=2, edges=EDGES_Z_ALL);
    }

    cuboid([box_x-lid_overlaps, box_y-lid_overlaps,
           lid_height+lid_overlap], align=V_TOP);
  }
}