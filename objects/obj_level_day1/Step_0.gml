/// @description State machine
switch (state) {
	case LEVEL_STATE.DIALOG:
		if (!instance_exists(obj_dialog_manager_ext))
			if (dialogs[counter].immediate_skip) {
				counter++;
				dialog_start_ext(dialogs[counter]);
			}
		else
			state = LEVEL_STATE.IDLE;
		break;
}
