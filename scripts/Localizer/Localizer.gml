/// localizer_load(filename)
/// @desc Load localizer data from a json dictionary(return its id).
/// @param filename The js file containing the dictionary
function localizer_load(argument0) {
  var filename = argument0;

  if (!file_exists(filename))
    return ds_map_create();

  var file = file_text_open_read(filename);

  var json = "";
  while (!file_text_eof(file)) {
    json += file_text_read_string(file);
    file_text_readln(file);
  }

  file_text_close(file);

  return json_decode(json);;
}

/// localizer_destroy(localizer_id)
/// @desc Destroy a localizer data structure, freeing memory.
/// @param localizer_id The id of the designed localizer
function localizer_destroy(argument0) {
  var localizer_id = argument0;

  ds_map_destroy(localizer_id);
}

/// localizer_get(localizer_id, string)
/// @desc Get the localized string(if exists). Return string if there is no localization.
/// @param localizer_id The id of the localizer providing the localization
/// @param string The string to be localized
function localizer_get(argument0, argument1) {
  var localizer_id = argument0;
  var str = argument1;

  var ret = ds_map_find_value(localizer_id, str);
  if (is_undefined(ret))
    ret = str;

  return ret;
}
