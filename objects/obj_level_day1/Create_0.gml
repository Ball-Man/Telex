/// @description Day one quest flow

// Inherit the parent event
event_inherited();

init_level = function() {
	log("starting quest", global.dialog_data[? "day1"][0]);
	dialog_start_ext(global.dialog_data[? "day1"][0]);
	obj_main.enable(true);
}

quest_satisfied = function(quest) {

}

init_level();
