extends Area2D

var isItem = false
var isNPC = true
var NPCname = "spider"

var textDis = ""

func _process(_delta):
	$RichTextLabel.text = textDis
	
	if has_overlapping_areas():
		$RichTextLabel.visible = true

func goodDialog():
	textDis = "Thank you for finding my babies little fox"
	


func questDialog():
	textDis = "I lost my babies somewhere in the forest can you help me"
	
