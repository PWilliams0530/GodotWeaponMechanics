extends Area2D

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")
var bullet_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	#if Input.is_action_just_pressed("ui_select"):
		#fire()
	pass

func fire():
	var bullet_scene_instance = bullet_scene.instantiate()
	bullet_scene_instance.speed = bullet_speed
	bullet_scene_instance.global_position = $Node2D/Marker2D.global_position
	bullet_scene_instance.direction = ($Node2D/Marker2D.global_position - global_position).normalized()
	get_tree().get_root().add_child(bullet_scene_instance)
