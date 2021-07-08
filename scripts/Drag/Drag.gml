// A list/stack of draggables that will be used to manage their depth
global.draggables = ds_list_create();

// Return the base depth for draggables (from "notes" layer).
function get_draggable_depth() {
	return layer_get_depth(layer_get_id("notes"));
}

// Iter through the global list of draggables and calculate new depths for
// every item
function draggables_calculate_depth() {
	var base_depth = get_draggable_depth();
	for (var i = 0; i < ds_list_size(global.draggables); i++)
		global.draggables[| i].depth = base_depth - i;
}

// Spawn a note from the given Quest obect.
function generate_note(quest) {
	var note = instance_create_layer(obj_note_area.x, obj_note_area.y, "notes", obj_note);
	note.text = quest.text;
	note.font = variable_struct_get(global.questgiver_fonts, quest.quest_giver.name_);
	note.resize();
	
	return note;
}
