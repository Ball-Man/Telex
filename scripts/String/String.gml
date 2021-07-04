// Return an uppercase string containing only the right symbols (a-z, no numbers or special characters).
function string_sanitize(str) {
	// Uppercase string
	str = string_upper(str);
	
	// Remove unwanted characters
	// (Note that this approach is highly unefficient, but is by far easier to write).
	for (var i = 1; i <= string_length(str); i++) {
		if ((string_byte_at(str, i) <= ord("A") || string_byte_at(str, i) >= ord("Z")) && string_char_at(str, i) != " ") {
			str = string_delete(str, i, 1);
			i--;
		}
	}
	
	return str;
}
