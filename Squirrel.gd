extends Area2D

var isItem = false
var isNPC = true
var killbox = false
var NPCname = "squirrel"
var isTalking = false

@onready var textbox = $Textbox

var dialog = Callable(self, "introDialog")


func _ready():
	pass

func _process(_delta):
	if (textbox.textbox_container.visible == false && textbox.text_queue.is_empty()):
		isTalking = false
	
	if has_overlapping_areas():
		if (Input.is_action_just_pressed("Talk") && (!isTalking)):
			dialog.call()
	
func introDialog():
	isTalking = true
	
	textbox.queue_text("OH! FOXY! FOXY! FOXY!!")
	textbox.queue_text("SPRING IS HERE! SPRING IS HERE!! SPRING IS HERE!!")
	textbox.queue_text("IT'S HERE!! SPRING!!")
	textbox.queue_text("I DUG UP MY ACORN, MY ACORN!!")	
	textbox.queue_text("BUT I LEFT IT UP THERE! IN THE CANOPY, THE CANOPY!!")	
	textbox.queue_text("OH, PLEASE, PLEASE HELP, HELP ME!!!")	
	textbox.queue_text("TAKE MY STICKY PAWS. YOU CAN USE THEM TO CLIMB UP WALLS.")	

func endDialog():
	isTalking = true
	textbox.queue_text("YIPPEE!!!.")
	textbox.queue_text("OH, YIPPEEE YIP YIPPEE!!!")
	textbox.queue_text("YAY YAY YAY!! MY ACORN IS BACK.")
	textbox.queue_text("FOXY! FOXY! COME OVER! COME OVER FOR DINNER!!")
	textbox.queue_text("MEET MY MATE, MY MATE!!")
	textbox.queue_text("AND SQUIRREL JRS. ONE, TWO, THREE, FOUR...")	
	
func _on_area_exited(_area):
	textbox.text_queue.clear()
