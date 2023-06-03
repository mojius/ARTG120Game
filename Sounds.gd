extends Node

@export var walkSoundFrameStart = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../PlayerSprite".is_playing() and $"../PlayerSprite".animation == "Run" and $"../PlayerSprite".frame == walkSoundFrameStart:
		$AudioStreamPlayer2D.play()
