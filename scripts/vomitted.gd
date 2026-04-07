extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/girl_sci.tscn")
		
