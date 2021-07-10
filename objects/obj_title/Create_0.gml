morse_time = 200;

// Push TELEX in the morse queue
morse_telex = function() {
	morse_push("t");
	morse_push("e");
	morse_push("l");
	morse_push("e");
	morse_push("x");
}

// Start the morse cycle
morse_telex();
alarm_set(0, morse_time);
