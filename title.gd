extends Node2D

@onready var fadeoutAnim = $Image/FadeOutSprite/AnimationPlayer

func _ready():
	pass

	
func _process(_delta):
	if (Input.is_action_just_pressed("ui_accept")):
		fadeoutAnim.play("new_animation")
		

func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://map.tscn")
