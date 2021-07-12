/// @description Draw credits
// Draw text
draw_set_font(fnt_dialog);
draw_set_halign(fa_center);
draw_set_color(c_white);

var localized_text = localizer_get(global.localizer, credits[index]);
var credit_height = string_height(localized_text)

var pos_y = text_pos.pos_y;
if (text_pos.pos_y + credit_height > room_height)
	pos_y = 50

draw_text(text_pos.pos_x, pos_y, localized_text);


var logo_pos_y = pos_y + credit_height + 20;

draw_set_halign(fa_left);

// Draw 1bit jam logo when appropriate
if (index == 0)
	draw_sprite(spr_1bit_logo, 0, text_pos.pos_x, logo_pos_y);
