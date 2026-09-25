extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	var stream = load("res://audio/Background.mp3") 
	
	if stream != null:
		music_player.stream = stream
		
		music_player.volume_db = -20.0
		
		music_player.autoplay = true
		music_player.play()
		print("Global background music initialized successfully.")
	else:
		print("WARNING: GlobalMusic could not load your audio file! Check your file path string.")
