extends Node

@export var walkSoundFrameStart = 2


var playedSound = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $"../PlayerSprite".is_playing() and $"../PlayerSprite".animation == "Run" and $"../PlayerSprite".frame == walkSoundFrameStart and playedSound == false:
		$AudioStreamPlayer2D.play()
		playedSound = true
	elif playedSound == true and $"../PlayerSprite".animation == "Run" and $"../PlayerSprite".frame != walkSoundFrameStart:
		playedSound =false
