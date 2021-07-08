/// @description Day one quest flow

// Inherit the parent event
event_inherited();

dialogs = global.dialog_data[? "day1"];
counter = 0;

enum LEVEL_STATE {
	IDLE,
	DIALOG
}

state = LEVEL_STATE.IDLE;

init_level = function() {
	log("starting quest", dialogs[0]);
	dialog_start_ext(dialogs[0], 0);
	obj_main.enable(true);
}

// Simply go on to the next quest
quest_satisfied = function(quest) {
	obj_main.enable(true);
	
	counter++;
	if (counter >= array_length(dialogs)) {
		game_end();
		return;
	}
	
	// Reset current quests
	global.target = [];
	
	// Start new dialog
	dialog_start_ext(dialogs[counter]);
	
	state = LEVEL_STATE.DIALOG;
}

init_level();
