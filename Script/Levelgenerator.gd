extends Node2D
@onready var platform_parent=$PlatformParent

var platform_scene=preload("res://Scene/platform.tscn")

# level vir
var y_distance_platform=100
var y_start_platform
var level_size=50
var viewpoint_size
var generated_platform_count=0

var player:Player=null
func setup(_player:Player):
	if _player:
		player=_player

func _ready():
	viewpoint_size=get_viewport_rect().size
	generated_platform_count=0
	y_start_platform=viewpoint_size.y-(y_distance_platform*2)
	generation_level(y_start_platform,true)
	
func _process(_delta):
	if player:
		var py=player.global_position.y
		var end_of_level_pos=y_start_platform-(y_distance_platform*generated_platform_count)
		var threshold=end_of_level_pos+(y_distance_platform*6)
		if py<threshold:
			generation_level(end_of_level_pos,false)

func create_platform(location: Vector2):
	var platform=platform_scene.instantiate()
	platform.global_position=location
	platform_parent.add_child(platform)
	return platform

func generation_level(start_y:float,generation_ground:bool):
	var ground_width=132
	if generation_ground==true:
		# 生成地板
		var ground_offsite=30
		var ground_layer_count=viewpoint_size.x/ground_width+1
		for i in range(ground_layer_count):
			var ground_location=Vector2(i*ground_width,viewpoint_size.y-ground_offsite)
			create_platform(ground_location)
		
	# 生成剩余关卡
	for i in range(level_size):
		var max_x_position=viewpoint_size.x-ground_width
		var random_x=randf_range(0,max_x_position)
		
		var location:Vector2=Vector2.ZERO
		location.x=random_x
		location.y=start_y-(y_distance_platform*i)
		create_platform(location)
		generated_platform_count+=1
