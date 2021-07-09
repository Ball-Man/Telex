/// @description State machine
switch (state) {
	case BOMB_STATE.LAUNCHED:
		if (!audio_is_playing(launch)) {
			state = BOMB_STATE.EXPLOSION;
			audio_play_sound(snd_explosion, 0, false);
			alarm_set(0, 60);
		}
		break;
	
	// Tilt camera
	case BOMB_STATE.EXPLOSION:
		camera_set_view_pos(view_camera, camera_x + irandom_range(-htilt, htilt), camera_y + irandom_range(-vtilt, vtilt));
		break;
}
