// Current dialog to be shown
global.current_dialog = undefined;
global._dialog_prev_room = undefined;
global._dialog_prev_keyboard_string = "";

// Data from files
#macro DIALOG_DATA_FILE "dialog.json"
global.dialog_data = undefined;

// Dialogs are shown in chunks. Hence a complete dialog is a nothing but a list of strings.
// This class contains that string, with eventual additional metadata like the Quest which
// will be delivered after the dialog (undefined if no Quest shall start), the NPC
// speaking (a QuestGiver), and the minimum level of trust (trust_threshold) required by the game
// to play that specific line of dialog (by the given NPC).
// If the dialog both deploys a quest and requires a minimum trust level, the QuestGiver associated
// to the trust_threshold and the one inside the Quest instance must be the same.
function DialogData(strings_) constructor {
	strings = strings_;
	
	autoscroll = false;
	if (argument_count > 1)
		autoscroll = argument[1];
	
	questgiver = undefined;
	if (argument_count > 2)
		questgiver = argument[2];
	
	trust_threshold = 0;
	if (argument_count > 3)
		trust_threshold = argument[3];
		
	quest = undefined;
	if (argument_count > 4)
		quest = argument[4];
		
	immediate_skip = false;
	if (argument_count > 5)
		immediate_skip = argument[5];
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
			// Pack string data
			var strings_array = array_create(ds_list_size(sub_list[| j][? "data"]));
			for (var k = 0; k < ds_list_size(sub_list[| j][? "data"]); k++)
				strings_array[k] = sub_list[| j][? "data"][| k];
			
			var autoscroll = sub_list[| j][? "autoscroll"];		// Pack autoscroll
			
			// Pack questgiver
			var questgiver_name = sub_list[| j][? "questgiver"];
			var questgiver = variable_struct_get(global.questgivers, is_undefined(questgiver_name) ? "" : questgiver_name);
			
			var trust_threshold = sub_list[| j][? "trust_threshold"];	// Pack trust threshold

			// Pack Quest (if "quest" is defined "text" and "questgiver" are required, cannot be undefined).
			var quest_dict = sub_list[| j][? "quest"];
			var quest = undefined;
			if (!is_undefined(quest_dict)) {
				var quest_questgiver = variable_struct_get(global.questgivers, quest_dict[? "questgiver"]);
				var quest_type_name = quest_dict[? "type"];
				var quest_type = undefined;
				if (!is_undefined(quest_type_name))
					quest_type = variable_struct_get(global.quest_types, quest_type_name);
				
				var quest_parameter = quest_dict[? "param"];
				
				var quest = new Quest(quest_dict[? "text"], quest_questgiver);
				if (!is_undefined(quest_type) && quest_type != Quest)
					quest = new quest_type(quest_dict[? "text"], quest_questgiver, quest_parameter);
			}
			
			// Pack immediate skip
			var immediate_skip = sub_list[| j][? "immediate_skip"];
			
			// Pack everything in a DialogData instance
			sub_array[j] = new DialogData(strings_array, is_undefined(autoscroll) ? false : autoscroll, questgiver,
				is_undefined(trust_threshold) ? 0 : trust_threshold, quest,
				is_undefined(immediate_skip) ? false : immediate_skip);
		}
		
		dialog_data[? start_key] = sub_array;
		
		start_key = ds_map_find_next(file_dict, start_key);
	}
	global.dialog_data = dialog_data;
	
	// Cleanup
	ds_map_destroy(file_dict);
}

// Start a dialog by sliding in the correct QuestGiver, deploying the Quest
// and finally sliding out the QuestGiver (if required).
function dialog_start_ext(dialog_data) {
	var action_time = 60;
	if (argument_count > 1)
		action_time = argument[1];
	
	var inst = instance_create_layer(0, 0, "instances", obj_dialog_manager_ext);
	inst.dialog_data = dialog_data;
	inst.action_time = action_time;
}
