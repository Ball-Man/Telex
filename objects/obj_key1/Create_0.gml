image_speed = 0;

state = KEY_STATE.RELEASED;

enum KEY_STATE {
	RELEASED,
	PRESSED
}

key_down = function() {
	return key != "" && keyboard_check(ord(key));
}

key_released = function() {
	return key!= "" && keyboard_check_released(ord(key));
}

key_pressed = function() {
	return key!= "" && keyboard_check_pressed(ord(key));
}
