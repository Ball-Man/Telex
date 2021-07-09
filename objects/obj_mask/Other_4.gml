if (state == MASK_STATE.CREATED)
	state = MASK_STATE.ACK;
else if (state == MASK_STATE.ACK)
	instance_destroy();
