function string_tests() {
	// Test string_sanitize
	var strings = ["hello world", "hello world&", "&hello world", "!h!e!l!l!o! !W!o!R!l!D!!!!", "hello\n world"];
	var result = "HELLO WORLD";

	for (var i = 0; i < array_length(strings); i++)
		assert(string_sanitize(strings[i]) == result);
}
