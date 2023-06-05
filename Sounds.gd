extends Node

@export var walkSoundFrameStart = 2
var playedFloat = false

var playedSound = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $"../PlayerSprite".is_playing() and $"../PlayerSprite".animation == "Run" and $"../PlayerSprite".frame == walkSoundFrameStart and playedSound == false:
		$AudioStreamPlayer.play()
		playedSound = true
	elif playedSound == true and $"../PlayerSprite".animation == "Run" and $"../PlayerSprite".frame != walkSoundFrameStart:
		playedSound = false
		
	if $"..".isFloating and !playedFloat:
		$GlidingSound.play()
		playedFloat = true
	elif !$"..".isFloating or $"..".is_on_floor() or $"..".is_on_wall():
		$GlidingSound.stop()
		playedFloat = false

