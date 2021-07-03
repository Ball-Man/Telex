image_speed = 0;

state = KEY_STATE.RELEASED;

enum KEY_STATE {
	RELEASED,
	PRESSED
}

is_pressed = function() {
	return key != "" && keyboard_check(ord(key));
}
