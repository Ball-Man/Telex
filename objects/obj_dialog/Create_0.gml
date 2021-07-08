cur_string = "";
if (!is_undefined(global.current_dialog))
	cur_string = global.current_dialog.next_string();

// Reproduce the voice of the npc (once), if given. Silence otherwise
play_voice = function() {
	if (!is_undefined(global.current_dialog.data.questgiver))
		audio_play_sound(global.current_dialog.data.questgiver.voice, 0, false);
}

play_voice();
