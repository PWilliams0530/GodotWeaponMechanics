extends Area2D

var direction = Vector2.RIGHT
var speed = 400
var target = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate(direction.normalized() * speed * delta)
	if target:
		direction = target.global_position - global_position
		direction.normalized()
		look_at(target.global_position)


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		#do damage
		queue_free()


func _on_aiming_area_body_entered(body):
	target = body


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
