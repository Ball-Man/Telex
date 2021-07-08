/// @description Sliding logic
if (sliding) {
	var x_stable = abs(x - target_x) < 0.01;
	if (!x_stable)
		x = lerp(x, target_x, 1 / 3);
	
	var y_stable = abs(y - target_y) < 0.01;
	if (!y_stable)
		y = lerp(y, target_y, 1 / 3);
		
	if (x_stable && y_stable) {
		sliding = false;
		x = target_x;
		y = target_y;
	}
}
