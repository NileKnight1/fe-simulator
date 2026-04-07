extends Node2D

@onready var scriptX = preload("res://scripts/moving2.gd")
@onready var oxygen2S = preload("res://scenes/oxygen2.tscn")

@onready var player = $player
@onready var health_bar = $gui/Control/Panel3
@onready var Oxtimer = $Timer

var macro_run = 0
var safe = 0
var cur = 0
var not_now = 1
var ox1 = 0
var oxygen_amount = 0
var max_oxygen = 15


func _ready() -> void:
	refresh_oxygen(1)
	global.game_script = self
	Oxtimer.start()
	
	#spawn_ox2()
	##scene()
	#var object = oxygen2S.instantiate()
	#object.set_script(scriptX)
	#$oxygens.add_child(object)
	#object.position = Vector2(50, 50)
	##
	#spawn_ox2()
	#spawn_ox2()
	#spawn_ox2()
	#spawn_ox2()
	#spawn_ox2()
	#spawn_ox2()
	#spawn_ox2()
	
	
var ttt = 0
var t 

func _physics_process(delta: float) -> void:
	
	for i in $oxygens.get_children():
		var pgp = player.global_position
		var direction: Vector2 = pgp - i.global_position
		var distance: float = direction.length()
		if distance > 800 || i.position.x > 2430 || i.position.x < -1932.0 ||  i.position.y < -717 || i.position.y > 820:
			i.queue_free()
			spawn_ox2()
		
	t = int(Oxtimer.time_left)
	if ttt == t: return
	#time_label.text = str(t)
	ttt = t
	#print(t)
	#print(player.health)
	

	if t % 1 == 0 && $oxygens.get_child_count() <= 10:
		spawn_ox2()
		spawn_ox2()
		spawn_ox2()




func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if not_now: return
		#print(cur)
		
		scene_choose()

func sp(msg, co):
	$gui/Label.text = msg
	if co == 1:  $gui/Label.add_theme_color_override("font_color", Color("39a8c4"))
	elif co == 2: $gui/Label.add_theme_color_override("font_color", Color("cbb95a"))
	elif co == 0: $gui/Label.add_theme_color_override("font_color", Color("bbb9a3ff"))
	elif co == 3: $gui/Label.add_theme_color_override("font_color", Color("fcd1ceff"))
	

func scene_choose():
	if !safe: scene()
	#else: scene2()

func scene():
	cur += 1
	match cur: 
		1: 
			sp("I'm full oxygenated doc.", 1)
			sceneAuto(1.5)
		2:
			sp("Good job.", 2)
			sceneAuto(1.5)
		3:
			get_tree().change_scene_to_file("res://scenes/convert_fe.tscn")
			
			

func sceneAuto(t):
		await get_tree().create_timer(t).timeout
		scene()
	

func _on_checkpoint_entered(body: Node2D) -> void:
	if body == player: get_tree().change_scene_to_file("res://scenes/get_oxygen.tscn")


func cam_switch(cam1, cam2):
	cam1.zoom = cam2.zoom
	cam1.position = cam2.position
	cam1.rotation = cam2.rotation
	cam1.scale = cam2.scale


func refresh_oxygen(pnt):
	oxygen_amount += pnt
	if oxygen_amount > max_oxygen:
		oxygen_amount = max_oxygen
	#print((float(oxygen_amount)/float(max_oxygen))*6)
	
	health_bar.scale.x = ((float(oxygen_amount)/float(max_oxygen))*6)
	
	print(oxygen_amount)
	if oxygen_amount == 15:
		end()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if ox1: return
	if body == player:
		ox1 = 1
		player.position = Vector2(-2, -137)

		player.no_move = 1
		sp("I found one.", 1)
		await get_tree().create_timer(1).timeout
		sp("GREAT!", 2)
		await get_tree().create_timer(1).timeout
		sp("Oxygen", 2)
		cam_switch($player/Camera2D, $player/oxygen)
		$oxygen_ex.visible = 1
		not_now = 0
		scene()


func picked(atom):
	match atom:
		"oxygen2":
			oxygen2()

func oxygen2():
	refresh_oxygen(1)

func spawn_ox2():
	var new_object = oxygen2S.instantiate()
	spawn(new_object)


func spawn(new_object):
	var pgp = player.global_position
	
	new_object.set_script(scriptX)
	#print(new_object)
	$oxygens.add_child(new_object)
	
	new_object.position = Vector2(randi_range(pgp.x-200,pgp.x+200), randi_range(-pgp.y-200,pgp.y+200))
	var direction: Vector2 = pgp - new_object.global_position
	var distance: float = direction.length()
	
	
	while distance < 150 || new_object.position.x > 2430 || new_object.position.x < -1932.0 ||  new_object.position.y < -717 || new_object.position.y > 820 :
		new_object.position = Vector2(randi_range(pgp.x-200,pgp.x+200), randi_range(-pgp.y-200,pgp.y+200))
		direction = pgp - new_object.global_position
		distance = direction.length()

func end():
	Oxtimer.stop()
	await get_tree().create_timer(0.1).timeout
	
	for i in $oxygens.get_children():
		i.queue_free()
