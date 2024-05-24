extends CharacterBody2D

@onready var velocity_component = $VelocityComponent

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")
var aim_bullet_scene = preload("res://scenes/aim_bullet/aim_bullet.tscn")

@export var fire_type = 1
# 1 - Regular
# 2 - Shotgun
# 3 - Laser (Incomplete)
# 4 - Aim Bullet

func aim_fire():
	var bullet = aim_bullet_scene.instantiate()
	bullet.global_position = $Marker2D1.global_position
	bullet.direction = ($Marker2D1.global_position - global_position).normalized()
	bullet.rotation_degrees = rotation_degrees
	get_tree().get_root().add_child(bullet)

func fire():
	
	var arr
	var times
	
	if fire_type == 1:
		arr = [null]
		times = 2
	elif fire_type == 2:
		arr = [null,null,null]
		times = 4
		
	for i in range(1,times):
		arr[i-1] = bullet_scene.instantiate()
		arr[i-1].direction = get_node("Marker2D" + str(i)).global_position - global_position
		arr[i-1].global_position = get_node("Marker2D" + str(i)).global_position
		if fire_type == 2:
			arr[i-1].is_shotgun = true
		get_tree().get_root().add_child(arr[i-1])
		
	
func get_movement_vector():
	#var movement_vector = Vector2.ZERO
	
	# returns 1 or 0 for keyboard, returns fraction for joystick
	# returns 1 if pressed
	# if movement right isnt pressed, and left is - then its -1 movement
	var x_movement = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#y is positive - positive goes first
	var y_movement = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var captured_movement = Vector2(x_movement,y_movement)
	return captured_movement

func _physics_process(delta):
	look_at(get_global_mouse_position())
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
	
	#if movement_vector.x != 0 || movement_vector.y != 0:
		#animation_player.play("walk")
	#else:
		#animation_player.play("RESET")
		
	#var move_sign = sign(velocity.x)
	#if move_sign != 0:
		#visuals.scale = Vector2(move_sign,1)
