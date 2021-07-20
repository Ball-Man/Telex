/// @description Draw current language
draw_self();

draw_set_font(fnt_cur_language);
draw_set_valign(fa_bottom);

draw_text(x + sprite_width + 10, y + sprite_height, localizer_get(global.localizer, "cur_language") + ": " + global.languages[global.dialog_language_index]);

draw_set_valign(fa_top);
