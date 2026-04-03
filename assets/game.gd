extends Node2D


@onready var sell_button = $gui/sell

@onready var sell_button_text = $gui/sell/Label

@onready var inventory = $gui/inventory
@onready var currency_label = $gui/currency
#@onready var timer1 = $map/chests/timer1
#@onready var chest = $map/chests/chest

@onready var chests = $map/chests

@onready var player = $player1
@onready var player2 = $player2

@onready var camera = $player1/Camera2D
@onready var camera2 = $player2/Camera2D

@onready var workers = $map/workers
@onready var houses = $map/tilemaps/houses
@onready var taskbar = $gui/taskbar

@onready var cooldown = $player1/cooldown
@onready var hearts = $gui/hearts
@onready var hearts_cooldown = $player1/hearts
@onready var cats = $cats

@onready var cats_att = $cats_att
@onready var cats_time_left = $gui/timer

@onready var cat_scene = preload("res://objects/cat.tscn")
@onready var cat_script = preload("res://scripts/cat.gd")

@onready var house_ = $house/Node2D

@onready var house_0 = $house/Node2D/back/Label
@onready var house_1 = $"house/Node2D/workers/Label"
@onready var house_2 = $"house/Node2D/Weapons/Label"

@onready var w0 = $house/Node2D/weapons_list/back2/Label
@onready var w1 = $house/Node2D/weapons_list/w1/Label
@onready var w2 = $house/Node2D/weapons_list/w2/Label
@onready var w3 = $house/Node2D/weapons_list/w3/Label
@onready var w4 = $house/Node2D/weapons_list/w4/Label

@onready var weapons_list = $house/Node2D/weapons_list
@onready var workers_list = $house/Node2D/workers_list
@onready var worker_info = $house/Node2D/worker_info
@onready var health_list = $house/Node2D/health_list


@onready var houseb1 = $house/Node2D/back
@onready var houseb2 = $house/Node2D/workers
@onready var houseb3 = $house/Node2D/Weapons
@onready var houseb4 = $house/Node2D/Health


var play_pos
var cats_num = 0
var killed_cats_all = 0
var killed_cats = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#cooldown.start()
	refresh_health()
	
	
	
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		$gui/mobile.visible = 1

	
	
	
	#print(workers)
	#chests.start()
	#print("bruhhhh")
	#print(sell_button_text.position.y)
	#
	#start_game()
	#start_game()
	#start_game()
	#start_game()
	#start_game()
	#
	start_game()
	
	
	#spawn_cat()
	#spawn_cat()
	
	
	
	player2.no_move = 1

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(chest1.is_ready)
	#print(player.position)
	#play_pos = player.position
	#print(cooldown.wait_time)
	
	var rem = int(cats_att.time_left)
	var min = str(rem / 60)
	var sec = str(rem % 60)
	#
	#if(rem < 119):
		#title.hide()
	#
	
	if (rem == 13):
		$sounds/countdown.play()
		
	if(int(sec)>9):
		cats_time_left.text = "0" + min + ":" + sec
	else:
		cats_time_left.text = "0" + min + ":0" + sec
		
	
	
	pass

func start_game():
	#print("Mhm")
	
	chests.get_child(global.workers_count).start()
	chests.get_child(global.workers_count).visible = 1
	for j in chests.get_child(global.workers_count).cols:
		j.set_deferred("disabled", 0)
		
	houses.get_child(global.workers_count).enabled = 1
	
	global.workers_count = 1

	


func add_worker():
	chests.get_child(global.workers_count).start()
	chests.get_child(global.workers_count).visible = 1
	for j in chests.get_child(global.workers_count).cols:
		j.set_deferred("disabled", 0)
		
	houses.get_child(global.workers_count).enabled = 1

	global.workers_count += 1
	

func refresh_health():
	
	for i in range(global.player_health):
		
		hearts.get_child(i).visible = 1
		hearts.get_child(i).play("true")
		
		if(player.health <= i):
			hearts.get_child(i).play("false")
			
	
	




