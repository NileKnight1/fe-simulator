extends Node2D


@onready var chat = $Control/Label
@onready var option1 = $Control/Control/option1
@onready var option2 = $Control/Control/option2
@onready var sci = $AnimatableBody2D2/AnimatedSprite2D

var not_now = 1
var cur = 0
var temp_op = 1
var next_message

func _ready() -> void:
	#sp("", "Hey ...", "Uhm!")
	#sp("hi", 2)
	pass

func _process(delta: float) -> void:
	pass

func sp(msg, co):
	chat.text = msg
	if co == 1:  chat.add_theme_color_override("font_color", Color("39a8c4"))
	else: chat.add_theme_color_override("font_color", Color("3e2396ff"))
	#option1.text = op1
	#option2.text = op2

func opts(op1, op2):
	option1.text = op1
	option2.text = op2
	
func opp(op, msg1, msg2):
	match op:
		1: next_message = msg1
		2: next_message = msg2

func hide_op():
	option1.visible = 0
	option2.visible = 0

func show_op():
	option1.visible = 1
	option2.visible = 1


func scene(op):
	cur += 1
	
	match cur:
		1:
			opp(op, "Hello.", "I've made a device.")
			sci.flip_h = 1
			sci.offset.x = 0
		2:
			not_now = 1
			sp(next_message, 2)
			show_op()
			opts("Mhm.", "So?")
		3:
			opp(op, "You gonna enter you body.", "You will do it yourself.")
		4:
			not_now = 1
			sp(next_message, 2)
			show_op()
			opts("Huh?", "How?")
		5:
			opp(op, "Using the gun I made,.", "Using the gun I made.")
		6:
			not_now = 1
			sp(next_message, 2)
			show_op()
			opts("Are you crazy?", "Whatever you're saying.")
		7:
			opp(op, "Are you ready?", "Let's go.")
		8:
			$gun.visible = 1
		9: 
			sp("WHAT'S THIS?", 1)
		
		10: 
			sp("Good luck!", 2)
			
		11:
			get_tree().change_scene_to_file("res://scenes/good luck.tscn")




func _on_option_1_pressed() -> void: 
	scene(1)
	sp(option1.text, 1)
	hide_op()
	not_now = 0
	
func _on_option_2_pressed() -> void: 
	scene(2)
	sp(option2.text, 1)
	hide_op()
	not_now = 0
	
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if not_now: return
		print(cur)
		scene(1)
	
