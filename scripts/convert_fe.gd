extends Node2D


@onready var player = $player
@onready var health_bar = $gui/Control/Panel3

var macro_run = 0
var safe = 0
var cur = 0
var not_now = 1
var ox1 = 0
var oxygen_amount = 15
var max_oxygen = 15
var first_ox = 1

func _ready() -> void:
	refresh_oxygen(0)
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
	

func scene_choose():
	if !safe: scene()
	#else: scene2()

func scene():
	cur += 1
	match cur: 
		1: 
			sp("Now where to?", 1)
			sceneAuto(1.5)
		2:
			sp("Ummmm.", 2)
			sceneAuto(1.5)
		3:
			sp("What do yo you mean by UMMMM?", 1)
			sceneAuto(1.5)
		4: 
			sp("You have to find a way out of yourself.", 2)
			sceneAuto(1.5)
		5:
			sp("Can you help?", 1)
			sceneAuto(1.5)
		6:
			sp("I don't think so.", 2)
			sceneAuto(1.5)
		7:
			sp("I hate you.", 1)
			sceneAuto(1.5)
			
		8: sp("", 1)
			

func sceneAuto(t):
		await get_tree().create_timer(t).timeout
		scene()
	

func _on_checkpoint_entered(body: Node2D) -> void:
	if first_ox: return
	if body == player: get_tree().change_scene_to_file("res://scenes/oxygens.tscn")


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




func _on_liver_entered(body: Node2D) -> void:
	if body == player:
		
		sp("Wow .. so big organ.", 1)
		await get_tree().create_timer(1.5).timeout
		sp("I guess it's the liver.", 2)
		await get_tree().create_timer(2.5).timeout
		sp("", 1)

func _on_kidneys_entered(body: Node2D) -> void:
	if body == player:
		sp("Are these kidneys?", 1)
		await get_tree().create_timer(2.5).timeout
		sp("", 1)

func _on_spleen_entered(body: Node2D) -> void:
	if body == player:
		sp("What's this?", 1)
		player.no_move = 1
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://scenes/spleen.tscn")
		
		