func _on_area_2d_body_entered(body: Node2D) -> void:
	sell_button.visible = 1
	click()

func _on_area_2d_body_exited(body: Node2D) -> void:
	sell_button.visible = 0
	if(inventory.inventory_opened == 2):
		inventory.inventory_opened = 0
		inventory.inventory.visible = 0



func get_chest(index):
	#print(workers)
	workers.get_child(index).start()

func back(index):
	workers.get_child(index).worker_back()


#func _on_timer_1_timeout() -> void:
	#chest1.play("open")
	#pass


func _on_house_body_entered(body: Node2D) -> void:
	player.no_move = 1
	camera.enabled = 0
	camera2.enabled = 1
	click()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/node_2d.tscn")


func _on_back_pressed() -> void:
	camera.enabled = 1
	camera2.enabled = 0
	player.no_move = 0
	player.position.x = 76
	player.position.y = -68
	click()
	
	


func _on_add_pressed() -> void:
	add_worker()



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("t1"):
		taskbar.get_child(0).button_pressed = 1
		$player1/hand.texture = taskbar.get_child(0).get_child(0).texture
		
	elif Input.is_action_just_pressed("t2"):
		taskbar.get_child(1).button_pressed = 2
		$player1/hand.texture = taskbar.get_child(1).get_child(0).texture
			
	elif Input.is_action_just_pressed("t3"):
		taskbar.get_child(2).button_pressed = 3
		$player1/hand.texture = taskbar.get_child(2).get_child(0).texture
			
	if Input.is_action_just_pressed("action") and not get_viewport().gui_get_hovered_control():
		check_hit_on_cats()
		_hit()


func _on_sell_button_down() -> void:
	sell_button_text.position.y = 280
	#print(sell_button_text.position.y)
	pass
	
func _on_sell_button_up() -> void:
	sell_button_text.position.y = 242
	#print(sell_button_text.position.y)
	pass
	


func _on_button_1_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$player1/hand.texture = taskbar.get_child(0).get_child(0).texture
		
		for i in taskbar.get_children():
			if(i.get_index() == 0): continue
			i.button_pressed = 0

func _on_button_2_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$player1/hand.texture = taskbar.get_child(1).get_child(0).texture
		
		for i in taskbar.get_children():
			if(i.get_index() == 1): continue
			i.button_pressed = 0

func _on_button_3_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$player1/hand.texture = taskbar.get_child(2).get_child(0).texture
		
		for i in taskbar.get_children():
			if(i.get_index() == 2): continue
			i.button_pressed = 0



func _hit():
	if cooldown.time_left: return
	$sounds/whip.play()
	
	cooldown.start(0.5)
	
	player.get_node("hand").position.y += 3
	await get_tree().create_timer(0.1).timeout
	player.get_node("hand").position.y -= 3
		


func hit(cat):
	print("Im here")
	
	if inventory.inventory_opened: return
	#print(2)
	
	if cooldown.time_left: return
	_hit()
	#print(3)
	#if cooldown.time_left: return

	print(cat.hitbox)
	
	if(!cat.hitbox): return
	
	
	for i in taskbar.get_children():
		if i.button_pressed && i.get_child(1).text == "Weapon":
			cat.health -= 1
			break

	if(!cat.health):
		cat.queue_free()



func player_hit():
	
	if hearts_cooldown.time_left: return
	$sounds/bite.play()
	player.health -= 1
	if player.health == 0:
		print("Dead")
		global.workers_count = 0
		global.currency = 0
		
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		return
		
	hearts_cooldown.start()
	refresh_health()
	#
	#for i in range(3-player.health):
		#hearts.get_child(i).play("false")

func spawn_cat(x, y):
	var new_cat = cat_scene.instantiate()
	#print("Hi")
	new_cat.set_script(cat_script)
	cats.add_child(new_cat)
	
	new_cat.position = Vector2(x, y)
	

