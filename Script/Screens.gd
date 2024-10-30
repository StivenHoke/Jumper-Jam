extends CanvasLayer

@onready var consolelog=$Debug/ConsoleLog

@onready var titlescreen=$TitleScreen
@onready var pausescreen=$ScreenPause
@onready var ggscreen=$GameOver

var current_screen=null

func _ready():
	consolelog.visible=false
	change_screen(titlescreen)
func _process(_delta):

	register_buttons()
#Screens.gd:17 @ register_buttons(): Signal 'clicked' is already connected to given callable 'CanvasLayer(Screens.gd)::on_button_pressed' in that object.
func register_buttons():
	var buttons=get_tree().get_nodes_in_group("buttons")
	if buttons.size()>0:
		for button in buttons:
			if button is ScreenButton:
				if button.clicked.is_connected(on_button_pressed):
					button.clicked.disconnect(on_button_pressed)
				button.clicked.connect(on_button_pressed)


func on_button_pressed(button):
	match button.name:
		"StartButton":
			change_screen(null)
			print("start")
		"RestartButton":
			change_screen(titlescreen)
			print("restart")
		"MenuButton":
			change_screen(ggscreen)
			print("Menu")
		"GV_Menu":
			change_screen(titlescreen)
			print("GB_menu")
		"GV_Retry":
			change_screen(pausescreen)
			print("retury")
		"CloseButton":
			change_screen(ggscreen)
			print("close")
	
func _on_toggle_console_pressed():
	consolelog.visible=!consolelog.visible

func change_screen(newscreen):
	if current_screen!=null:
		var disappear_tween=current_screen.disappear()
		await (disappear_tween.finished)
		current_screen.visible=false
	current_screen=newscreen
	if current_screen!=null:
		var tween=current_screen.appear()
		await(tween.finished)
		get_tree().call_group("buttons","set_disabled",false)
