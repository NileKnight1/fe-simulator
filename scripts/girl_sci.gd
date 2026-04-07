extends Node2D


@onready var chat = $gui/Label
@onready var girl = $AnimatableBody2D2/AnimatedSprite2D

var not_now = 1
var cur = 0
var temp_op = 1
var next_message

func _ready() -> void:
	#sp("", "Hey ...", "Uhm!")
	not_now = 0
	pass

func _process(delta: float) -> void:
	pass

func sp(msg, co):
	chat.text = msg
	if co == 1:  chat.add_theme_color_override("font_color", Color("39a8c4"))
	elif co == 2: chat.add_theme_color_override("font_color", Color("ff3da6"))
	elif co == 3: chat.add_theme_color_override("font_color", Color("cbb95a"))
	am.ps("chat")

	


func scene():
	cur += 1
	match cur:
		1: sp("Hello.", 3)
		2: sp("Hello.", 2)
		3: sp("Can I know your name?", 3)
		4: sp("I'm Stephanie.", 2)
		5: sp("I hope you're doing good Stephanie.", 3)
		6: sp("Thank you.", 2)
		7: sp("We're working on a new dish .. Would you like to be the first tester?", 3)
		8: sp("Really!", 2)
		9: 
			sp("Yes .. Here you are.", 3)
			$spinach.visible = 1
		10: get_tree().change_scene_to_file("res://scenes/eated.tscn")
		
		
		
		
		
		
		
		
		



func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		if not_now: return
		print(cur)
		scene()
	
