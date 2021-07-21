global.checksum_lang_files = ["dialog.json", "local.json"];
global.checksum_root_files = ["lang.json"];

// Manually added directory instead of the automatic global.languages because
// we don't want to import languages before verifying checksums, and this way
// is simply easier.
global.checksum_directories = ["en", "it"];

#macro CHECKSUM_FILE "checksum.ini"
#macro CHECKSUM_SECRET undefined

// Open and verify the hash for the given files (with a secret)
// Hashes are computed in sha1
// Return true if all the hashes correspond, false otherwise.
// If the secret is undefined, always return true (used in debug).
function checksum_verify_all() {
	if (is_undefined(CHECKSUM_SECRET))
		return true;
	
	// Verify checksums for root files
	var ret = true;
	ini_open(CHECKSUM_FILE);
	for (var i = 0; i < array_length(global.checksum_root_files); i++) {
		var filename = global.checksum_root_files[i];
		var stored_hash = ini_read_string("checksum", filename, "");
		ret = ret && checksum_verify(filename, stored_hash, CHECKSUM_SECRET);
	}
	ini_close();

	// Verify checksums for localized files
	for (var i = 0; i < array_length(global.checksum_directories); i++) {
		var lang = global.checksum_directories[i];
		ini_open(string_path_join(lang, CHECKSUM_FILE));
		log("cur lang", lang);
		for (var k = 0; k < array_length(global.checksum_lang_files); k++) {
			var filename = string_path_join(lang, global.checksum_lang_files[k]);
			var stored_hash = ini_read_string("checksum", global.checksum_lang_files[k], "");
			ret = ret && checksum_verify(filename, stored_hash, CHECKSUM_SECRET);
		}

		ini_close();
	}	
	return ret;
}

// Open and verify hash for one given file, given a secret.
function checksum_verify(filename, hash, secret) {
	var file = file_text_open_read(filename);
	
	// Read content
	var file_content = "";
	while (!file_text_eof(file))
		file_content += file_text_readln(file);
	var calc_hash = sha1_string_utf8(file_content + secret);
	log("hash", filename, calc_hash);
	log("expected", hash);

	file_text_close(file);

	return string_upper(calc_hash) == string_upper(hash)		// Verify checksum
}
