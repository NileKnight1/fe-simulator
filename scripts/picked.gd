extends Area2D

@onready var game = $".."


func _on_body_entered(body: Node2D) -> void:
	self.queue_free()
	game.picked(self.get_child(0).name)
