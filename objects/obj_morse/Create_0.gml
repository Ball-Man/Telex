enum MORSE_STATE {
	PLAYING,
	IDLE,
	POLL
}

state = MORSE_STATE.POLL;

cur_sound = -1;

play = function() {
	cur_sound = morse_pop()
	if (cur_sound != -1)
		state = MORSE_STATE.PLAYING;
	else
		state = MORSE_STATE.POLL;
}

dit_time = 5;
