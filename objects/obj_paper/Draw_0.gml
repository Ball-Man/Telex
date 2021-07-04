/// @description Draw typed text on top of itself/
draw_self();

// Hard 
for (var i = 1; i <= string_length(typed_text); i++) {
	if (string_width(string_copy(typed_text, 1, i)) > max_width)
		typed_text = string_insert("\n", typed_text, i);
}
lines = string_split(typed_text, "\n");

draw_set_color(text_color);
draw_set_font(fnt_typewriter);
draw_text(x - max_width / 2, y + text_hoffset, typed_text);
