// Define main globals for the game

// String to type. It's a vector of Quests, once the player
// completes one of the contained ones, a new set of quests
// will be generated.
global.target = [];

// The two main NPCs
global.general = new QuestGiver(spr_general, "general");
global.colonel = new QuestGiver(spr_colonel, "colonel");

global.questgivers = {
	general: global.general,
	colonel: global.colonel
}

global.questgiver_fonts = {
	general: fnt_general,
	colonel: fnt_colonel
}

// Number of errors from the player
global.errors = 0;

// Palette
#macro LIGHT_GRAY $545454
#macro GRAY $2a2a2a
#macro DARK_GRAY $0e0e0e

// NPCs giving quests in the game
// In the original idea, there are two of them
function QuestGiver() constructor {
	trust_level = 0;
	
	sprite = undefined;
	if (argument_count > 0)
		sprite = argument[0];
	
	name_ = "";
	if (argument_count > 1)
		name_ = argument[1];
	
	instance = undefined;
	
	static gain_trust = function() {
		trust_level++;
	}
	
	// Create an instance of the QuestGiver and slide it on the screen
	static slide_in = function() {
		if (is_undefined(instance)) {
			instance = instance_create_layer(room_width, 0, "npcs", obj_questgiver);
			
			if (!is_undefined(sprite))
				instance.sprite_index = sprite;
			instance.quest_giver = self;
			
			instance.state = QUESTGIVER_STATE.SLIDING_IN;
		}
	}
	
	// Slide the current existing instance of the QuestGiver out of the screen, and destroy it
	static slide_out = function() {
		if (is_undefined(instance))
			return;
		
		instance.state = QUESTGIVER_STATE.SLIDING_OUT;
	}
}

enum QUEST_STATUS {
	SATISFIED,
	UNSATISFIED,
	ERROR
}

// A text to be typed on the teleprinter.
function Quest(text_, quest_giver_) constructor {
	text = string_upper(text_);
	quest_giver = quest_giver_;
	
	// When a quest is satisfied, the registered QuestGiver's trust
	// will increase.
	// The return value is one of the three values of QUEST_STATUS:
	// If the player made an error in the typed_text, error is returned.
	// If the quest is good so far but not yet completetely satisfied, UNSATISFIED is returned
	// If the quest is perfectly satisfied, SATISFIED is returned.
	static satisfy = function(typed_text) {
		// Sanity check on typed text
		typed_text = string_upper(typed_text);
		if (string_length(typed_text) > string_length(text))
			typed_text = string_copy(typed_text, 1, string_length(text));
		
		// Check for errors
		if (string_copy(text, 1, string_length(typed_text)) != typed_text)
			return QUEST_STATUS.ERROR;
		
		// Check for satisfaction
		if (string_length(text) == string_length(typed_text)) {
			quest_giver.gain_trust();
			return QUEST_STATUS.SATISFIED;
		}
		
		return QUEST_STATUS.UNSATISFIED;
	}
}

// Return a struct containing data on an array of Quest results.
// The structure is as follows:
// { result: QUEST_STATUS, index: ... }
// The value for the 'result' field is one of the QUEST_STATUS enum values.
// ERRROR, if all the results are equal to ERROR. SATISFIED if at least one
// quest has been satisfied (ideally, only one). UNSATISFIED otherwise.
// The value of 'index' is set to the index of the satisfied quest. If no
// quest is satisfied, 'index' will be set to -1.
function check_results(results) {
	var in = -1;
	var re = QUEST_STATUS.ERROR;
	for (var i = 0; i < array_length(results); i++) {
		if (results[i] != QUEST_STATUS.ERROR && re == QUEST_STATUS.ERROR)
			re = QUEST_STATUS.UNSATISFIED
		if (results[i] == QUEST_STATUS.SATISFIED) {
			re = QUEST_STATUS.SATISFIED;
			in = i;
		}
		if (results[i] == QUEST_STATUS.UNSATISFIED && re != QUEST_STATUS.SATISFIED)
			re = QUEST_STATUS.UNSATISFIED;
		if (results[i] == QUEST_STATUS.ERROR && re != QUEST_STATUS.SATISFIED && re != QUEST_STATUS.ERROR)
			re = QUEST_STATUS.UNSATISFIED;
	}
	
	return {result: re, index: in};
}
