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
	else: scene2()

func scene():
	cur += 1
	match cur: 
		1: sp("WHERE AM I?", 1)
		2: sp("What do you see?", 2)
		3: sp("WHAT DID YOU DO?", 1)
		4: sp("Answer me!", 2)
		5: sp("What can you see?", 2)
		6: sp("The place is all red.", 1)
		7: sp("IT WORKED", 2)
		8: sp("Is that blood?", 1)
		9: sp("YES.", 2)
		10: sp("You're now in your body .. as an RBC.", 2)
		11: sp("You're crazy.", 1)
		12: sp("I know.", 2)
		13: sp("Try to move", 2)
		14: 
			sp("Okay", 1)
			player.no_move = 0
			not_now = 1
			sceneAuto(2)
		15: sp("Explore the place.", 2)
		

func sceneAuto(t):
		await get_tree().create_timer(t).timeout
		scene()

func _on_run_body_entered(body: Node2D) -> void:
	if body == player: moveRBCs()

func _on_run_2_body_entered(body: Node2D) -> void:
	if body == player: moveMacro()

func _on_area_2d_body_entered(body: Node2D) -> void:
	player.get_child(0).texture = load("res://assets/ir1.png")
	global.scene1_chat = 1
	sp("OMG.", 1)
	player.no_move = 1
	await get_tree().create_timer(2.5).timeout
	
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")

func _on_run3_body_entered(body: Node2D) -> void:
	if !macro_run: return 
	if body == player:
		$map/gate3.visible = 1
		$map/gate3/StaticBody2D7/CollisionShape2D.set_deferred("disabled", 0) 
		$map/gate3/StaticBody2D7/CollisionShape2D2.set_deferred("disabled", 0)
		safe = 1

func moveRBCs():
	$map/gate1.queue_free()
	
	var tween = get_tree().create_tween()
	tween.tween_property($rbcs, "position:x", 3000, 7.0).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(1).timeout
	sp("Run.", 0)
	await get_tree().create_timer(1.5).timeout
	sp("What's going on?", 1)

func moveMacro():
	macro_run = 1
	$map/macrorun.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($macro, "position:x", 2800, 7.5).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(1).timeout
	sp("WOAH.",1)
	

func _on_rbc_chat_body_entered(body: Node2D) -> void:
	if body == player:
		$map/rbcchat.queue_free()
		player.no_move = 1
		not_now = 0
		cur = 0
		$player.position = Vector2(1080,-140)
		
		scene2()

func scene2():
	cur += 1
	
	match cur:
		1: sp("Hello.", 1)
		2: sp("You look new.", 3)
		3: sp("I guess I am.", 1)
		4: sp("Welcome.", 3)
		5: sp("What was that big thing?.", 1)
		6: sp("A macrophage.", 3)
		7: sp("What?", 1)
		8: 
			$macro.visible = 0
			$macro_ex.visible = 1
			#$player/Camera2D.enabled = 0
			#$macro_ex/Camera2D.enabled = 1
			cam_switch($player/Camera2D, $player/macro)
			not_now =1
			await get_tree().create_timer(1).timeout
			sp("A macrophage.", 3)
			not_now =0
			
			
		9: sp("A type of white blood cell that is part of the immune system.", 3)
		10: sp("It protects the body by engulfing and digesting harmful invaders like bacteria.", 3)
		11: sp("It also breaks down old red blood cells, including their hemoglobin, and releases iron for the body to use again.", 3)
		12:
			
			cam_switch($player/Camera2D, $player/temp)
			
			sp("So it breaks you.", 1)
			
		13: 
			sp("WE! You are like us.", 3)
			$macro_ex.visible = 0
			
		14: sp("Oh I am.", 1)
		15: sp("What should we do now?.", 1)
		16: sp("Getting oxygenated.", 3)
		17: sp("Why?", 3)
		18:
			cam_switch($player/Camera2D, $player/rbc)
			$rbc_ex.visible = 1
			not_now =1
			await get_tree().create_timer(1).timeout
			sp("Red Blood Cells", 3)
			not_now =0
		19: sp("Specialized cells that transport oxygen from the lungs to the rest of the body.", 3)
		20: sp("We use hemoglobin to bind oxygen and release it to tissues where it is needed for energy.", 3)
		21: 
			sp("Let's get some oxygens.", 3)
			$rbc_ex.visible = 0
			
			cam_switch($player/Camera2D, $player/temp)
			
		22:
			var tween = get_tree().create_tween()
			tween.tween_property($rbcs, "position:x", 6000, 5.0).set_trans(Tween.TRANS_SINE)
			not_now = 1
			await get_tree().create_timer(3).timeout
			not_now = 0
		23:
			not_now = 1
			player.no_move = 0
			sp("", 1)
		

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
