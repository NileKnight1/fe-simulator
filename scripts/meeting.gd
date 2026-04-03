extends Node2D


@onready var chat = $Control/Label
@onready var option1 = $Control/Control/option1
@onready var option2 = $Control/Control/option2
@onready var girl = $AnimatableBody2D2/AnimatedSprite2D

var not_now = 1
var cur = 0


func _ready() -> void:
	#sp("", "Hey ...", "Uhm!")
	pass

func _process(delta: float) -> void:
	pass

func sp(msg):
	chat.text = msg
	#option1.text = op1
	#option2.text = op2
	
func hide_op():
	option1.visible = 0
	option2.visible = 0

func show_op():
	option1.visible = 1
	option2.visible = 1


func scene(op):
	match cur:
		0:
			match op:
				1: pass
				
				2: pass
					
			girl.flip_h = 1
			girl.offset.x = 0




func _on_option_1_pressed() -> void: 
	scene(1)
	sp(option1.text)
	hide_op()
	not_now = 0
	
func _on_option_2_pressed() -> void: 
	scene(2)
	sp(option2.text)
	hide_op()
	not_now = 0
	
	

func _input(event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("action"):
		if not_now: return
		print("hi")
	
