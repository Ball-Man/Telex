switch (state) {
	case KEY_STATE.RELEASED:
		if (is_pressed()) {
			state = KEY_STATE.PRESSED;
			alarm_set(0, press_time);
		}
		image_index = 0;
		
		break;
		
	case KEY_STATE.PRESSED:
		image_index = 1;
}
