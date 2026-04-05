extends Node2D


@onready var chat = $Control/Label
@onready var option1 = $Control/Control/option1
@onready var option2 = $Control/Control/option2
@onready var objects = $objects

var not_now = 1
var cur = 0
var temp_op = 1

func _ready() -> void:
	#sp("", "Hey ...", "Uhm!")
	pass

func _process(delta: float) -> void:
	pass

func sp(msg, co):
	chat.text = msg
	if co == 1:  chat.add_theme_color_override("font_color", Color("39a8c4"))
	else: chat.add_theme_color_override("font_color", Color("ff3da6"))


func scene():
	cur += 1
	objects.get_child(cur).visible = 1
	
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if not_now: return
		print(cur)
		if cur < 7: 
			scene()
		elif cur == 8:
			sp("Mhm.", 1)
			cur += 1
		else:
			get_tree().change_scene_to_file("res://scenes/later.tscn")
	


func _on_chatgpt_pressed() -> void:
	$messenger.visible = 0
	objects.get_child(0).visible = 1
	not_now = 0
	
