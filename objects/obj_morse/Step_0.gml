/// @description Insert description here
// You can write your code in this editor

switch (state) {
	case MORSE_STATE.PLAYING:
		if (cur_sound != -1 && !audio_is_playing(cur_sound)) {
			alarm_set(0, dit_time);
			state = MORSE_STATE.IDLE;
		}
		break;
		
	case MORSE_STATE.POLL:
		if (!ds_queue_empty(global.morse_queue))
			play();
		break;
		
}
