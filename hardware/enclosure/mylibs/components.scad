/*************************
 * Common PCB components
 *************************/

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

pcb_thickness = 1.6;

module LED_rnd(dia, ht, color, dx, dy) {
  translate([dx, dy, topPCB]) {
    color(color) {
      up(ht-dia/2)
      sphere(d=dia);
      cyl(d=dia, h=ht-dia/2, align=V_TOP);
    }
  }
}

module pcboard() {
  up(post_height)
  difference() {
    color("darkorchid")
    cuboid([pcb_x, pcb_y, pcb_thickness], align=V_TOP,
           fillet=2, edges=EDGES_Z_ALL);

    if (HOLES) {
      holes();
    }
  }
}

// pcb mounting holes
module holes () {
  grid2d(rows=2,cols=2,spacing=[pins_x,pins_y])
  cyl(d=pin_hole_dia, h=4, align=V_TOP);
}

// generic pcb, no holes
module pcb(x, y, fil, color, dx, dy, dz) {
  translate([dx, dy, dz])
  color(color)
  cuboid([x, y, pcb_thickness], align=V_TOP,
         fillet=fil, edges=EDGES_Z_ALL);
}

module component_rect(x, y, z, color, dx, dy, dz) {
  translate([dx, dy, dz])
  color(color)
  cuboid([x, y, z], align=V_TOP);
}

module component_rect45(x, y, z, color, dx, dy, dz) {
  translate([dx, dy, dz])
  rotate(45)
  color(color)
  cuboid([x, y, z], align=V_TOP);
}

module component_rnd(dia, ht, color, dx, dy) {
  translate([dx, dy, topPCB])
  color(color)
  cyl(d=dia, h=ht, align=V_TOP);
}

// header - 2 rows "sepa" apart
module dip_header(x, y, z, sepa, dx, dy, dz,
                  color="black", vertical=false) {  
  if (vertical) {
    grid2d(rows=1, cols=2, spacing=[sepa, 0])
    component_rect(x, y, z, color, dx, dy, dz);
  } else {
    grid2d(rows=2, cols=1, spacing=[0, sepa])
    component_rect(x, y, z, color, dx, dy, dz);
  }
}

// functions

function mm(in) = in * 25.4;
