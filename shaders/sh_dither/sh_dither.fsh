//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
vec3 palette[3];
int offset[3];
uniform vec2 uv_size;
uniform vec2 uv_pos;
uniform vec2 viewport;

void main()
{
	palette[0] = vec3(14. / 255., 14. / 255., 14. / 255.);
	palette[1] = vec3(42. /255., 42. /255., 42. /255.);
	palette[2] = vec3(84. /255., 84. /255., 84. /255.);
	
	offset[0] = 16;
	offset[1] = 4;
	offset[2] = 2;

	vec2 actual_coords = (v_vTexcoord - uv_pos) / uv_size * viewport;

	for (int i = 0; i < 3; i++)
		if ((v_vColour * texture2D( gm_BaseTexture, v_vTexcoord )).rgb == palette[i])
			if (all(lessThan(mod(actual_coords, vec2(offset[i])), vec2(1))))
				gl_FragColor = vec4(1);
			else
				gl_FragColor = vec4(0., 0., 0., 1.);
	
}
