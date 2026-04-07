extends Node

var music = {
	"birds": preload("res://audio/birds.mp3"),
	"countdown": preload("res://audio/countdown.mp3"),
	"night": preload("res://audio/night.mp3"),
	"fluid": preload("res://audio/fluid.mp3")
}

var sfx = {
	"chat": preload("res://audio/chat.mp3"),
	"close": preload("res://audio/close.mp3"),
	"click": preload("res://audio/click.wav"),
	
	"collect": preload("res://audio/collect.mp3"),
	
	"disappear": preload("res://audio/dissapear.mp3"),
	"eating": preload("res://audio/eating.mp3"),
	"gun": preload("res://audio/gun.mp3"),
	"heal": preload("res://audio/heal.mp3"),
	"macro": preload("res://audio/macro.mp3"),
	"message": preload("res://audio/message.mp3"),
	"rust": preload("res://audio/rust.mp3"),
	"stomach": preload("res://audio/stomach.mp3"),
	"shield_off": preload("res://audio/shield off.mp3"),
	"shield": preload("res://audio/shield.mp3"),
	"sparkle": preload("res://audio/sparkle.mp3"),
	"sudden": preload("res://audio/sudden.mp3"),
	"vomiting": preload("res://audio/vomitting.mp3"),
	"whoosh": preload("res://audio/whoosh.mp3"),
	"win": preload("res://audio/win.mp3"),
	"error": preload("res://audio/error.wav"),
	"phone": preload("res://audio/phone.wav")
}

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)

func pm(name: String):
	if music.has(name):
		var stream = music[name]
		
		if stream is AudioStreamMP3:
			stream.loop = true
		
		music_player.stream = stream
		music_player.play()
		

func ps(name: String):
	if sfx.has(name):
		var player = AudioStreamPlayer.new()
		player.stream = sfx[name]
		add_child(player)
		player.play()
		player.finished.connect(player.queue_free)
