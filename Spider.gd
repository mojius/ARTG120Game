extends Area2D

var isItem = false
var isNPC = true
var isTalking = false
var killbox = false
var NPCname = "spider"
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
	
	textbox.queue_text("OH, FOXY, IT'S YOU!!")
	textbox.queue_text("MY BABIES HAVE GONE MISSING.")
	textbox.queue_text("NOT SUPER CONCERNED ABOUT IT, BUT I'D LIKE SOME HELP FINDING THEM.")
	textbox.queue_text("IT'S BEEN WARM WEATHER AS OF LATE. VERY STRANGE.")
	textbox.queue_text("OPEN SEASON ON THE BOXELDER BUGS, AT LEAST.")
	textbox.queue_text("GO WEST AND FIND MY BABIES.")
	textbox.queue_text("TAKE THE PARACHUTE TO HELP YOU FIND THEM.")
	textbox.queue_text("I WOVE IT JUST FOR YOU, FOXY!")
	textbox.queue_text("PRESS CTRL TO GLIDE.")

func endDialog():
	textbox.queue_text("MY LEGS, YOU DID IT!!")
	textbox.queue_text("EVERY SPIDER IN THE FOREST IS IN YOUR DEBT.")
	textbox.queue_text("C'MERE, BABIES. LET'S ALL GO EAT SOME BOXELDER BUGS.")
	pass
