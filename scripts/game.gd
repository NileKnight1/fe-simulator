extends Node2D


@onready var player = $player

var toHemo = 0
var chromium_alloy = 0

func picked(atom):
	match atom:
		"oxygen":
			oxygen()
		"carbon":
			carbon()
		"hemo":
			hemo()
		"chromium":
			chromium()
		"macrophage":
			macrophage()
		"hcl":
			hcl()
		"water":
			water()

func oxygen():
	if toHemo:
		player.scale.x += 0.1
		player.scale.y += 0.1
		
	else:
		if chromium_alloy: return
		
		global.player_speed = 150
		global.player_boost = 1.25
		player.health -= 15
		player.get_child(0).texture = load("res://assets/ir2.png")
		await get_tree().create_timer(3.0).timeout
		global.player_speed = 300
		global.player_boost = 1.25
		player.get_child(0).texture = load("res://assets/ir1.png")
		
func carbon():
	player.health += 10
	
	
func hemo():
	toHemo = 1
	player.get_child(0).texture = load("res://assets/rbc.png")
	player.get_child(1).scale = Vector2(0.585, 0.585)
	
func chromium():
	player.get_child(0).texture = load("res://assets/ir3.png")
	chromium_alloy = 1
	await get_tree().create_timer(10.0).timeout
	player.get_child(0).texture = load("res://assets/ir1.png")
	
	chromium_alloy = 0
	
func macrophage():
	if toHemo:
		player.get_child(0).texture = load("res://assets/ir1.png")

func hcl():
	player.scale.x -= 0.5
	player.scale.y -= 0.5

func water():
	if toHemo:
		pass
	else:
		if chromium_alloy: return
		
		global.player_speed = 150
		global.player_boost = 1.25
		player.health -= 15
		player.get_child(0).texture = load("res://assets/ir2.png")
		await get_tree().create_timer(10.0).timeout
		global.player_speed = 300
		global.player_boost = 1.25
		player.get_child(0).texture = load("res://assets/ir1.png")
