function dialog_tests() {
	normal_dialog_tests();
	empty_dialog_tests();
}

function normal_dialog_tests() {
	var strings = ["hello", "world", "amigo"];
	var data = new DialogData(strings);
	var dialog = new Dialog(data);
	
	var i = 0;
	while (!dialog.is_over())
		assert(dialog.next_string() == strings[i++]);
	
	assert(dialog.next_string() == strings[array_length(strings) - 1]);
}

function empty_dialog_tests() {
	var dialog = new Dialog(new DialogData([]));
	
	assert(dialog.is_over())
	assert(dialog.next_string() == "");
	assert(dialog.next_string() == "");
	assert(dialog.is_over())
}
