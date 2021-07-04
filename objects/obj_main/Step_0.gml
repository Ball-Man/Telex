// Manage player input and check for quest completion.
if (instance_exists(obj_paper) && can_write) {
	keyboard_string = string_sanitize(keyboard_string);
	
	// Check for quest completion
	// If all the available quests return an error, the player has made an error.
	// If at least one of the available quests is satisfied, all others are
	// discarded and the game shall carry on.
	results = array_create(array_length(global.target));
	for (var i = 0; i < array_length(global.target); i++)
		results[i] = global.targets[i].satisfy(keyboard_string);
	
	
	
	// Trim the string if too long (for displaying only)
	var str_len = string_length(keyboard_string);
	var str = keyboard_string;
	if (str_len > max_length)
		str = string_copy(keyboard_string, str_len - max_length + 1, max_length);
	
	obj_paper.typed_text = str;
}
