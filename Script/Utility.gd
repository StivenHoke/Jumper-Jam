extends Node

func add_message_log(log_str:String):
	var console=get_tree().get_first_node_in_group("debug_console")
	if console:
		var lableconsole=console.find_child("LogLabel")
		if lableconsole:
#			if !lableconsole.text.is_empty():
#				lableconsole.text="\n"
			lableconsole.text +=log_str+"\n";
