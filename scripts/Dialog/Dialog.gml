// Current dialog to be shown
global.current_dialog = undefined;
global._dialog_prev_room = undefined;
global._dialog_prev_keyboard_string = "";

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

// Generate a new Dialog encapsulating the given data and start
// the dialog by changing room to rm_dialog.
// To return from the dialog use end_dialog (see below).
function dialog_start(dialog_data) {
	global.current_dialog = new Dialog(dialog_data);
	global._dialog_prev_room = room;
	global._dialog_prev_keyboard_string = keyboard_string;
	room_persistent = true;
	room_goto(rm_dialog);
}

// End the current dialog and return to the previous room
// Do not use if not inside a dialog, unexpected behaviour.
function dialog_end() {
	global.current_dialog = undefined;
	keyboard_string = global._dialog_prev_keyboard_string;
	room_goto(global._dialog_prev_room);
}
