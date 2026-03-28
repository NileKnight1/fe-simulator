extends CharacterBody2D


func _on_body_entered(body: Node2D) -> void:
	self.queue_free()
	global.picked(self.get_child(0).name)
