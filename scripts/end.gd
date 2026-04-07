extends Node2D


func sp(msg, co):
	$gui/Label.text = msg
	if co == 1:  $gui/Label.add_theme_color_override("font_color", Color("39a8c4"))
	elif co == 2: $gui/Label.add_theme_color_override("font_color", Color("cbb95a"))
	elif co == 3: $gui/Label.add_theme_color_override("font_color", Color("ff3da6"))


func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	sp("I love you Jack" , 3)
	
	
