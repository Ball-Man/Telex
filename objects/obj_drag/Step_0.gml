/// @description Drag logic

// If no item is being dragged
if (is_undefined(dragged_item.instance)) {
	// On click, start dragging an item
	if (mouse_check_button_pressed(mb_left)) {
		instances = ds_list_create();
		collision_point_list(mouse_x, mouse_y, obj_draggable, false, true, instances, false);
		if (!ds_list_empty(instances)) {
			// Find the colliding instance with the lowest depth (the visible one should be dragged first)
			var dragged_instance = instances[| 0];
			for (var i = 1; i < ds_list_size(instances); i++)
				if (instances[| i].depth < dragged_instance.depth)
					dragged_instance = instances[| i];
			
			dragged_item.instance = dragged_instance;
			dragged_item.offset = [mouse_x - dragged_instance.x, mouse_y - dragged_instance.y]
			dragged_instance.swap_top();
			
			// If picked up while sliding, stop
			dragged_instance.sliding = false;
		}
		ds_list_destroy(instances);
	}
}
// If an item is being dragged
else {
	// Move the dragged item where the mouse is
	// Clamp the position inside the proper area (obj_note_area).
	dragged_item.instance.x = clamp(mouse_x - dragged_item.offset[0], obj_note_area.bbox_left, obj_note_area.bbox_right);
	dragged_item.instance.y = clamp(mouse_y - dragged_item.offset[1], obj_note_area.bbox_top, obj_note_area.bbox_bottom);
	
	log("dragging", dragged_item);
	
	// If the mouse is released, release the item
	if (mouse_check_button_released(mb_left)) {
		dragged_item.instance = undefined;
	}
}
