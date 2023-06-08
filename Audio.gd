extends Node

@onready var CaveMusic = load("res://gameAudio/Foxy Cave.wav")
@onready var ForestMusic = load("res://gameAudio/Foxy_Forest.wav")
@onready var CanopyMusic = load("res://gameAudio/Foxy_Canopy.wav")

@onready var CaveAmbient = load("res://gameAudio/unsplit.wav")
@onready var ForestAmbient = load("res://gameAudio/Forest_Ambient_Cricket_1.wav")
@onready var CanopyAmbient = load("res://gameAudio/Treetop_Ambient_Leaves_rustling.wav")



func _on_forest_area_entered(area):
	$Music.stream = ForestMusic
	$Ambient.stream = ForestAmbient
	$Music.play()
	$Ambient.play()

func _process(_delta):
	if (!$Music.playing):
		$Music.play()
	if (!$Ambient.playing):
		$Ambient.play()


func _on_cave_area_entered(area):
	$Music.stream = CaveMusic
	$Ambient.stream = CaveAmbient
	$Music.play()
	$Ambient.play()


func _on_canopy_area_entered(area):
	$Music.stream = CanopyMusic
	$Ambient.stream = CanopyAmbient
	$Music.play()
	$Ambient.play()
