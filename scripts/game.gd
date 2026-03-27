extends Node2D


@onready var player = $player

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func oxygen():
	global.player_speed -= 50
	global.player_boost -= 0.15

func carbon():
	pass
