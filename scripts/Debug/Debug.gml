/// @function log([...])
/// @description Log the arguments to the console.
function log()
{
	var str = "";
	for(var i = 0; i< argument_count; i++)
	    str += string(argument[i]) + "  ";
 
	show_debug_message(str);
}
