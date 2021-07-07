// Manage player input and check for quest completion.
if (instance_exists(obj_paper) && can_write) { //  && array_length(global.target) > 0
	keyboard_string = string_sanitize(keyboard_string);
	
	// Check for quest completion
	// If all the available quests return an error, the player has made an error.
	// If at least one of the available quests is satisfied, all others are
	// discarded and the game shall carry on.
	var results = array_create(array_length(global.target));
	for (var i = 0; i < array_length(global.target); i++)
		results[i] = global.target[i].satisfy(keyboard_string);
	
	var final_result = check_results(results);
	
	if (keyboard_check_pressed(vk_anykey))
		log("result", final_result);
	
	// When an error occurs, remove the last inserted character
	if (final_result.result == QUEST_STATUS.ERROR) {
		keyboard_string = string_delete(keyboard_string, string_length(keyboard_string), 1);
		log("keyboard string", keyboard_string);
		global.errors += 1;
		
		// TODO: sound effect
	}
	
	
	// Trim the string if too long (for displaying only)
	var str_len = string_length(keyboard_string);
	var str = keyboard_string;
	if (str_len > max_length)
		str = string_copy(keyboard_string, str_len - max_length + 1, max_length);
	
	obj_paper.text_color = c_white;
	obj_paper.typed_text = str;
	
	// When the quest is satisfied, stop writing and change
	// color to the text for a while
	if (final_result.result == QUEST_STATUS.SATISFIED) {
		enable(false);
		obj_paper.text_color = $545454;
		obj_level.quest_satisfied(global.target[final_result.index]);
		
		// TODO: sound effect
	}
}
