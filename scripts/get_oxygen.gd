extends Node2D


@onready var player = $player
@onready var health_bar = $gui/Control/Panel3

var macro_run = 0
var safe = 0
var cur = 0
var not_now = 0


func _ready() -> void:
	global.game_script = self
	player.no_move = 1
	if global.scene1_chat: 
		cur = 16
		player.no_move = 0
	#moveRBCs()
	#print(player.global_position)
	print("started")
	#start_game()
	#death()

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
		1: sp("WHERE AM I?", 1)

func sceneAuto(t):
		await get_tree().create_timer(t).timeout
		scene()
	

func _on_checkpoint_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/get_oxygen.tscn")


func cam_switch(cam1, cam2):
	cam1.zoom = cam2.zoom
	cam1.position = cam2.position
	cam1.rotation = cam2.rotation
	cam1.scale = cam2.scale


func refresh_health(pnt):
	player.health += pnt
	if player.health > global.max_health:
		player.health = global.max_health
	print((float(player.health)/float(global.max_health))*6)
	
	health_bar.scale.x = ((float(player.health)/float(global.max_health))*6)
