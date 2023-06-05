extends Area2D

var isItem = false
var isNPC = true
var isTalking = false
var killbox = false
var NPCname = "spider"
@onready var textbox = $Textbox


func _ready():

	pass



func _process(_delta):
	#var textDis = "OH, YOU!!"
	#$RichTextLabel.text = textDis
	
	if (textbox.current_state == textbox.State.FINISHED):
		isTalking = false
	
	if has_overlapping_areas():
		$RichTextLabel.visible = true
		
		if (Input.is_action_just_pressed("Talk") && (!isTalking)):
			talk()
			
			

func goodDialog():
	#textDis = "THANK YOU!!"
	pass
	
func talk():
	isTalking = true
	textbox.queue_text("OH, FOXY, IT'S YOU!!")
	textbox.queue_text("MY BABIES HAVE GONE MISSING.")
	textbox.queue_text("IT'S BEEN WARM WEATHER AS OF LATE. VERY STRANGE.")
	textbox.queue_text("OPEN SEASON ON THE BOXELDER BUGS, AT LEAST.")


func questDialog():
	#textDis = "OH!!"
	pass
