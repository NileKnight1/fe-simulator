extends Node2D


@onready var player = $player
@onready var health_bar = $gui/Control/Panel3

var macro_run = 0
var safe = 0
var cur = 0
var not_now = 1
var ox1 = 0
var oxygen_amount = 0
var max_oxygen = 15
var first_ox = 1

func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		$gui/mobile.visible = 1
	refresh_oxygen(0)
	am.pm("fluid")
	global.game_script = self
	scene()
	


func _physics_process(delta: float) -> void:
	pass



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if not_now: return
		print(cur)
		
		scene_choose()

func sp(msg, co):
	$gui/Label.text = msg
	if co == 1:  $gui/Label.add_theme_color_override("font_color", Color("39a8c4"))
	elif co == 2: $gui/Label.add_theme_color_override("font_color", Color("cbb95a"))
	elif co == 0: $gui/Label.add_theme_color_override("font_color", Color("bbb9a3ff"))
	elif co == 3: $gui/Label.add_theme_color_override("font_color", Color("fcd1ceff"))
	am.ps("chat")
	

func scene_choose():
	if !safe: scene()
	#else: scene2()

func scene():
	cur += 1
	match cur: 
		1: 
			sp("I escaped.", 1)
			sceneAuto(1.5)
		2:
			sp("Ooof.", 2)
			sceneAuto(1)
		3:
			sp("What now?", 1)
			sceneAuto(1.5)
		4: 
			sp("Find a heamoglobin molecule.", 2)
			sceneAuto(1.5)
		5: 
			sp("Then?", 1)
			sceneAuto(1.5)
		6: 
			sp("You'll see yourself.", 2)
			sceneAuto(1.5)
		7: sp("", 1)
		8: 	
			sp("WOW .. I'm an RBC now.", 1)
			sceneAuto(1.5)
		9: 
			sp("THAT'S THE SPIRIT!", 2)
			sceneAuto(1.5)
		10: 
			sp("HOORAY!", 2)
			sceneAuto(1.5)
		11: 
			sp("Go to her heart now.", 2)



func sceneAuto(t):
		await get_tree().create_timer(t).timeout
		scene()
	

func _on_checkpoint_entered(body: Node2D) -> void:
	
	if player.get_child(0).texture != load("res://assets/rbc.png"): return
	if body == player: get_tree().change_scene_to_file("res://scenes/end.tscn")


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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if ox1: return
	if body == player:
		ox1 = 1
		player.position = Vector2(410, -137)

		player.no_move = 1
		#sp("I found one.", 1)

		cam_switch($player/Camera2D, $player/oxygen)
		$oxygen_ex.visible = 1
		am.ps("whoosh")
		await get_tree().create_timer(3).timeout
		$oxygen_ex.visible = 0
		cam_switch($player/Camera2D, $player/temp)
		player.no_move = 0
		


func picked(atom):
	match atom:
		"hemo":
			hemo()

func hemo():
	am.ps("sparkle")
	player.get_child(0).texture = load("res://assets/rbc.png")
	player.scale = Vector2(4.31, 4.31)
	scene()
	
