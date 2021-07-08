switch (state) {
	// Wait time before actually doing the job
	case DIALOG_MANAGER_STATE.STARTING:
		counter++;
		if (counter >= action_time) {
			counter = 0;
			if (!is_undefined(dialog_data.questgiver)) {
				dialog_data.questgiver.slide_in();
				state = DIALOG_MANAGER_STATE.SLIDING_IN;
				return;
			}
			else
				state = DIALOG_MANAGER_STATE.DIALOG;
		}
		break;
	
	case DIALOG_MANAGER_STATE.SLIDING_IN:
		// If the sliding operation ended, start the dialog
		if (dialog_data.questgiver.instance.state == QUESTGIVER_STATE.IDLE) {
			alarm_set(0, 60);
			state = DIALOG_MANAGER_STATE.IDLE;
		}
			
		break;
	
	// Part of the code for state DIALOG can be found in the Room Start event
	// Room Start will be triggered upon returnal from a dialog
	case DIALOG_MANAGER_STATE.DIALOG:
		dialog_start(dialog_data);
		break;
		
	case DIALOG_MANAGER_STATE.SLIDING_OUT:
		// If the sliding operation ended, end this sequence
		if (is_undefined(dialog_data.questgiver.instance))
			state = DIALOG_MANAGER_STATE.END;
		break;
		
	case DIALOG_MANAGER_STATE.DELIVER_QUEST:
		// Update the current target with the given Quest
		global.target[array_length(global.target)] = dialog_data.quest;
		generate_note(dialog_data.quest);
		obj_main.enable(true);
		audio_play_sound(snd_note, 0, false);
		
		// Slide out or end based on what the data requires
		if (!is_undefined(dialog_data.questgiver)) {
			// Idle for a while and then slide out
			alarm_set(2, 60);
			state = DIALOG_MANAGER_STATE.IDLE;
		}
		else
			state = DIALOG_MANAGER_STATE.END;
		
		break;
		
		
	case DIALOG_MANAGER_STATE.END:
		// If no quest is given, automatically satisfy
		if (is_undefined(dialog_data.quest))
			obj_level.quest_satisfied(undefined);
		instance_destroy();
		break;
		
	// The IDLE state has no behaviour since it is used as literal idle
	// time, usually waiting for an alarm to trigger and change to the correct
	// state.
}