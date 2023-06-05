extends Area2D

var isItem = false
var isNPC = true
var NPCname = "bear"

var textDis = ""

func _process(_delta):
	$RichTextLabel.text = textDis
	$Sprite.play("default")
	if has_overlapping_areas():
		$RichTextLabel.visible = true

func goodDialog():
	textDis = "Thank you for finding my back scratcher little fox"
	


func questDialog():
	textDis = "I lost my back scratcher somewhere in the cave can you help me "
	
