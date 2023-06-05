extends CanvasLayer

const CHAR_READ_RATE = 0.025

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label
@onready var readingSound = $ReadingSound
@onready var endSound = $EndSound
@onready var tween = create_tween()

enum State{
	READY,
	READING,
	FINISHED
}


var current_state = State.READY
var text_queue = []

func _ready():
	print("Starting state: ready")
	hide_textbox()

	# Queueing text used to be here.
	# But you need to do it yourself as soon as the button is spawned.
		
func _process(_delta): 
	match current_state:
		State.READY:
			if (!text_queue.is_empty()):
				display_text()
			else:
				hide_textbox()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				tween.kill()
				end_symbol.text = "v"
				change_state(State.FINISHED)
			if (!readingSound.playing):
				readingSound.play()
				
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)

	

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "-"
	textbox_container.show()
	
func display_text():
	var next_text = text_queue.pop_front()
	change_state(State.READING)
	label.text = next_text
	show_textbox()
	
	tween = create_tween()

	tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).from(0.0)
	tween.connect("finished", on_tween_finished)
	
func on_tween_finished():
	end_symbol.text = "v"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: ready")
		State.READING:
			print("Changing state to: reading")
			readingSound.play()
		State.FINISHED:
			print("Changing state to: finished")
			endSound.play()
