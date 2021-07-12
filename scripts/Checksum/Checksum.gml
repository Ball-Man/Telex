global.checksum_files = ["dialog.json", "local.json"];

#macro CHECKSUM_FILE "checksum.ini"
#macro CHECKSUM_SECRET undefined

// Open and verify the hash for the given files (with a secret)
// Hashes are computed in sha1
// Return true if all the hashes correspond, false otherwise.
// If the secret is undefined, always return true (used in debug).
function checksum_verify() {
	if (is_undefined(CHECKSUM_SECRET))
		return true;
	
	ini_open(CHECKSUM_FILE);

	// Calculate hashes and check
	var ret = true;
	for (var i = 0; i < array_length(global.checksum_files); i++) {
		// Read file and calculate hash
		var file = file_text_open_read(global.checksum_files[i]);
		var file_content = "";
		while (!file_text_eof(file))
			file_content += file_text_readln(file);
		var calc_hash = sha1_string_utf8(file_content + CHECKSUM_SECRET);
		log("hash", global.checksum_files[i], calc_hash);
		file_text_close(file);
		
		var stored_hash = ini_read_string("checksum", global.checksum_files[i], "");
	
		if (string_upper(calc_hash) != string_upper(stored_hash))		// Verify checksum
			ret = false;
	}
	
	ini_close();
	
	return ret;
}
