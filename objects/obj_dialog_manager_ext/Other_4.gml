/// @description Manage state upon returnal from dialog
if (state == DIALOG_MANAGER_STATE.DIALOG) {
	// If a quest is given, deliver it. Slide out or end otherwise.
	if (!is_undefined(dialog_data.quest)) {
		// Idle for a while and then deliver the quest
		alarm_set(1, 60);
		state = DIALOG_MANAGER_STATE.IDLE;
	}
	else if (!is_undefined(dialog_data.questgiver)) {
		// Idle for a while and then slide out
		alarm_set(2, 60);
		state = DIALOG_MANAGER_STATE.IDLE;
	}
	else
		state = DIALOG_MANAGER_STATE.END;
}
