/// @description Add the new draggable to the global list.

// Retrieve base depth
base_depth = get_draggable_depth();

// Based on the currently existing draggables, available in global.draggables
// set a proper depth.
// New draggables should come on top of the old ones
depth = base_depth - ds_list_size(global.draggables);
ds_list_add(global.draggables, id);

// Move to the top of the global list of draggables and become visible on top
// of others.
swap_top = function() {
	var index = ds_list_find_index(global.draggables, id);
	if (index != -1)
		ds_list_delete(global.draggables, index);	// Remove itself	
	ds_list_add(global.draggables, id);		// Re-add
	draggables_calculate_depth();
}
