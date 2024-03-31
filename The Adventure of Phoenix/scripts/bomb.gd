extends Node2D
var hit = null
var timer = 0

func _physics_process(_delta):
	timer = timer + 1
	print(timer)
	if timer >= 500:
		hit = hit - 50
		self.queue_free()


func _on_explosion_body_entered(body):
	hit = body.hp
	print(hit)
	print(body)
