extends Node2D

@onready var Levelgenerator=$Levelgenerator
@onready var ground=$Ground
@onready var parallaxlayer=$ParallaxBackground/ParallaxLayer
@onready var parallaxlayer2=$ParallaxBackground/ParallaxLayer2
@onready var parallaxlayer3=$ParallaxBackground/ParallaxLayer3

var player_scene=preload("res://Scene/player.tscn")
var player:Player=null
var player_spawn_position:Vector2

var camera=null
var camera_player=preload("res://Scene/camera_player.tscn")

var viewport_size:Vector2=Vector2.ZERO

func _ready():
	viewport_size=get_viewport_rect().size
	
	var player_spawn_pos_y_offset=135
	player_spawn_position.x=viewport_size.x/2
	player_spawn_position.y=viewport_size.y-player_spawn_pos_y_offset
	
	ground.global_position.x=viewport_size.x/2
	ground.global_position.y=viewport_size.y
	
	setup_parallax_layer(parallaxlayer)
	setup_parallax_layer(parallaxlayer2)
	setup_parallax_layer(parallaxlayer3)
	
	new_game()

# 由于不同手机尺寸引起的对纹理所需缩放的计算
func get_parallax_sprite_scale(parallax_sprite:Sprite2D):
	var parallax_texture=parallax_sprite.get_texture()
	var parallax_texture_width=parallax_texture.get_width()
	
	var _scale=viewport_size.x/parallax_texture_width
	var result=Vector2(_scale,_scale)
	return result

#纹理缩放后设置所需要的motion_mirroring
func setup_parallax_layer(parallax_layer:ParallaxLayer):
	var parallax_sprite=parallax_layer.find_child("Sprite2D")
	if parallax_sprite!=null:
		parallax_sprite.scale=get_parallax_sprite_scale(parallax_sprite)
		var my=parallax_sprite.scale.y*parallax_sprite.get_texture().get_height()
		
		parallax_layer.motion_mirroring.y=my

func _process(_delta):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()

func new_game():
	
	player=player_scene.instantiate()
	player.global_position =player_spawn_position
	add_child(player)

	camera=camera_player.instantiate()
	camera.setup_camera(player)
	add_child(camera)
	
	if player:
		Levelgenerator.setup(player)	
