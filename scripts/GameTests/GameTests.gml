function game_tests() {
	quest = new Quest("hello world", new QuestGiver());
	
	// Try failing
	assert(quest.satisfy("g") == QUEST_STATUS.ERROR);
	assert(quest.satisfy("hello worlg") == QUEST_STATUS.ERROR);
	assert(quest.satisfy("hello worlg ddddd") == QUEST_STATUS.ERROR);
	assert(quest.satisfy("ddd hello world") == QUEST_STATUS.ERROR);
	assert(quest.satisfy("hello worl ") == QUEST_STATUS.ERROR);
	
	// Try succeeding
	assert(quest.satisfy("hello world") == QUEST_STATUS.SATISFIED);
	assert(quest.satisfy("hello world ddd") == QUEST_STATUS.SATISFIED);
	
	assert(quest.quest_giver.trust_level == 2);
	
	// Try unsatisfying
	assert(quest.satisfy("") == QUEST_STATUS.UNSATISFIED);
	assert(quest.satisfy("h") == QUEST_STATUS.UNSATISFIED);
	assert(quest.satisfy("hello worl") == QUEST_STATUS.UNSATISFIED);
}
