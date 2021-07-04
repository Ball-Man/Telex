// Reposition paper
var last_line = lines[array_length(lines) - 1];
x = lerp(original_x, original_x - 35, string_width(last_line) / max_width);
