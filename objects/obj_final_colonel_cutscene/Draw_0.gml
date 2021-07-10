/// @description Draw door
draw_set_color(c_white);
draw_rectangle(room_width / 2 - door_width, room_height / 2 - 80, room_width / 2 + door_width, room_height / 2 + 80, false);

draw_set_color(LIGHT_GRAY);
draw_rectangle(room_width / 2 - door_width - xoffset, room_height / 2 - 100, room_width / 2 - xoffset, room_height / 2 + 100, false);
draw_rectangle(room_width / 2 + xoffset, room_height / 2 - 100, room_width / 2 + door_width + xoffset, room_height / 2 + 100, false);
