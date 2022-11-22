/*
 * SwitchIR Board Enclosure Dimensions
 */

// dimensions
relief = 6;             // relief on two sides
board_x = mm(2.000);
board_y = mm(1.600);

board_hole_dia = 3.2;
board_hole_dx = mm(1.600);
board_hole_dy = mm(1.200);

post_dia = 5;
post_height = 3;
pin_dia = 3;
pin_height = 2;
tPost = post_height;

box_x = board_x + relief;
box_y = board_y + relief;
box_wall = 2.5;
box_walls = box_wall * 2;
box_height = 22;

pcb_thickness = 1.6;
header_thickness = mm(0.200);
