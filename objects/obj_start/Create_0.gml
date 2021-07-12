/// @description Import data from files
// Verify checksums
if (!checksum_verify()) {
	show_error("Failed checksum verification. Files have been altered.", true);
}

dialog_import();

log("dialog data size", ds_map_size(global.dialog_data));
var start_key = ds_map_find_first(global.dialog_data);
for (var i = 0; i < ds_map_size(global.dialog_data); i++) {
	log("imported dialog data", global.dialog_data[? start_key]);
	start_key = ds_map_find_next(global.dialog_data, start_key);
}
