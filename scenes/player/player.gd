extends CharacterBody2D

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
		
	
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_select"):
			if fire_type == 1 || fire_type == 2:
				fire()
			elif fire_type == 3:
				#Laser Fire
				pass
			elif fire_type == 4:
				aim_fire()
