/// @description Draw the note's text.
draw_self();

draw_set_font(font);
draw_set_color(c_white);
draw_text_ext(x + 10, y + 10, text, -1, max_width);
