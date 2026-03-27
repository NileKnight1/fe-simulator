extends CharacterBody2D


@export var SPEED = global.player_speed
@export var boost = global.player_boost

@onready var player = $ch

var health = global.player_health

var no_move = 0
@onready var walk_sound = $"../sounds/walk"

var step_timer = 0.0
var step_delay = 0.35

#@onready var tiles = $tiles
#@onready var main = $main

#const JUMP_VELOCITY = -400.0

	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
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
		#player.play("move")
		#print("hori")
	else:
		
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#player.play("default")
		
	if direction2:
		
		if boost_check:
			velocity.y = direction2 * SPEED * boost
		else:
			#print("hi")
			velocity.y = direction2 * SPEED
		#if direction2<0:
			##player.play("up")
			#print("Up")
		#else: 
			##player.play("down")
			#print("Down")
			
		#print("im moving V")
	else:
		
		#player.play("default")
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	#print(direction)
	#print(direction2)
	if direction > 0:
		player.flip_h = false
	elif direction < 0:
		player.flip_h = true
	
	if direction != 0:
		player.play("move")
		
	elif direction2 == -1:
		player.play("up")
		
		
	elif direction2 == 1:
		player.play("down")
	else:
		#$"../sounds/walk".playing = 0
		#$"../sounds/walk".playing
		player.play("default")
		
		
	var moving = direction != 0 or direction2 != 0

	if moving:
		step_timer -= delta
		
		if step_timer <= 0:
			walk_sound.pitch_scale = randf_range(0.9, 1.1)
			walk_sound.play()
			step_timer = step_delay
	else:
		step_timer = 0
	#collisions
	#
	#main.set_deferred("disabled", 1)
	#tiles.set_deferred("disabled", 0)
	#collision_mask = 2
	#move_and_slide()
	#
	#tiles.set_deferred("disabled", 1)
	#main.set_deferred("disabled", 0)
	#collision_mask = 7
	move_and_slide()
