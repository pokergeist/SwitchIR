
/**************************
 * Common microcontrollers
 **************************/

include <components.scad>

module qt_py (dx, dy, dz) {
  pcb_thickness = 1.6;
  qt_x = mm(0.800);
  qt_y = mm(0.700);
  usb_x = mm(0.280);
  usb_y = mm(0.360);
  usb_z = 2.5;
  usb_dx = mm(-0.275);
  i2c_x = mm(0.170);
  i2c_y = mm(0.240);
  i2c_z = 2;
  i2c_dx = mm(0.310);
  i2c_dy = mm(-0.070);

  translate([dx, dy, dz]) {
    // DIP headers
    grid2d(rows=2, cols=1, spacing=[0, mm(0.6)])
    grid2d(rows=1, cols=7, spacing=[2.54,0])
    down(0.15)
    color("gold")
    cyl(d=1.2, h=pcb_thickness+0.3, align=V_TOP);

    // USB port
    component_rect(usb_x, usb_y, usb_z, "silver",
                   usb_dx, 0, pcb_thickness);
    // Qwiic port
    component_rect(i2c_x, i2c_y, i2c_z, "black",
                   i2c_dx, i2c_dy, pcb_thickness);
    pcb(qt_x, qt_y, 2, "DarkSlateGray", 0, 0, 0);
  }
}

module ItsyBitsy (dx, dy, dz) {
  usb_x = mm(0.220);
  usb_y = mm(0.300);
  usb_z = 2.5;
  usb_dx = mm(-0.650);
  pcb_thickness = 1.6;

  translate([dx, dy, dz]) {
    // USB port
    component_rect(usb_x, usb_y, usb_z, "silver",
                   usb_dx, 0, pcb_thickness);
   // processor
    component_rect45(8.0, 8.0, 2.0, "darkslategrey",
                     5, 0, pcb_thickness);
    pcb(ib_x, ib_y, 2, "blue", 0,0,0);

    // end header
    translate([mm(0.650),0,0])
    grid2d(rows=5, cols=1, spacing=[0, 2.54])
    color("gold")
    cyl(d=1.2,h=pcb_thickness+0.2,align=V_TOP);

    // DIP headers
    grid2d(rows=2, cols=1, spacing=[0, mm(0.6)])
    grid2d(rows=1, cols=14, spacing=[2.54,0]) {
    down(0.1)
    color("gold")
    cyl(d=1.2,h=pcb_thickness+0.2,align=V_TOP);
    }
  }
}