// Current dialog to be shown
global.current_dialog = undefined;

// Dialogs are shown in chunks. Hence a complete dialog is a nothing but a list of strings.
// This class contains that string, with eventual additional metadata.
function DialogData(strings_) constructor {
	strings = strings_;
	autoscroll = false;
	if (argument_count > 1)
		autoscroll = true;
}

// A Dialog encapsules a DialogData and enriches it with specific
// information about it's reproduction.
function Dialog(data_) constructor {
	data = data_;
	current_index = 0;
	
	// Return next string in the dialog. If the dialog is over, the last one will be returned.
	static next_string = function() {
		if (current_index >= array_length(data.strings))
			if (array_length(data.strings) == 0)
				return "";
			else
				return data.strings[array_length(data.strings) - 1];
				
		return data.strings[current_index++];
	}
	
	// Return true if all the dialog strings have been returned by next_string. False otherwise.
	static is_over = function() {
		return current_index >= array_length(data.strings);
	}
}
