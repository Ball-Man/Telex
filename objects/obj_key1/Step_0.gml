switch (state) {
	case KEY_STATE.RELEASED:
		if (key_pressed()) {
			state = KEY_STATE.PRESSED;
			
			var snd = audio_play_sound(snd_key_down, 0, false);
			audio_sound_pitch(snd, random_range(0.9, 1.1));
			
			// Push letter to the morse queue
			morse_push(key);
			
			//alarm_set(0, press_time);
		}
		image_index = 0;
		
		break;
		
	case KEY_STATE.PRESSED:
		image_index = 1;
		
		if (key_released()) {
			state = KEY_STATE.RELEASED;
			
			if (key_pressed) {
				var snd = audio_play_sound(snd_key_up, 0, false);
				audio_sound_pitch(snd, random_range(0.9, 1.1));
			}
		}
		
		break;
}
