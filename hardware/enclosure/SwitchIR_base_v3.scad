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

include <mylibs/components.scad>
include <mylibs/mcus.scad>

include <common.scad>

// qt py module
qt_dx = mm(-0.600);
qt_dy = -1.27;

hdr_x = mm(0.75);
hdr_y = 2.54;
hdr_z = 5.0;      // short header (Adafruit)
// hdr_z = 8.50;  // standard header

pcbHdr_x = mm(0.75);
pcbHdr_y = 2.54;
pcbHdr_z = 2.54;

tPCB = tPost + pcb_thickness;
tHdr = tPCB + hdr_z;
tHdr2 = tHdr + pcbHdr_z;
tMCU = tHdr2 + pcb_thickness;

win_usb_width  = 8;
win_usb_height = 3;
win_usb_y_offset = -1.27;
win_usb_z_offset = tHdr2 + pcb_thickness;

win_ir_width  = mm(0.600);
win_ir_height = 6;
win_ir_x_offset = 0;
win_ir_z_offset = post_height + pcb_thickness;


$fn = 90;

SHOW_BOARD = true; // set to false before rendering stl

// build it

if (SHOW_BOARD) {
  echo(base_of_usb=tMCU);
  qt_py(qt_dx, qt_dy, tHdr2);
  // MCU pins
  dip_header(pcbHdr_x, pcbHdr_y, pcbHdr_z, mm(0.6),
             qt_dx, qt_dy, tHdr, "white");
  // pcb headers
  dip_header(hdr_x, hdr_y, hdr_z, mm(0.6),
             qt_dx, qt_dy, tPCB);
  solder_holes(mm(0.850), 0, tPCB);
  // transceiver
  component_rect(mm(0.387), mm(0.138), 4, "black",
                 0, mm(-0.720), tPCB);
  // SwitchIR PCB
  board();
}

color("blue")
pins();
color("cornflowerblue")
difference() {
  shell();
  union() {
    // wiring window
    window(mm(0.75), box_wall+0.2, 4.5,
       EDGES_Y_ALL,
       mm(0.300),
       (box_y + box_wall)/2,
       tPCB+2);
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

module solder_holes(dx, dy, dz) {
  translate([dx, dy, dz])
  grid2d(rows=4, cols=2, spacing=[2.54, 2.54])
  color("gold")
  down(0.8)
  cyl(d=1.8, h=1.9);
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
  pposts(pin_dia, "blue", board_hole_dx, board_hole_dy,
         post_height+pin_height);
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

module pposts(dia, color, dx, dy, dz) {
  translate([0, 0, dz])
  grid2d(rows=2, cols=2, spacing=[dx, dy])
  color(color)
  cyl(d1=dia, d2=dia/2, h=dia*0.85, align=V_TOP);
}
