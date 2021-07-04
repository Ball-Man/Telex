function string_tests() {
	sanitize_tests();
	split_tests();
}

function sanitize_tests() {
	// Test string_sanitize
	var strings = ["hello world", "hello world&", "&hello world", "!h!e!l!l!o! !W!o!R!l!D!!!!", "hello\n world"];
	var result = "HELLO WORLD";

	for (var i = 0; i < array_length(strings); i++)
		assert(string_sanitize(strings[i]) == result);
}

function split_tests() {
	var str1 = "";
	var str2 = "test this";
	
	assert(string_split(str1, ",")[0] == "");
	assert(string_split(str2, " ")[0] == "test");
	assert(string_split(str2, " ")[1] == "this");
	assert(string_split(str2, ",")[0] == "test this");
}
