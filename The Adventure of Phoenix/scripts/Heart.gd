extends Node2D
@onready var player = get_parent().get_node("sam")
func _on_area_2d_area_entered(area):
	if area.name == "sword":
		var bar = area.get_parent().get_node("samsprite/hp_bar")
		area.get_parent().hp = area.get_parent().hp + 20
		bar.value = area.get_parent().hp
		if area.get_parent().hp >100:
			area.get_parent().hp = 100
			bar.value = area.get_parent().hp
		queue_free()
