dialog_data = undefined;

counter = 0;
action_time = 60;

enum DIALOG_MANAGER_STATE {
	STARTING,
	SLIDING_IN,
	SLIDING_OUT,
	DIALOG,
	DELIVER_QUEST,
	END,
	IDLE
}

state = DIALOG_MANAGER_STATE.STARTING;
