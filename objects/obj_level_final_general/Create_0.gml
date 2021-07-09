/// @description Start launch
launch = audio_play_sound(snd_launch, 0, false);

camera_x = camera_get_view_x(view_camera);
camera_y = camera_get_view_y(view_camera);

htilt = 9;
vtilt = 4;

enum BOMB_STATE {
	LAUNCHED,
	EXPLOSION,
	IDLE
}

state = BOMB_STATE.LAUNCHED;
