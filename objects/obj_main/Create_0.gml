max_length = 35;
can_write = false;

// Enable/disable the player from completing the current quest
// keyboard_string is set to empty string in order to avoid
// tainting from previous iterations.
enable = function(value) {
	can_write = value;
	keyboard_string = "";
}

global.general.slide_in();
