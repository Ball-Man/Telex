/// @description Basic quest flow without animations

// Inherit the parent event
event_inherited();

strings = ["hello world", "I like it", "give me more"];
counter = 0;

init_level = function() {
	global.target = [new Quest(strings[counter], global.general)];
	obj_main.enable(true);
}

quest_satisfied = function(quest) {
	obj_main.enable(true);
	
	counter++;
	if (counter >= array_length(strings)) {
		game_end();
		return;
	}
	
	global.target = [new Quest(strings[counter], global.general)];
}

init_level();
