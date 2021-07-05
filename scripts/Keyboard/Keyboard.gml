// Key bindings for main actions
// Every binding is an array of valid keys for that specific action
global.key_dialog = [ord("E"), vk_space, vk_enter];		// Scroll dialogs

// Internal use only, check if one key from the array satisfies the
// given function (eg. keyboard_check_pressed, keyboard_check_released, etc.).
function _keyboard_check_array(arr, func) {
	for (var i = 0; i < array_length(arr); i++)
		if (func(arr[i]))
			return true;
			
	return false;
}

// Check if one of the valid keys is down
function keyboard_check_array(arr) {
	return _keyboard_check_array(arr, keyboard_check);
}

// Check if one of the valid keys is being pressed
function keyboard_check_array_pressed(arr) {
	return _keyboard_check_array(arr, keyboard_check_pressed);
}

// Check if one of the valid keys is being released
function keyboard_check_array_released(arr) {
	return _keyboard_check_array(arr, keyboard_check_released);
}
