/// @description Draw cur_string using fnt_dialog
draw_set_font(fnt_dialog);
draw_set_color(c_white);

draw_text_ext(hoffset, voffset, cur_string, -1, room_width - hoffset * 2);
