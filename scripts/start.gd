extends Node2D


func _on_option_1_pressed() -> void:
	am.ps("click")
	#am.pm("birds")
	get_tree().change_scene_to_file("res://scenes/meeting.tscn")
