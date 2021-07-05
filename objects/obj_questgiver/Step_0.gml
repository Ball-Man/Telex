/// @description Slide mechanics
if (slide_in) {
	x = lerp(room_width, room_width - sprite_width, slide_counter / slide_time);

	slide_counter++;
	if (slide_counter > slide_time) {
		slide_counter = 0;
		slide_in = false;
	}
}
