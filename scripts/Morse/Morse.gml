global.morse_queue = ds_queue_create();

global.morse_map = {
	A: [".", "-"],
	B: ["-", ".", ".", "."],
	C: ["-", ".", "-", "."],
	D: ["-", ".", "."],
	E: ["."],
	F: [".", ".", "-", "."],
	G: ["-", "-", "."],
	H: [".", ".", ".", "."],
	I: [".", "."],
	J: [".", "-", "-", "-"],
	K: ["-", ".", "-"],
	L: [".", "-", ".", "."],
	M: ["-", "-"],
	N: [".", "-"],
	O: ["-", "-", "-"],
	P: [".", "-", "-", "."],
	Q: ["-", "-", ".", "-"],
	R: [".", "-", "."],
	S: [".", ".", "."],
	T: ["-"],
	U: [".", ".", "-"],
	V: [".", ".", ".", "-"],
	W: [".", "-", "-"],
	X: ["-", ".", ".", "-"],
	Y: ["-", ".", "-", "-"],
	Z: ["-", "-", ".", "."]
}

global.morse_soundmap = ds_map_create(); 
global.morse_soundmap[? "."] = snd_morse_dit;
global.morse_soundmap[? "-"] = snd_morse_dah;
global.morse_soundmap[? " "] = snd_morse_space;

// Push a letter in the queue
function morse_push(char) {
	// Some hardcode for spaces
	if (char == " ") {
		ds_queue_enqueue(global.morse_queue, " ");
		return;
	}
	
	var morse_encoded = variable_struct_get(global.morse_map, string_upper(char));
	for (var i = 0; i < array_length(morse_encoded); i++)
		ds_queue_enqueue(global.morse_queue, morse_encoded[i]);
}

// Play one sound from the queue (and remove one item)
function morse_pop() {
	if (ds_queue_empty(global.morse_queue))
		return -1;

	var sym = ds_queue_dequeue(global.morse_queue);
	var sound = global.morse_soundmap[? sym];
	return audio_play_sound(sound, 0, false);
}
