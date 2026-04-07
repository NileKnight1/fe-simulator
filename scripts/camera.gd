extends Camera2D

var shake_strength := 0.0
var shake_decay := 5.0

func _process(delta):
	if shake_strength > 0:
		var angle = randf_range(0, TAU)
		offset = Vector2(cos(angle), sin(angle)) * shake_strength
		
		shake_strength = lerp(shake_strength, 0.0, shake_decay * delta)
	else:
		offset = Vector2.ZERO
