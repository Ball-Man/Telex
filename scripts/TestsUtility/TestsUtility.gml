// If expression is true, return quietly. Otherwise, throw an error.
function assert(expression) {
	var err_message = "Assertion error.";
	if (argument_count > 1)
		err_message = argument[1];
	
	if (!expression) {
		show_error(err_message, false);
	}
}