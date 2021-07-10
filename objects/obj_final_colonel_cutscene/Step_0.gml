/// @description State machine
switch (state) {
	
	// Create door
	case FINAL_COLONEL_STATE.DOOR:
		if (door_width < max_door_width)
			door_width = min(door_width + door_speed, max_door_width);
		else {
			state = FINAL_COLONEL_STATE.IDLE;
			alarm_set(0, 180);
		}
		break;
		
	// Slide doors
	case FINAL_COLONEL_STATE.OPEN_DOOR:
		if (xoffset < max_xoffset)
			xoffset = min(xoffset + door_open_speed, max_xoffset);
		else {
			state = FINAL_COLONEL_STATE.IDLE;
			alarm_set(1, 120);
		}
		break;
}
