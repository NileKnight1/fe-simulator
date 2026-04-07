extends Node2D


@onready var chat = $gui/Label
@onready var option1 = $Control/Control/option1
@onready var option2 = $Control/Control/option2
@onready var girl = $AnimatableBody2D2/AnimatedSprite2D

var not_now = 1
var cur = 0
var temp_op = 1
var next_message

func _ready() -> void:
	#sp("", "Hey ...", "Uhm!")
	pass

func _process(delta: float) -> void:
	pass

func sp(msg, co):
	chat.text = msg
	if co == 1:  chat.add_theme_color_override("font_color", Color("39a8c4"))
	else: 
		chat.add_theme_color_override("font_color", Color("ff3da6"))
		am.ps("chat")
	
	
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
			opp(op, "Hi!", "What?")
			girl.flip_h = 1
			girl.offset.x = 0
		2:
			not_now = 1
			sp(next_message, 2)
			show_op()
			opts("What's time now?", "You're beautiful.")
		3:
			opp(op, "Don't you have a watch!", "Yes I know that.")
			temp_op = op
		4:
			if temp_op == 1:
				not_now = 1
				sp(next_message, 2)
				show_op()
				opts("I have but when I saw you I lost myself.", "Nevermind.")
			else:
				sp("Yes I know that.", 2)
				scene(1)
		6:
			sp("I'm going", 2)
			
		7:
			girl.visible = 0
			sp("Bruh.", 1)
		8:
			get_tree().change_scene_to_file("res://scenes/phone.tscn")




func _on_option_1_pressed() -> void: 
	scene(1)
	sp(option1.text, 1)
	hide_op()
	not_now = 0
	am.ps("click")
	
func _on_option_2_pressed() -> void: 
	scene(2)
	sp(option2.text, 1)
	hide_op()
	not_now = 0
	am.ps("click")
	
	
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if not_now: return
		print(cur)
		scene(1)
	
