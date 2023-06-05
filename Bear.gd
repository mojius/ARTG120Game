extends Area2D

var isItem = false
var isNPC = true
var killbox = false
var NPCname = "bear"
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
	
	textbox.queue_text("HEY, FOX.")
	textbox.queue_text("I KNOW YOU'RE WONDERING WHAT THE HECK I'M DOING.")
	textbox.queue_text("WELL, MY BACK ITCHES!!!")
	textbox.queue_text("NO, DON'T WORRY. THIS ISN'T A YOU-SCRATCH-MY-BACK TYPE DEAL.")
	textbox.queue_text("I KNOW YOU'RE TOO BUSY BEING A TRICKSTER TO BE MY PERSONAL MASSEUSE.")
	textbox.queue_text("BUT HERE'S MY SUPER CLAW. GO USE IT TO FIND MY BACK SCRATCHER!")	

func endDialog():
	isTalking = true
	textbox.queue_text("OHHH, THAT'S A RELIEF.")
	textbox.queue_text("NO MORE ITCHY BACK AT LAST!")
	textbox.queue_text("MRS. BEAR USED TO SCRATCH MY BACK ENOUGH...")
	textbox.queue_text("BUT SHE'S BUSY WITH THE CUBS, YOU KNOW?")
	textbox.queue_text("BUT THAT'S LIFE.")
	textbox.queue_text("THANKS, FOX. THERE'S A FISH IN IT FOR YOU LATER.")	
	

func _on_area_exited(_qarea):
	textbox.text_queue.clear()
