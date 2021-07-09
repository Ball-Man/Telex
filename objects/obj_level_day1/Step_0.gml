/// @description State machine
switch (state) {
	case LEVEL_STATE.DIALOG:
		if (!instance_exists(obj_dialog_manager_ext))
			if (counter + 1 < array_length(dialogs) && dialogs[counter + 1].immediate_skip
				&& dialogs[counter + 1].questgiver.trust_level >= dialogs[counter + 1].trust_threshold) {
				if (next_dialog())
					dialog_start_ext(dialogs[counter]);
			}
		else
			state = LEVEL_STATE.IDLE;
		break;
}
