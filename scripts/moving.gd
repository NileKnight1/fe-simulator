extends CharacterBody2D

@onready var player
var speed = 100

func _ready() -> void:
	player = $"../../player"
	#var direction: Vector2 = player.global_position - global_position
	#var distance: float = direction.length()
#
#
	#print(direction)
	#print(distance)
	#if distance > 20:
		#direction = direction.normalized()
		#velocity = direction * speed
	#else:
		#velocity = Vector2.ZERO

	#move_and_slide()
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = player.global_position - global_position
	var distance: float = direction.length()

	if distance > 150: return
	
	if distance > 45:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		self.queue_free()
		global.picked(self.get_child(0).name)
	

	move_and_slide()
	
	

	
