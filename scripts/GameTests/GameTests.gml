function game_tests() {
	quest_tests();
	results_tests();
}

function quest_tests() {
	var quest = new Quest("hello world", new QuestGiver());
	
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

function results_tests() {
	var results_error = [QUEST_STATUS.ERROR, QUEST_STATUS.ERROR, QUEST_STATUS.ERROR];
	var results_unsatisfied1 = [QUEST_STATUS.ERROR, QUEST_STATUS.UNSATISFIED, QUEST_STATUS.ERROR];
	var results_unsatisfied2 = [QUEST_STATUS.UNSATISFIED, QUEST_STATUS.ERROR];
	var results_satisfied1 = [QUEST_STATUS.ERROR, QUEST_STATUS.SATISFIED];
	var results_satisfied2 = [QUEST_STATUS.SATISFIED, QUEST_STATUS.ERROR];
	var results_satisfied3 = [QUEST_STATUS.SATISFIED, QUEST_STATUS.UNSATISFIED];
	var results_satisfied4 = [QUEST_STATUS.UNSATISFIED, QUEST_STATUS.SATISFIED];
	
	assert (check_results(results_error).result == QUEST_STATUS.ERROR);
	assert (check_results(results_unsatisfied1).result == QUEST_STATUS.UNSATISFIED);
	assert (check_results(results_unsatisfied2).result == QUEST_STATUS.UNSATISFIED);
	
	assert (check_results(results_satisfied1).result == QUEST_STATUS.SATISFIED);
	assert (check_results(results_satisfied1).index == 1);
	
	assert (check_results(results_satisfied2).result == QUEST_STATUS.SATISFIED);
	assert (check_results(results_satisfied2).index == 0);
	
	assert (check_results(results_satisfied3).result == QUEST_STATUS.SATISFIED);
	assert (check_results(results_satisfied3).index == 0);
	
	assert (check_results(results_satisfied4).result == QUEST_STATUS.SATISFIED);
	assert (check_results(results_satisfied4).index == 1);	
}
