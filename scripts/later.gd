extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		get_tree().change_scene_to_file("res://scenes/scientist_meet.tscn")
		#am.pm("night")
