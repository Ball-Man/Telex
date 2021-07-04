if (instance_exists(obj_paper) && can_write) {
	keyboard_string = string_sanitize(keyboard_string);
	
	var str_len = string_length(keyboard_string);
	var str = keyboard_string;
	if (str_len > max_length)
		str = string_copy(keyboard_string, str_len - max_length + 1, max_length);
	
	obj_paper.typed_text = str;
}
