extends Node2D


@onready var player = $player
@onready var static_script = preload("res://scripts/static.gd")
@onready var moving_script = preload("res://scripts/moving.gd")
@onready var moving_script_slow = preload("res://scripts/moving_slow.gd")



@onready var oxygenS = preload("res://scenes/oxygen.tscn")
@onready var carbonS = preload("res://scenes/carbon.tscn")
@onready var chromiumS = preload("res://scenes/chromium.tscn")
@onready var waterS = preload("res://scenes/water.tscn")
@onready var hclS = preload("res://scenes/hcl.tscn")




@onready var oxygens = $oxygens
@onready var carbons = $carbons
@onready var chromiums = $chromiums
@onready var waters = $waters
@onready var hcls = $hcls




@onready var oxygen_timer = $oxygen
@onready var time_label = $gui/time

@onready var health_bar = $gui/Control/Panel3


var toHemo = 0
var chromium_alloy = 0


func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		$gui/mobile.visible = 1
	global.game_script = self
	player.no_move = 1
	#oxygen_timer.start()
	
	
	sp("What happened?", 1)
	await get_tree().create_timer(1.5).timeout
	sp("JACK", 2)
	await get_tree().create_timer(1).timeout
	sp("LISTEN TO ME.", 2)
	await get_tree().create_timer(1).timeout
	sp("YOU'RE NOW IN STEPHANIE STOMACH.", 2)
	await get_tree().create_timer(1).timeout
	sp("YOU HAVE TO SURVIVE WHAT'S COMING.", 2)
	await get_tree().create_timer(1).timeout
	sp("What's coming?", 1)
	await get_tree().create_timer(1).timeout
	sp("A LOT IS COMING.", 2)
	await get_tree().create_timer(1).timeout
	sp("You should keep your shine.", 2)
	heal_show()
	await get_tree().create_timer(2).timeout
	sp("Only carbon and chromium are good for you.", 2)
	await get_tree().create_timer(2).timeout
	sp("TAKE CARE.", 2)
	await get_tree().create_timer(2).timeout
	player.no_move = 0
	sp("", 1)
	oxygen_timer.start()
	am.pm("countdown")
	
	
	
	
	global.game_script = self
	#print(player.global_position)
	print("started")
	#start_game()
	#spawn_oxygen()
	#death()
	

func heal_show():
	var h = $gui/Control
	h.visible = 1
	await get_tree().create_timer(0.4).timeout
	h.visible = 0
	await get_tree().create_timer(0.4).timeout
	h.visible = 1
	await get_tree().create_timer(0.4).timeout
	h.visible = 0
	await get_tree().create_timer(0.4).timeout
	h.visible = 1
	await get_tree().create_timer(0.4).timeout
	h.visible = 0
	await get_tree().create_timer(0.4).timeout
	h.visible = 1



var ttt = 0
var t

func _physics_process(delta: float) -> void:
	
	if oxygen_timer.time_left == 0: return
	
	var list = [oxygens, carbons, chromiums, waters, hcls]
	for it in list: 
		for i in it.get_children():
			var pgp = player.global_position
			var direction: Vector2 = pgp - i.global_position
			var distance: float = direction.length()
			if distance > 500:
				i.queue_free()
				if it == oxygens:
					spawn_oxygen()
				elif it == carbons:
					spawn_carbon()
				elif it == chromiums:
					spawn_chromium()
				elif it == waters:
					spawn_water()
				elif it == hcls:
					spawn_hcl()
	
	t = int(oxygen_timer.time_left)
	if ttt == t: return
	time_label.text = str(t)
	ttt = t
	#print(t)
	print(player.health)
	
	
	if t % 4 == 0 && oxygens.get_child_count() <= 10:
		spawn_oxygen()
		
	if t % 15 == 0 && carbons.get_child_count() <= 6:
		spawn_carbon()
		spawn_carbon()
		spawn_carbon()
		
		
	if t % 10 == 0 && chromiums.get_child_count() < 2:
		spawn_chromium()
	#
	if t % 20 == 0 && hcls.get_child_count() < 1:
		spawn_hcl()
	
	if t % 15 == 0 && waters.get_child_count() < 2:
		spawn_water()
	
	if t == 0:
		end()

func sp(msg, co):
	$gui/Label.text = msg
	if co == 1:  $gui/Label.add_theme_color_override("font_color", Color("39a8c4"))
	elif co == 2: $gui/Label.add_theme_color_override("font_color", Color("cbb95a"))
	elif co == 0: $gui/Label.add_theme_color_override("font_color", Color("bbb9a3ff"))
	elif co == 3: $gui/Label.add_theme_color_override("font_color", Color("fcd1ceff"))
	am.ps("chat")
	
	

func start_game():
	oxygen_timer.start()
	
	#print(oxygen_timer.time_left)

func end():
	am.music_player.stop()
	remove_children(oxygens)
	remove_children(carbons)
	remove_children(chromiums)
	remove_children(waters)
	remove_children(hcls)
	
	$player/Camera2D.shake_strength = 25
	$player/Camera2D.shake_decay = 1
	am.ps("sparkle")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/convert_rbc.tscn")
	
	
	
func death():
	oxygen_timer.stop()
	#set_physics_process(false)
	remove_children(oxygens)
	remove_children(carbons)
	remove_children(chromiums)
	remove_children(waters)
	remove_children(hcls)
	
	
	
	get_tree().change_scene_to_file("res://scenes/stomach.tscn")
	
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

	while distance < 150 || new_object.position.x > 2430 || new_object.position.x < -1932 ||  new_object.position.y < -717 || new_object.position.y > 820 :
		
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

func spawn_water():
	var new_object = waterS.instantiate()
	spawn(waters, new_object, moving_script_slow)


func spawn_hcl():
	var new_object = hclS.instantiate()
	spawn(hcls, new_object, moving_script_slow)



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
		
		am.ps("rust")
		global.player_speed = 150
		global.player_boost = 1.25
		refresh_health(-10)
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
	refresh_health(15)
	am.ps("heal")
	
func hemo():
	toHemo = 1
	player.get_child(0).texture = load("res://assets/rbc.png")
	player.get_child(1).scale = Vector2(0.585, 0.585)
	
func chromium():
	player.get_child(0).texture = load("res://assets/ir3.png")
	chromium_alloy = 1
	global.player_speed = 300
	global.player_boost = 1.25
	am.ps("shield")
	
	await get_tree().create_timer(10.0).timeout
	am.ps("shield_off")
	
	player.get_child(0).texture = load("res://assets/ir1.png")
	
	chromium_alloy = 0
	
func macrophage():
	if toHemo:
		player.get_child(0).texture = load("res://assets/ir1.png")

func hcl():
	refresh_health(-30)
	am.ps("rust")
	if player.health <= 0:
		death()
		return
	
	

func water():
	if toHemo:
		pass
	else:
		if chromium_alloy: return
		am.ps("rust")
		global.player_speed = 150
		global.player_boost = 1.25
		refresh_health(-20)
		if player.health <= 0:
			death()
			return
		player.get_child(0).texture = load("res://assets/ir2.png")
		await get_tree().create_timer(10.0).timeout
		global.player_speed = 300
		global.player_boost = 1.25
		player.get_child(0).texture = load("res://assets/ir1.png")
