extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet/bullet.tscn")

var speed = 200  # Adjust this for desired movement speed
var move_timer = 0.0  # Timer for movement duration
var move_direction = 1  # 1 for up, -1 for down

func _ready():
	$Timer.start(1)

func fire():
	var bullet = bullet_scene.instantiate()	
	bullet.direction = ($Node2D/Marker2D.global_position - global_position).normalized()
	bullet.global_position = $Node2D/Marker2D.global_position
	get_tree().get_root().add_child(bullet)
	
func splash_fire():
	var bullet = [null,null,null,null,null,null,null,null,null,null]
	var angle = 36
	for i in range(10):
		bullet[i] = bullet_scene.instantiate()
		bullet[i].direction = Vector2.RIGHT.rotated(36*i)
		bullet[i].global_position = global_position
		get_tree().get_root().add_child(bullet[i])
	

func _physics_process(delta):
	move_timer += delta
	
	if move_timer > 2.0:
		move_timer = 0.0
		move_direction *= -1  # Reverse direction

	velocity.y = move_direction * speed
	move_and_slide()


func _on_timer_timeout():
	splash_fire()
	$Timer.start(1)
