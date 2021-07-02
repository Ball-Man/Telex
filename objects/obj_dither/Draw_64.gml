shader_set(sh_dither);

shader_set_uniform_f_array(uniform_viewport, viewport);
shader_set_uniform_f_array(uniform_uv_pos, [application_surface_uvs[0], application_surface_uvs[1]]);
shader_set_uniform_f_array(uniform_uv_size, [application_surface_uvs[2] - application_surface_uvs[0],
											 application_surface_uvs[3] - application_surface_uvs[1]]);
draw_surface(application_surface, camera_get_view_x(view_camera), camera_get_view_y(view_camera));

shader_reset();
