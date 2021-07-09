/// @description State machine
switch (state) {
	case LEVEL_STATE.DIALOG:
		if (!instance_exists(obj_dialog_manager_ext))
			if (counter < array_length(dialogs) && dialogs[counter].immediate_skip) {
				if (next_dialog())
					dialog_start_ext(dialogs[counter]);
			}
		else
			state = LEVEL_STATE.IDLE;
		break;
}
