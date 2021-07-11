/// @description Next title
index++;
if (index >= array_length(credits)) {
	game_end();
	return;
}

alarm_set(0, skip_time);
