/// @description Remove from the global list and recalculate depths
var index = ds_list_find_index(global.draggables, id);
if (index != -1)
	ds_list_delete(global.draggables, index);	// Remove itself	
draggables_calculate_depth();
