dialog_start_ext(global.dialog_data[? "final_colonel"][0]);

// Simply skip to the last room
quest_satisfied = function(quest) {
	room_goto(rm_final_colonel_cutscene);
}

