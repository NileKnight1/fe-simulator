extends Node2D


@onready var player = $player
@onready var static_script = preload("res://scripts/static.gd")
@onready var moving_script = preload("res://scripts/moving.gd")


@onready var oxygenS = preload("res://scenes/oxygen.tscn")
@onready var objects = $objects


var toHemo = 0
var chromium_alloy = 0


func _ready() -> void:
	global.game_script = self
	#print(player.global_position)
	
	spawn_oxygen()
	spawn_oxygen()
	spawn_oxygen()
	spawn_oxygen()	
	
	spawn_oxygen()
	spawn_oxygen()
	spawn_oxygen()
	spawn_oxygen()	


func spawn(new_object):
	new_object.set_script(moving_script)
	objects.add_child(new_object)
	
	new_object.position = Vector2(randi_range(-200,200), randi_range(-200,200))
	var direction: Vector2 = player.global_position - objects.get_child(objects.get_child_count()-1).global_position
	var distance: float = direction.length()
	
	
	while distance < 150:
		new_object.position = Vector2(randi_range(-200,200), randi_range(-200,200))
		direction = player.global_position - objects.get_child(objects.get_child_count()-1).global_position
		distance = direction.length()
		
	



func spawn_oxygen():
	var new_object = oxygenS.instantiate()	
	spawn(new_object)
	

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
