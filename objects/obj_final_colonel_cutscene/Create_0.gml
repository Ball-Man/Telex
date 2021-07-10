// Door open
door_open_speed = 0.2;
xoffset = 0;
max_xoffset = 70;

// Door creation
door_speed = 0.2;
door_width = 0;
max_door_width = 70;

enum FINAL_COLONEL_STATE {
	DOOR,
	IDLE,
	OPEN_DOOR
}

state = FINAL_COLONEL_STATE.DOOR;
