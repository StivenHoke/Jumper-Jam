extends CharacterBody2D
class_name Player
@onready var animator=$AnimationPlayer

var speed=300.0
var viewpoint_size
var gravity=15.0
var max_fall_velocity=1000.0
var jump_velocity=-800.0

func _ready():
	viewpoint_size=get_viewport_rect().size

func _process(_delta):
	if velocity.y>0:
		if animator.current_animation!="Fall":
			animator.play("Fall")
			
	elif velocity.y<0:
		if animator.current_animation!="Jump":
			animator.play("Jump")
			

func _physics_process(_delta):
	if(velocity.y<=max_fall_velocity):
		velocity.y +=gravity
	

	
	
	var direction=Input.get_axis("move_left","move_right")
	if direction:
		velocity.x=direction*speed
	else:
		velocity.x=move_toward(velocity.x,0,speed)
		
	move_and_slide()
	
	var mergin=20
	if global_position.x>viewpoint_size.x+mergin:
		global_position.x=-mergin
		
	if global_position.x<-mergin:
		global_position.x=viewpoint_size.x+mergin

func jump():
	velocity.y=jump_velocity
	
