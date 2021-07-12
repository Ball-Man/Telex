// Define main globals for the game

// String to type. It's a vector of Quests, once the player
// completes one of the contained ones, a new set of quests
// will be generated.
global.target = [];

// The two main NPCs
global.general = new QuestGiver(spr_general, "general", fnt_general, snd_general_voice);
global.colonel = new QuestGiver(spr_colonel, "colonel", fnt_colonel, snd_colonel_voice);

global.questgivers = {
	general: global.general,
	colonel: global.colonel
}

global.questgiver_fonts = {
	general: fnt_general,
	colonel: fnt_colonel
}

global.questgiver_voices = {
	general: snd_general_voice,
	colonel: snd_colonel_voice
}

// Map of subtypes
global.quest_types = {
	def: Quest,
	caeser: CaeserQuest,
	subs: SubstitutionQuest
}

// Levels of the game (excluding the last one, which is a special case)
global.days = [rm_level_day1, rm_level_day2, rm_level_day3, rm_level_day4];
global.current_day_index = -1;
global.is_last_day = false;

// Number of errors from the player
global.errors = 0;
global.max_errors = 5;		// At 5, it's game over

// Palette
#macro LIGHT_GRAY $545454
#macro GRAY $2a2a2a
#macro DARK_GRAY $0e0e0e

global.localizer = localizer_load("local.json");

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
	
	note_font = fnt_general;
	if (argument_count > 2)
		note_font = argument[2];
		
	voice = snd_general_voice;
	if (argument_count > 3)
		voice = argument[3];
	
	instance = undefined;
	
	_day_trust = 0;
	
	static gain_trust = function() {
		trust_level++;
		_day_trust++;
	}
	
	// Create an instance of the QuestGiver and slide it on the screen
	static slide_in = function() {
		if (is_undefined(instance)) {
			instance = instance_create_layer(room_width, 0, "npcs", obj_questgiver);
			
			if (!is_undefined(sprite))
				instance.sprite_index = sprite;
			instance.quest_giver = self;
			
			instance.state = QUESTGIVER_STATE.SLIDING_IN;
			
			audio_play_sound(snd_step1, 0, false);
		}
	}
	
	// Slide the current existing instance of the QuestGiver out of the screen, and destroy it
	static slide_out = function() {
		if (is_undefined(instance))
			return;
		
		instance.state = QUESTGIVER_STATE.SLIDING_OUT;
		audio_play_sound(snd_step2, 0, false);
	}
	
	// Reset trust gained in the current day and remove it from current trust (after game over, the day restarts)
	static lose_day = function() {
		trust_level -= _day_trust;
		reset_day();
	}
	
	// Reset trust for the day, preparing for the next
	static reset_day = function() {
		_day_trust = 0;
	}
}

enum QUEST_STATUS {
	SATISFIED,
	UNSATISFIED,
	ERROR
}

// A text to be typed on the teleprinter.
function Quest(text_, quest_giver_) constructor {
	text = text_;
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
		if (string_copy(string_upper(text), 1, string_length(typed_text)) != typed_text)
			return QUEST_STATUS.ERROR;
		
		// Check for satisfaction
		if (string_length(text) == string_length(typed_text)) {
			quest_giver.gain_trust();
			return QUEST_STATUS.SATISFIED;
		}
		
		return QUEST_STATUS.UNSATISFIED;
	}
	
	// Retrieve the text to be shown on the note
	static get_note_text = function() {
		return text;
	}
}

// A note encrypted with the Caeser Cypher (generalized with an offset).
function CaeserQuest(text_, quest_giver_, offset_) : Quest(text_, quest_giver_) constructor {
	offset = offset_;
	
	// Retrieve the text (crypted) to be shown on the note
	static get_note_text = function() {
		var cyphertext = "";
		
		for (var i = 1; i <= string_length(text); i++) {
			var byte = string_byte_at(text, i);
			if (byte >= ord("a") && byte <= ord("z")) {
				cyphertext += chr(ord("a") + (byte - ord("a") + offset) % (ord("z") - ord("a") + 1));
			}
			else if (byte >= ord("A") && byte <= ord("Z")) {
				cyphertext += chr(ord("A") + (byte - ord("A") + offset) % (ord("Z") - ord("A") + 1));
			}
			else
				cyphertext += chr(byte);
		}
		
		return cyphertext;
	}
}

// A note encrypted by letter substitution
// "letters" is a comma separated string, representing a list of letters (no spaces allowed).
// Each pair of letters (index 0 and 1, index 2 and 3, etc.) will be treated as a substitution
// pair in the final string.
function SubstitutionQuest(text_, quest_giver_, letters_): Quest(text_, quest_giver_) constructor {
	var letters_array = string_split(string_lower(letters_), ",");
	
	// Sanity check
	if (array_length(letters_array) % 2 != 0)
		show_error("In SubstitutionQuest the given array of letters should be of even length.", false);
	
	// Create substitution map
	letters = ds_map_create();
	
	for (var i = 0; i < array_length(letters_array); i++) {
		var from = letters_array[i];
		if (i % 2)
			var to = letters_array[i - 1]
		else
			var to = letters_array[i + 1];
		
		// Hardcode both upper and lowercase letters
		// This could be solved using offsets instead, but who cares really
		letters[? from] = to;
		letters[? string_upper(from)] = string_upper(to);
	}
	
	// Retrieve the text (substituted) to be shown on the note
	static get_note_text = function() {
		var cyphertext = "";
		for (var i = 1; i <= string_length(text); i++) {
			var char = string_char_at(text, i);
			var subst = letters[? char];
			cyphertext += is_undefined(subst) ? char : subst;
		}
		
		return cyphertext;
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

// Go to the next day of the game
function next_day() {
	if (global.is_last_day) {
		game_final();
		return;
	}
	
	// Reset draggable objects
	ds_list_clear(global.draggables);
	
	// Reset mistakes
	global.errors = 0;
	
	// Reset NPCs
	global.colonel.reset_day();
	global.general.reset_day();
	
	global.current_day_index++;
	if (global.current_day_index >= array_length(global.days)) {
		// Select last day
		global.is_last_day = true;
		if (global.general.trust_level >= 8)
			room_goto(rm_level_day5_general);
		else if (global.colonel.trust_level >= 5)
			room_goto(rm_level_day5_colonel);
		return;
	}
	
	room_goto(global.days[global.current_day_index]);
}

// Go to the appropriate final room
function game_final() {
	if (room == rm_level_day5_general)
		room_goto(rm_level_final_general);
	else if (room == rm_level_day5_colonel)
		room_goto(rm_level_final_colonel);
}

// Lose game and restart day
function game_over() {
	obj_main.enable(false);		// Disable writing
	
	if (is_undefined(obj_main.game_over_dialog))
		obj_main.game_over_dialog = dialog_start_ext(global.dialog_data[? "game_over"][0]);
	else if (!instance_exists(obj_main.game_over_dialog)) {
		ds_list_clear(global.draggables);		// Reset draggables
		global.errors = 0;						// Reset mistakes
		
		// Reset NPCs
		global.colonel.lose_day();
		global.general.lose_day();
		
		room_restart();
	}
}

// End the game and go to the credits room
function game_credits() {
	// Stop all sounds (eg. the explosion from the general)
	audio_stop_all();
	
	room_goto(rm_endgame_credits);
}
