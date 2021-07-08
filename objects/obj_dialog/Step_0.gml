/// @description Handle user input

if (keyboard_check_array_pressed(global.key_dialog)) {
	log("dialog input");
	
	if (!is_undefined(global.current_dialog)) {
		if (global.current_dialog.is_over()) {
			dialog_end();
			exit;
		}
		cur_string = global.current_dialog.next_string();
	}
	
	play_voice();
}
