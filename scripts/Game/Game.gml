// Define main globals for the game

// String to type. It's a vector of Quests, once the player
// completes one of the contained ones, a new set of quests
// will be generated.
global.target = "";

// The two main NPCs
global.general = new QuestGiver();
global.colonel =new QuestGiver();

// NPCs giving quests in the game
// In the original idea, there are two of them
function QuestGiver() constructor {
	trust_level = 0;
	
	static gain_trust = function() {
		trust_level++;
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
