// Inherit the parent event
event_inherited();

// Override special functions so that spacebar is checked instead of the given key

key_down = function() {
	return keyboard_check(vk_space);
}

key_released = function() {
	return keyboard_check_released(vk_space);
}

key_pressed = function() {
	return keyboard_check_pressed(vk_space);
}
