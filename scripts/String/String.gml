// Return an uppercase string containing only the right symbols (a-z, no numbers or special characters).
function string_sanitize(str) {
	// Uppercase string
	str = string_upper(str);
	
	// Remove unwanted characters
	// (Note that this approach is highly unefficient, but is by far easier to write).
	for (var i = 1; i <= string_length(str); i++) {
		if ((string_byte_at(str, i) < ord("A") || string_byte_at(str, i) > ord("Z")) && string_char_at(str, i) != " ") {
			str = string_delete(str, i, 1);
			i--;
		}
	}
	
	return str;
}

// Returned a splitted string by the given separator, in an array of strings
function string_split(str, sep) {
	var slot = 0;
	var splits = [str]; // Array of splits
	var str2 = ""; // Temp variable for current split

	var i;
	for (i = 1; i <= string_length(str); i++) {
	    var curr = string_copy(str, i, 1);
	    if (curr == sep) {
	        splits[slot] = str2; //add this split to the array of all splits
	        slot++;
	        str2 = "";
	    } else {
	        str2 = str2 + curr;
	        splits[slot] = str2;
	    }
	}
	
	return splits;
}

// Return a path string joined with the correct separator (eg. "/").
function string_path_join() {
	var sep = "/";
	if (os_type == os_windows || os_type == os_uwp)
		sep = "\\";
	
	var ret = "";
	for (var i = 0; i < argument_count; i++)
		ret += string(argument[i]) + (i < (argument_count - 1) ? sep : "");
		
	return ret;
}
