/// @description Draw cur_string using fnt_dialog and draw a gradient in the room.
// Dialog text
draw_set_font(fnt_dialog);
draw_set_color(c_white);

draw_text_ext(hoffset, voffset, cur_string, -1, room_width - hoffset * 2);

// Gradient
draw_set_color(LIGHT_GRAY);
draw_rectangle(0, 0, room_width, voffset / 4, false);
draw_set_color(GRAY);
draw_rectangle(0, voffset / 4, room_width, voffset / 4 * 2, false);
draw_set_color(DARK_GRAY);
draw_rectangle(0, voffset * 2 / 4, room_width, voffset * 3 / 4, false);
