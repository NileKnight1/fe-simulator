extends CharacterBody2D

@onready var player
var speed = 150

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
	# errors happedned so i'm writing this line to 
	## force hackatime to run and send missing data
	## to website and log it
	#errors happened so im writing this line to
	#force hackactime to run and send missing data
	#to website and log it 
	#
	
func _physics_process(delta: float) -> void:
	var direction: Vector2 = player.global_position - global_position
	
	var distance: float = direction.length()

	if distance > 400: return
	
	if distance > 45:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		self.queue_free()
		global.picked(self.get_child(0).name)
	
	if !is_inside_tree():
		return
		
	move_and_slide()
	
	

	
