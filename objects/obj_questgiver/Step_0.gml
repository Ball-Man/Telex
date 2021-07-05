/// @description Slide mechanics
switch (state) {
	case QUESTGIVER_STATE.SLIDING_IN:
		x = lerp(room_width, room_width - sprite_width, slide_counter / slide_time);

		slide_counter++;
		if (slide_counter > slide_time) {
			slide_counter = 0;
			state = QUESTGIVER_STATE.IDLE;
		}
		break;
		
	case QUESTGIVER_STATE.SLIDING_OUT:
		x = lerp(room_width - sprite_width, room_width, slide_counter / slide_time);

		slide_counter++;
		if (slide_counter > slide_time) {
			slide_counter = 0;
			state = QUESTGIVER_STATE.IDLE;
			
			// After sliding out, destroy 
			if (!is_undefined(quest_giver))
				quest_giver.instance = undefined;
			instance_destroy();
		}
		break;
}
