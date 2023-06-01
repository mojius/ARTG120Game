extends CharacterBody2D


@export var WALK_FORCE = 1000
const WALK_MAX_SPEED = 125
const STOP_FORCE = 900
const GRAVITY = 400.0
const JUMP_VELOCITY = 220

var walk = 0

var CAN_JUMP = true
var NUM_JUMPS = 0
var MAX_NUM_JUMPS = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.

# Wall jump variables
const WALL_SLIDE_ACCEL = 7.5
const MAX_WALL_SLIDE_SPEED = 120
var CAN_WALL_JUMP = true

#Float variables
const FLOAT_DECEL = 40
#const MAX_FLOAT_DECEL = 35
var isFloating = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if not is_on_floor():
		if Input.is_action_pressed("Float"):
			$PlayerSprite.play("Glide")
			isFloating = true
		if Input.is_action_just_released("Float"):
			isFloating = false
		if isFloating && velocity.y >= 0:
			velocity.y = FLOAT_DECEL #min(velocity.y + FLOAT_DECEL, MAX_FLOAT_DECEL)
	
	walk = WALK_FORCE * (Input.get_action_strength("Right") - Input.get_action_strength("Left")) #"ui_right","ui_left"
	if is_on_floor():
		CAN_JUMP = true
		NUM_JUMPS = MAX_NUM_JUMPS
	# Handle Jump.
	if Input.is_action_just_pressed("Jump"): #ui_accept
		if CAN_JUMP == true && NUM_JUMPS > 0:
			velocity.y = -JUMP_VELOCITY
			NUM_JUMPS = NUM_JUMPS - 1
			if is_on_wall() && CAN_WALL_JUMP && Input.is_action_pressed("Right"): #"ui_right"
				velocity.x = -WALK_MAX_SPEED
				NUM_JUMPS = NUM_JUMPS - 1
			elif is_on_wall() && CAN_WALL_JUMP && Input.is_action_pressed("Left"): #"ui_left"
				velocity.x = WALK_MAX_SPEED
				NUM_JUMPS = NUM_JUMPS - 1
	
	if velocity.y < 0 and Input.is_action_just_pressed("Jump"):
		$PlayerSprite.play("Jump")
	elif !is_on_floor() and !isFloating:
		$PlayerSprite.play("Fall")
		
	
	if Input.is_action_just_released("Jump"): #ui_accept
		jump_cut()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right") #"ui_left", "ui_right"
	
	if direction > 0 or direction < 0:
		$PlayerSprite.scale.x = direction
	
	if direction:
		velocity.x += walk * delta
	else:
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		

	if direction and is_on_floor():
		$PlayerSprite.play("Run")
	elif is_on_floor():
		$PlayerSprite.play("Still")
		
	if !is_on_floor() and $PlayerSprite.is_playing() and $PlayerSprite.animation == ("Run"):
		$PlayerSprite.stop()

	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	
	move_and_slide()
	
	#Wall Slide/Jump Detection
	if is_on_wall_only() && CAN_WALL_JUMP && (Input.is_action_pressed("Right") || Input.is_action_pressed("Left")): #"ui_left", "ui_right"
		CAN_JUMP = true
		NUM_JUMPS = MAX_NUM_JUMPS
		$PlayerSprite.play("WallGrab")
		if velocity.y >= 0:
			velocity.y = min(velocity.y - WALL_SLIDE_ACCEL, MAX_WALL_SLIDE_SPEED)
		else:
			velocity.y += GRAVITY * delta
	else:
		velocity.y += GRAVITY * delta

func jump_cut():
	if velocity.y < -100:
		velocity.y = -100

