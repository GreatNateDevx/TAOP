extends Node2D
@onready var player = get_parent().get_node("sam")
func _on_area_2d_area_entered(area):
	if area.name == "sword":
		var Label = area.get_parent().get_node("CanvasLayer/Label")
		var gold = int(Label.text)
		gold = gold + 1
		gold = str(gold)
		Label.text = gold
		queue_free()