func _on_cats_att_timeout() -> void:
	cats_attack()
	$sounds/raid.play()
	
	
	
func cats_attack():
	cats_num += 2
	
	for i in range(cats_num):
		spawn_cat(
		randi_range(-470, -315),
		randi_range(-66, 271)
		)

func check_hit_on_cats():
	if inventory.inventory_opened: return
	if cooldown.time_left: return
	
	_hit()
	
	for cat in cats.get_children():
		if cat.hitbox:
			for i in taskbar.get_children():
				if i.button_pressed && i.get_child(1).text == "Weapon":
					$sounds/hit.play()
					
					cat.health -= i.get_child(1).light_mask
					if cat.health <= 0:
						cat.queue_free()
						$sounds/kill.play()
						killed_cats_all += 1
						killed_cats += 1
						if killed_cats == cats_num:
							killed_cats = 0
							cats_att.start()
							global.update_currency(30*cats_num)
							inventory.refresh_currency()
							
					break
			break
	


func _on_add_worker_button_up() -> void:
	house_1.position.y = 275
func _on_add_worker_button_down() -> void:
	house_1.position.y = 330
func _on_weapons_button_down() -> void:
	house_2.position.y = 330
func _on_weapons_button_up() -> void:
	house_2.position.y = 275


func _on_workers_pressed() -> void:
	click()
	houseb1.visible = 0
	houseb2.visible = 0
	houseb3.visible = 0
	houseb4.visible = 0
	
	worker_info.visible = 0
	health_list.visible = 0
	workers_list.visible = 1
	
	for i in range(min(global.workers_count+1, 6)):
		workers_list.get_child(i).disabled = 0
		
		
var current_worker_upgrade = 0

func _on_worker1_pressed() -> void: worker_upgrades(0); click()
func _on_worker2_pressed() -> void: worker_upgrades(1); click()
func _on_worker3_pressed() -> void: worker_upgrades(2); click()
func _on_worker4_pressed() -> void: worker_upgrades(3); click()
func _on_worker5_pressed() -> void: worker_upgrades(4); click()
func _on_worker6_pressed() -> void: worker_upgrades(5); click()

func worker_upgrades(num):
	current_worker_upgrade = num
	
	workers_list.visible = 0
	worker_info.visible = 1
	if(num == global.workers_count):
		worker_info.get_child(0).disabled = 0
		worker_info.get_child(1).disabled = 1
		worker_info.get_child(2).disabled = 1
		worker_info.get_child(3).disabled = 1
	else:
		worker_info.get_child(0).disabled = 1
		worker_info.get_child(1).disabled = 1
		worker_info.get_child(2).disabled = 1
		worker_info.get_child(3).disabled = 1
		
		if(global.workers[current_worker_upgrade]["Time"] > 15):
			worker_info.get_child(1).disabled = 0
		if(global.workers[current_worker_upgrade]["Capacity"] < 5):
			worker_info.get_child(2).disabled = 0
		if(global.workers[current_worker_upgrade]["Tier"] < 3):
			worker_info.get_child(3).disabled = 0
		
	
		




func _on_weapons_pressed() -> void:
	click()
	houseb1.visible = 0
	houseb2.visible = 0
	houseb3.visible = 0
	houseb4.visible = 0
	
	weapons_list.visible = 1


func _on_health_list_pressed() -> void:
	click()
	houseb1.visible = 0
	houseb2.visible = 0
	houseb3.visible = 0
	houseb4.visible = 0
	
	health_list.visible = 1
	
	if(player.health == global.player_health):
		health_list.get_child(0).disabled = 1
	else:
		health_list.get_child(0).disabled = 0
	
	if(global.player_health > 6):
		health_list.get_child(1).disabled = 1

func _on_back_2_pressed() -> void:
	click()
	houseb1.visible = 1
	houseb2.visible = 1
	houseb3.visible = 1
	houseb4.visible = 1
	
	weapons_list.visible = 0
	workers_list.visible = 0
	health_list.visible = 0

