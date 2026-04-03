extends Node2D


@onready var player = $player
@onready var static_script = preload("res://scripts/static.gd")
@onready var moving_script = preload("res://scripts/moving.gd")


@onready var oxygenS = preload("res://scenes/oxygen.tscn")
@onready var carbonS = preload("res://scenes/carbon.tscn")
@onready var chromiumS = preload("res://scenes/chromium.tscn")


@onready var oxygens = $oxygens
@onready var carbons = $carbons
@onready var chromiums = $chromiums


@onready var oxygen_timer = $oxygen
@onready var time_label = $gui/time

@onready var health_bar = $gui/Control/Panel3


var toHemo = 0
var chromium_alloy = 0


func _ready() -> void:
	global.game_script = self
	#print(player.global_position)
	print("started")
	start_game()
	#death()
	

var ttt = 0
var t

func _physics_process(delta: float) -> void:
	
	if oxygen_timer.time_left == 0: return
	
	for i in oxygens.get_children():
		var pgp = player.global_position
		var direction: Vector2 = pgp - i.global_position
		var distance: float = direction.length()
		if distance > 500:
			i.queue_free()
			spawn_oxygen()
			
	t = int(oxygen_timer.time_left)
	if ttt == t: return
	time_label.text = str(t)
	ttt = t
	#print(t)
	print(player.health)
	
	
	if t % 4 == 0 && oxygens.get_child_count() <= 10:
		spawn_oxygen()
		
	if t % 15 == 0 && carbons.get_child_count() <= 7:
		spawn_carbon()
		
	if t % 10 == 0 && chromiums.get_child_count() <= 2:
		spawn_chromium()
	



func start_game():
	oxygen_timer.start()
	#print(oxygen_timer.time_left)

func death():
	oxygen_timer.stop()
	#set_physics_process(false)
	remove_children(oxygens)
	remove_children(carbons)
	remove_children(chromiums)
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
func refresh_health(pnt):
	player.health += pnt
	if player.health > global.max_health:
		player.health = global.max_health
	
	#print(float(player.health)/float(global.max_health))
	print((float(player.health)/float(global.max_health))*6)
	#print()
	
	health_bar.scale.x = ((float(player.health)/float(global.max_health))*6)
	
	
	

func spawn(list, new_object, script):
	var pgp = player.global_position
	
	new_object.set_script(script)
	list.add_child(new_object)
	
	new_object.position = Vector2(randi_range(pgp.x-200,pgp.x+200), randi_range(-pgp.y-200,pgp.y+200))
	var direction: Vector2 = pgp - new_object.global_position
	var distance: float = direction.length()
	
	
	while distance < 150 || new_object.position.x > 1150 || new_object.position.x < -995 ||  new_object.position.y < -610 || new_object.position.y > 640 :
		
		new_object.position = Vector2(randi_range(pgp.x-200,pgp.x+200), randi_range(-pgp.y-200,pgp.y+200))
		direction = pgp - new_object.global_position
		distance = direction.length()
		
	



func spawn_oxygen():
	var new_object = oxygenS.instantiate()
	spawn(oxygens, new_object, moving_script)


func spawn_carbon():
	var new_object = carbonS.instantiate()
	spawn(carbons, new_object, static_script)

func spawn_chromium():
	var new_object = chromiumS.instantiate()
	spawn(chromiums, new_object, static_script)


func remove_children(list):
	for i in list.get_children():
		i.queue_free()

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
		refresh_health(-15)
		if player.health <= 0:
			death()
			return
		player.get_child(0).texture = load("res://assets/ir2.png")
		await get_tree().create_timer(3.0).timeout
		if chromium_alloy: return
		global.player_speed = 300
		global.player_boost = 1.25
		player.get_child(0).texture = load("res://assets/ir1.png")
		
func carbon():
	refresh_health(10)
	
	
func hemo():
	toHemo = 1
	player.get_child(0).texture = load("res://assets/rbc.png")
	player.get_child(1).scale = Vector2(0.585, 0.585)
	
func chromium():
	player.get_child(0).texture = load("res://assets/ir3.png")
	chromium_alloy = 1
	global.player_speed = 300
	global.player_boost = 1.25
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
		refresh_health(-25)
		player.get_child(0).texture = load("res://assets/ir2.png")
		await get_tree().create_timer(10.0).timeout
		global.player_speed = 300
		global.player_boost = 1.25
		player.get_child(0).texture = load("res://assets/ir1.png")
