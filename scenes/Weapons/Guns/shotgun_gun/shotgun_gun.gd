extends Area2D

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")
var is_reloading = false
var reload_speed = 0.5
var bullet_life_length = 0.3
var spread_bullets = [null,null,null]
var max_bullets = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select") && !is_reloading:
		fire()
		is_reloading = true
		$ReloadTimer.start(reload_speed)
		$BulletLifeLengthTimer.start(bullet_life_length)
		
	
func fire():	
	for i in range(1,max_bullets):
		spread_bullets[i-1] = bullet_scene.instantiate()
		spread_bullets[i-1].direction = get_node("Marker2D" + str(i)).global_position - global_position
		spread_bullets[i-1].global_position = get_node("Marker2D" + str(i)).global_position
		get_tree().get_root().add_child(spread_bullets[i-1])

func _on_bullet_life_length_timer_timeout():
	$BulletLifeLengthTimer.stop()
	for i in range(1,max_bullets):
		spread_bullets[i-1].queue_free()

func _on_reload_timer_timeout():
	$ReloadTimer.stop()
	is_reloading = false
