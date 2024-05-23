extends Area2D

var direction = Vector2.RIGHT
var speed = 400
var is_shotgun = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction.normalized() * speed * delta)
	if is_shotgun:
		$Timer.start(0.2)
		is_shotgun = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	#if body.is_in_group("enemy"):
		#do damage
		#queue_free()
	pass

func _on_timer_timeout():
	$Timer.stop()
	queue_free()
