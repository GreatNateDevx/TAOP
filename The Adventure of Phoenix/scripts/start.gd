extends Node2D
var count = 0
var swwitch = false
var frame = 0
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_RESIZE_DISABLED, true)
func _physics_process(_delta):
	if Input.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/hyrule.tscn")
	if count != 30 and swwitch == false and frame == 3:
		count = count+1
		$Label.set("theme_override_font_sizes/font_size",count)
		frame = 0
		if count == 30:
			swwitch = true
	elif count != 20 and swwitch == true and frame == 3:
		count = count-1
		$Label.set("theme_override_font_sizes/font_size",count)
		frame = 0
		if count == 20:
			swwitch = false
	frame = frame + 1
