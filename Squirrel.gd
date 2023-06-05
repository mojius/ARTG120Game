extends Area2D

var isItem = false
var isNPC = true
var NPCname = "squirrel"

var textDis = ""

func _process(_delta):
	$RichTextLabel.text = textDis
	
	if has_overlapping_areas():
		$RichTextLabel.visible = true

func goodDialog():
	textDis = "Thank you for finding my acorn little fox"
	


func questDialog():
	textDis = "I lost my acorn somewhere in the trees can you help me"
	
