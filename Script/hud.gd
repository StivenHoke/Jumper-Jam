extends Control

@onready var topbar=$TopBar
@onready var topbar_bk=$TopBarBK

func _ready():
	var os_name=OS.get_name()
	if os_name=="iOS"||"Android":
		var safe_area=DisplayServer.get_display_safe_area()
		var safe_area_top=safe_area.position.y
		
		var screen_scale=DisplayServer.screen_get_scale()
		safe_area_top=(safe_area_top/screen_scale)
		
		topbar.position.y+=safe_area_top
		topbar_bk.size.y+=(safe_area_top+10)
		
		MyUtility.add_message_log("screen-scale "+str(screen_scale))
		MyUtility.add_message_log("safe_area "+str(safe_area))
		MyUtility.add_message_log("window_size "+str(DisplayServer.window_get_size()))
		MyUtility.add_message_log("safe_area_top "+str(safe_area_top))
		MyUtility.add_message_log("top bar pos "+str(topbar.position))

func _on_pause_button_pressed():
	pass # Replace with function body.
