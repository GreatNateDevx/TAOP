extends CharacterBody2D
var speed = 110
var hp = 100
var heart = preload("res://scenes/heart.tscn")
var hearto = heart.instantiate()
var gold = preload("res://scenes/gold.tscn")
var goldo = gold.instantiate()
@export var kbpower = 5000
@onready var player = get_parent().get_node("sam")
@onready var sword = get_parent().get_node("sam/sword")
func _ready():
	$chuchusprite/ProgressBar.get("theme_override_styles/fill").bg_color = Color.RED
func _physics_process(delta):
	var direction := global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
func _on_hurtbox_area_entered(area):
	if area.name == "sword":
		knockback(area.get_parent().velocity)
		$chuchusprite.modulate = Color(1,1,1,0)
		await get_tree().create_timer(.05).timeout
		$chuchusprite.modulate = Color(1,1,1,1)
		hp = hp - 10
		$chuchusprite/ProgressBar.value = hp
		if hp <= 0:
			var item = randi_range(1,2)
			if item == 1:
				get_parent().add_child(hearto)
				hearto.position = self.position
				queue_free()
			elif item == 2:
				get_parent().add_child(goldo)
				goldo.position = self.position
				queue_free()
func knockback(playervel: Vector2):
	var knockbackdir = (playervel-velocity).normalized()*kbpower
	velocity = knockbackdir
	move_and_slide()
