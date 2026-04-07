extends Node

var player_speed = 300
var player_boost = 1.5
var max_health = 50
var game_script = null
var scene1_chat = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(player_speed)
	pass

func picked(x):
	game_script.picked(x)
