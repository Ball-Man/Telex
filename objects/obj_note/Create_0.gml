/// @description Scale the note
event_inherited();

// Resize the note to fit the current text
resize = function() {
	draw_set_font(fnt_general);
	
	var text_width = string_width_ext(text, -1, max_width);
	var text_height = string_height_ext(text, -1, max_width);

	image_xscale = (text_width + 20) / sprite_width;
	image_yscale = (text_height + 20) / sprite_height;
}

resize();
