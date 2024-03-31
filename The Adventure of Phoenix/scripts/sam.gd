extends CharacterBody2D
@onready var inv = get_parent().get_parent().get_node("main/Inv")
@onready var mod = get_parent().get_parent().get_node("pauseing/ColorRect/CanvasModulate")
@export var speed = 115
@export var kbpower = 5000
var bombs = 0
var dashed = false
var has_sword = true
var disable_movment = false
var hp = 100
var input_direction
var swordtime = 0
var paused = false
var damage = 5
func _ready():
	$sword/swordcollision.disabled = true
	$samsprite/hp_bar.get("theme_override_styles/fill").bg_color = Color.RED
func _physics_process(delta):
	if bombs <=1 and Input.is_action_pressed("bomb"):
		bomb()
	if disable_movment == false:
		input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized();
		velocity=input_direction*speed
		move_and_slide()
		if input_direction == Vector2(0,0): #null
			$samsprite.play("default_down")
			$samsprite.flip_h = false
		elif input_direction == Vector2(-1,0): #left
			$samsprite.play("right")
			$samsprite.flip_h = true
		elif input_direction == Vector2(1,0): #right
			$samsprite.play("right")
		elif input_direction == Vector2(0,1): #down
			$samsprite.play("down")
		elif input_direction == Vector2(0,-1): #up
			$samsprite.play("up")
	if Input.is_action_just_pressed("sword") and has_sword == true:
		disable_movment = true
		sword()
		$sword/swordcollision.disabled = false
		swordtime = 15
	if swordtime != 0:
		swordtime=swordtime - 1
		if swordtime == 0:
			disable_movment = false
			$sword.hide()
			$sword/swordcollision.disabled = true
	if Input.is_action_pressed("dash") and dashed == false:
		speed = 600
		await get_tree().create_timer(.3).timeout
		speed = 100.0
		dashed = true
		await get_tree().create_timer(.5).timeout
		dashed = false
	if Input.is_action_pressed("pause") and paused == false:
		mod.show()
		inv.show()
		disable_movment = true
		await get_tree().create_timer(.5).timeout
		paused = true
	if paused == true and Input.is_action_pressed("pause"):
		disable_movment = false
		mod.hide()
		inv.hide()
		await get_tree().create_timer(.5).timeout
		paused = false
func sword():
	if input_direction == Vector2(1,0):
		$sword.rotation_degrees = 0
		$samsprite.play("sword_right")
	if input_direction == Vector2(-1,0):
		$sword.rotation_degrees = 180
		$samsprite.play("sword_left")
	if input_direction == Vector2(0,1):
		$sword.rotation_degrees = 90
		$samsprite.play("sword_down")
	if input_direction == Vector2(0,-1):
		$sword.rotation_degrees = 270
		$samsprite.play("sword_up")
func _on_hurtbox_area_entered(area):
	if area.name == "hitbox":
		knockback(area.get_parent().velocity)
		$samsprite.modulate = Color(1,1,1,0)
		await get_tree().create_timer(.05).timeout
		$samsprite.modulate = Color(1,1,1,1)
		hp = hp - damage
		$samsprite/hp_bar.value =hp
		if hp <= 0:
			get_tree().quit()
func knockback(EnemyVelocity: Vector2):
	var knockbackdir = (EnemyVelocity-velocity).normalized()*kbpower
	velocity = knockbackdir
	move_and_slide()
func bomb():
	pass
