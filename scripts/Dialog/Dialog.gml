// Current dialog to be shown
global.current_dialog = undefined;
global._dialog_prev_room = undefined;
global._dialog_prev_keyboard_string = "";

// Data from files
#macro DIALOG_DATA_FILE "dialog.json"
global.dialog_data = undefined;

// Dialogs are shown in chunks. Hence a complete dialog is a nothing but a list of strings.
// This class contains that string, with eventual additional metadata.
function DialogData(strings_) constructor {
	strings = strings_;
	autoscroll = false;
	if (argument_count > 1)
		autoscroll = argument[1];
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

// Populate global.dialog_data with a dictionary of data imported
// from json.
function dialog_import() {
	if (!file_exists(DIALOG_DATA_FILE)) {
		show_error("Missing file " + DIALOG_DATA_FILE, false);
		return;
	}
	
	// Read from file
	var file = file_text_open_read(DIALOG_DATA_FILE);
	var json = "";
	while (!file_text_eof(file))
		json += file_text_readln(file);
	
	var file_dict = json_decode(json);
	log("imported dialog json", json);
	
	// Convert into DialogData
	var dialog_data = ds_map_create();
	
	var start_key = ds_map_find_first(file_dict);
	for (var i = 0; i < ds_map_size(file_dict); i++) {
		var sub_list = file_dict[? start_key];
		
		// Convert all ds_lists into arrays
		var sub_array = array_create(ds_list_size(sub_list));
		for (var j = 0; j < ds_list_size(sub_list); j++) {
			var strings_array = array_create(ds_list_size(sub_list[| j][? "data"]));
			for (var k = 0; k < ds_list_size(sub_list[| j][? "data"]); k++)
				strings_array[k] = sub_list[| j][? "data"][| k];
				
			sub_array[j] = new DialogData(strings_array, sub_list[| j][? "autoscroll"]);
		}
		
		dialog_data[? start_key] = sub_array;
		
		start_key = ds_map_find_next(file_dict, start_key);
	}
	global.dialog_data = dialog_data;
	
	// Cleanup
	ds_map_destroy(file_dict);
}
