#macro LANGUAGE_FILE "lang.json"

// The array of supported languages ["lang1", "lang2", "lang3", ...]
global.languages = undefined;

// Import available languages from LANGUAGE_FILE.
// Populating global.languages.
function import_language_file() {
	var file = file_text_open_read(LANGUAGE_FILE);
	
	// Read all content
	var json_content = "";
	while (!file_text_eof(file))
		json_content += file_text_readln(file);
	file_text_close(file);
	
	global.languages = json_parse(json_content);
}
