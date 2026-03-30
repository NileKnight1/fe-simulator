extends CharacterBody2D

@onready var player

func _on_body_entered(body: Node2D) -> void:
	self.queue_free()
	global.picked(self.get_child(0).name)

func _ready() -> void:
	player = $"../../player"
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = player.global_position - global_position
	var distance: float = direction.length()

	if distance > 45:
		direction = direction.normalized()
	else:
		velocity = Vector2.ZERO
		self.queue_free()
		global.picked(self.get_child(0).name)
