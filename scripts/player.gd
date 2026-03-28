extends CharacterBody2D

@onready var game = $".."



var no_move = 0
var health = 50

func _physics_process(delta: float) -> void:
	var SPEED = global.player_speed
	var boost = global.player_boost
	#print(SPEED)
	if(no_move): return
	
	velocity += get_gravity() * delta


	var direction := Input.get_axis("left", "right")
	var direction2 := Input.get_axis("up", "down")
	var boost_check = Input.is_action_pressed("sprint")
	
	
	if direction:
		if boost_check:
			velocity.x = direction * SPEED * boost
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction2:
		if boost_check:
			velocity.y = direction2 * SPEED * boost
		else:
			velocity.y = direction2 * SPEED

	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
#
	#if direction > 0:
		#player.flip_h = false
	#elif direction < 0:
		#player.flip_h = true
	#
	#if direction != 0:
		#player.play("move")
		#
	#elif direction2 == -1:
		#player.play("up")
		#
	#elif direction2 == 1:
		#player.play("down")
	#else:
		#player.play("default")

	move_and_slide()
