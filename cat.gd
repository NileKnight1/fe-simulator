extends CharacterBody2D

@export var speed: float = 70
@onready var taskbar = $"../../gui/taskbar"
@onready var inventory = $"../../gui/inventory"
#@onready var cooldown = $"../cooldown"
@onready var game = $"../.."

var player: Node2D
var ch: AnimatedSprite2D
var hitbox = 0
var health = 60


func _ready() -> void:
	
	player = $"../../player1"
	ch = $ch


func _physics_process(delta: float) -> void:
	#print(cooldown.wait_time)
	
	if player == null:
		return

	var direction: Vector2 = player.global_position - global_position
	var distance: float = direction.length()

	if distance > 20:
		direction = direction.normalized()
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if velocity == Vector2.ZERO:
		ch.play("idle")
	else:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				ch.play("right")
			else:
				ch.play("left")
		else:
			if velocity.y > 0:
				ch.play("down")
			else:
				ch.play("up")
	#ch.play()


func _on_area_body_entered(body: Node2D) -> void:
	#print("here6")
	
	if body == player:
		#print("here1")
		game.player_hit()

func _on_damage_body_entered(body: Node2D) -> void:
	#print("here5")
	
	if body == player:
		#print("here2")
		
		hitbox = 1

func _on_damage_body_exited(body: Node2D) -> void:
	#print("here4")
	
	if body == player:
		#print("here3")
		
		hitbox = 0
#
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("action"):
		#game.hit(self)
