/// @description Drag logic

// If no item is being dragged
if (is_undefined(dragged_item.instance)) {
	// On click, start dragging an item
	if (mouse_check_button_pressed(mb_left)) {
		instances = ds_list_create();
		collision_point_list(mouse_x, mouse_y, obj_draggable, false, true, instances, true);
		if (!ds_list_empty(instances)) {
			var dragged_instance = instances[| 0];
			dragged_item.instance = dragged_instance;
			dragged_item.offset = [mouse_x - dragged_instance.x, mouse_y - dragged_instance.y]
		}
	}
}
// If an item is being dragged
else {
	// Move the dragged item where the mouse is
	dragged_item.instance.x = mouse_x - dragged_item.offset[0];
	dragged_item.instance.y = mouse_y - dragged_item.offset[1];
	
	log("dragging", dragged_item);
	
	// If the mouse is released, release the item
	if (mouse_check_button_released(mb_left))
		dragged_item.instance = undefined;
}
