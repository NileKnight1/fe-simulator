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
			sp("Yo doc .. you still here.", 1)
			sceneAuto(1.5)
		2:
			sp("I was eating.", 2)
			sceneAuto(1)
		3:
			sp("I WOULD HAVE JUST BEEN EATEN.", 1)
			sceneAuto(1.5)
		4: 
			sp("Haha .. search for oxygen and I'll tell you what to do.", 2)
			sceneAuto(3)
		5: sp("", 1)
		6:
			sp("You as an RBC carry oxygen, the most important fuel every cell depends on to survive and produce energy.", 2)
		7:
			sp("Carry as many as you can to move to the next step.", 2)
		8:
			
			$oxygen_ex.visible = 0
			cam_switch($player/Camera2D, $player/temp)
			await get_tree().create_timer(0.4).timeout
			not_now = 1
			player.no_move = 0
			

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


func picked(atom):
	match atom:
		"oxygen2":
			oxygen2()

func oxygen2():
	refresh_oxygen(1)
	if first_ox:
		first_ox = 0
		sp("", 1)
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
