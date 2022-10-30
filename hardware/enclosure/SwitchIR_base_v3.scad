/*
 * SwitchIR Board Enclosure
 */

/********************************************************
 * Object are placed with bottom on the XY plane using
 * align=V_TOP. This eliminates a lot of up(obj_z/2)
 * moves. The floor of the box becomes the new reference
 * plane. Posts are placed on the floor, board is placed
 * on top of the posts, etc.
 ********************************************************/

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

include <common.scad>

// qt py module
qt_x = mm(0.800);
qt_y = mm(0.700);
qt_x_off = mm(-0.600);
qt_y_off = 0;

$fn = 90;

SHOW_BOARD = true; // set to false before rendering stl

// build it

if (SHOW_BOARD) {
  qt_py();
  board();
}
pins();
color("cornflowerblue")
difference() {
  shell();
  union() {
  // IR windown
  window(win_ir_width, box_wall+0.2, win_ir_height,
         EDGES_Y_ALL,
         win_ir_x_offset,
         -(box_y + box_wall)/2,
         win_ir_z_offset);
  // USB-C window
  window(box_wall+0.2, win_usb_width, win_usb_height,
         EDGES_X_ALL,
         -(box_x + box_wall)/2,
         win_usb_y_offset,
         win_usb_z_offset);
  }
}

//---------------------

// modules

module qt_py () {
  translate([qt_x_off, qt_y_off,
             post_height+pcb_thickness+header_thickness])
  color("DarkSlateGray")
  cuboid([qt_x, qt_y, pcb_thickness], align=V_TOP,
         fillet=2, edges=EDGES_Z_ALL);
}

module board () {
  up(post_height)
  color("red")
  cuboid([board_x, board_y, pcb_thickness], align=V_TOP,
         fillet=4, edges=EDGES_Z_ALL);
}

module window (x, y, z, edg, dx, dy, dz) {
  translate([dx, dy, dz])
  cuboid([x, y, z], align=V_TOP, fillet=box_wall/4,
         edges=edg);
}

module pins() {
  pin( board_hole_dx/2,  board_hole_dy/2);
  pin( board_hole_dx/2, -board_hole_dy/2);
  pin(-board_hole_dx/2,  board_hole_dy/2);
  pin(-board_hole_dx/2, -board_hole_dy/2);
}

module pin(dx, dy) {
  translate([dx, dy, 0]) {
    up(post_height)
    cyl(d=pin_dia,  h=pin_height, align=V_TOP);
    cyl(d=post_dia, h=post_height, align=V_TOP);
  }
}

module shell() {
  difference() {
    down(box_wall)  // box floor is the reference plane
    cuboid([box_x+box_walls, box_y+box_walls, box_height],
           align=V_TOP, fillet=2, edges=EDGES_Z_ALL);

    cuboid([box_x, box_y, box_height], align=V_TOP);
  }
}