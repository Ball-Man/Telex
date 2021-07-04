if (instance_exists(obj_paper)) {
	var str_len = string_length(keyboard_string);
	var str = keyboard_string;
	if (str_len > 10)
		str = string_copy(keyboard_string, str_len - 10, 10);
	obj_paper.typed_text = str;
}
