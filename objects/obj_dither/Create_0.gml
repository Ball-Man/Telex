uniform_uv_pos = shader_get_uniform(sh_dither, "uv_pos");
uniform_uv_size = shader_get_uniform(sh_dither, "uv_size");
uniform_viewport = shader_get_uniform(sh_dither, "viewport");

application_surface_uvs = texture_get_uvs(surface_get_texture(application_surface));
viewport = [view_get_wport(view_camera), view_get_hport(view_camera)]

log("uvs", application_surface_uvs);
log("viewport", viewport);

window_set_size(960, 540);
//window_set_fullscreen(true);