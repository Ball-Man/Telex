/// @description Draw typed text on top of itself/
draw_self();

// Hard 
for (var i = 1; i <= string_length(typed_text); i++) {
	if (string_width(string_copy(typed_text, 1, i)) > max_width)
		typed_text = string_insert("\n", typed_text, i - 1);
}

draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(fnt_typewriter);
draw_text(x, y + text_hoffset, typed_text);
draw_set_halign(fa_left);