func _on_back_3_pressed() -> void:
	click()
	workers_list.visible = 1
	worker_info.visible = 0


func _on_w_1_button_up() -> void: w1.position.y = 275
func _on_w_1_button_down() -> void: w1.position.y = 330
func _on_w_2_button_up() -> void: w2.position.y = 275
func _on_w_2_button_down() -> void: w2.position.y = 330
func _on_w_3_button_down() -> void: w3.position.y = 330
func _on_w_3_button_up() -> void: w3.position.y = 275
func _on_w_4_button_down() -> void: w4.position.y = 330
func _on_w_4_button_up() -> void: w4.position.y = 275

func _on_back_2_button_up() -> void:  w0.position.y = 580
func _on_back_2_button_down() -> void: w0.position.y = 610
func _on_back_button_up() -> void: house_0.position.y = 580
func _on_back_button_down() -> void: house_0.position.y = 610

func _on_add_worker_pressed() -> void:
	
	if(global.currency >= 50):
		upgrade()
		global.update_currency(-50)
		inventory.refresh_currency()
		add_worker()
		worker_upgrades(current_worker_upgrade)
	else:
		error()

func _on_speed_worker_pressed() -> void:
	if(global.currency >= 40):
		upgrade()
		global.update_currency(-50)
		inventory.refresh_currency()
		global.workers[current_worker_upgrade]["Time"] -= 15
		worker_upgrades(current_worker_upgrade)
	else: error()
		

func _on_capcity_worker_pressed() -> void:
	if(global.currency >= 100):
		upgrade()
		global.update_currency(-100)
		inventory.refresh_currency()
		global.workers[current_worker_upgrade]["Capacity"] += 1
		worker_upgrades(current_worker_upgrade)
	else: error()

func _on_tier_worker_pressed() -> void: 
	if(global.currency >= 200):
		upgrade()
		global.update_currency(-200)
		inventory.refresh_currency()
		global.workers[current_worker_upgrade]["Tier"] += 1
		worker_upgrades(current_worker_upgrade)
	else: error()




func buy_w(num):
	match num:
		1:
			if global.currency >= 10:
				$sounds/stick.play()
				global.update_currency(-10)
				inventory.refresh_currency()
				inventory._update_inventory("Stick", 1)
			else: error()
		2:
			if global.currency >= 50:
				$sounds/knife.play()

				global.update_currency(-50)
				inventory.refresh_currency()
				inventory._update_inventory("Knife", 1)
			else: error()
		3:
			if global.currency >= 100:
				$sounds/small_axe.play()
				global.update_currency(-100)
				inventory.refresh_currency()
				inventory._update_inventory("Small Axe", 1)
			else: error()
		4:
			if global.currency >= 200:
				$sounds/axe.play()
				global.update_currency(-200)
				inventory.refresh_currency()
				inventory._update_inventory("Axe", 1)
			else: error()
		

func _on_weapon1_pressed() -> void: buy_w(1)
func _on_weapon2_pressed() -> void: buy_w(2)
func _on_weapon3_pressed() -> void: buy_w(3)
func _on_weapon4_pressed() -> void: buy_w(4)



func _on_regen_pressed() -> void:
	if global.currency >= 50:
		upgrade()
		global.update_currency(-50)
		inventory.refresh_currency()
	
		player.health = global.player_health
		refresh_health()
		_on_health_list_pressed()
	else: error()
	#
	#for i in range(3-player.health):
		#hearts.get_child(i).play("false")
	#
	#print(player.health)

func _on_heart_pressed() -> void:
	if global.currency >= 500:
		upgrade()
		global.update_currency(-500)
		inventory.refresh_currency()
		
		global.player_health += 1
		player.health = global.player_health
		refresh_health()
		_on_health_list_pressed()
	else: error()
		
func click(): $sounds/click.play()
func error(): $sounds/error.play()
func upgrade(): $sounds/upgrade.play()
