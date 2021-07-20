switch (state) {
	case KEY_STATE.RELEASED:
		if (key_pressed()) {
			state = KEY_STATE.PRESSED;
			
			var snd = audio_play_sound(snd_key_down, 0, false);
			audio_sound_pitch(snd, random_range(0.9, 1.1));
		}
		image_index = 0;
		
		break;
		
	case KEY_STATE.PRESSED:
		image_index = 1;
		
		if (key_released()) {
			state = KEY_STATE.RELEASED;
			dialog_language_next();
			localizer_language_next();
			
			if (key_pressed) {
				var snd = audio_play_sound(snd_key_up, 0, false);
				audio_sound_pitch(snd, random_range(0.9, 1.1));
			}
		}
		
		break;
}
