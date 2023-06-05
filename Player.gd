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
const WALL_SLIDE_SPEED = 20

#Float variables
const FLOAT_DECEL = 40
var isFloating = false

#Rock Smash Variables
const dashSpeed = 550
const dashLength = 0.1
var objectToCheck

@onready var dash = $Dash

#Item Collection Variables
var hasAcorn = false
var hasSack = false
var hasScratcher = false

#can do ability
var canFloat = true
var CAN_WALL_JUMP = true
var canRockSmash = true

# BUGS #
# Fast wall climb
# If you mess around a wall while floating it sometimes keeps you in a 
#....glide state even if your not pressing ctrl, pressing ctrl undoes it

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && not is_on_wall_only():
		velocity.y += GRAVITY * delta 
		NUM_JUMPS = NUM_JUMPS - 1
	
	
	
	if Input.is_action_just_pressed("Dash") && not is_on_floor() && canRockSmash:
			dash.startDash(dashLength)
			$RayCast2D.enabled = true
			if dash.isDashing():
				velocity.y = dashSpeed
				
		
		
	if not is_on_floor():
		if Input.is_action_pressed("Float") && canFloat:
			$PlayerSprite.play("Glide")
			isFloating = true
		else:
			isFloating = false
		if isFloating && velocity.y >= 0:
			velocity.y = FLOAT_DECEL 
	
	walk = WALK_FORCE * (Input.get_action_strength("Right") - Input.get_action_strength("Left")) 
	if is_on_floor():
		CAN_JUMP = true
		NUM_JUMPS = MAX_NUM_JUMPS
		$RayCast2D.enabled = false
	# Handle Jump.
	if Input.is_action_just_pressed("Jump"): 
		if CAN_JUMP == true && NUM_JUMPS > 0:
			velocity.y = -JUMP_VELOCITY
			NUM_JUMPS = NUM_JUMPS - 1
			if is_on_wall() && CAN_WALL_JUMP && Input.is_action_pressed("Right"):
				velocity.x = -WALK_MAX_SPEED
			elif is_on_wall() && CAN_WALL_JUMP && Input.is_action_pressed("Left"):
				velocity.x = WALK_MAX_SPEED
	
	if velocity.y < 0 and Input.is_action_just_pressed("Jump"):
		$PlayerSprite.play("Jump")
	elif !is_on_floor() and !isFloating:
		$PlayerSprite.play("Fall")
		$PlayerSprite/GPUParticles2D.emitting = false
		
	
	if Input.is_action_just_released("Jump"): 
		jump_cut()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right") 
	
	if direction > 0 or direction < 0:
		$PlayerSprite.scale.x = direction
	
	if direction:
		velocity.x += walk * delta
		
	else:
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		
	
	
	if direction and is_on_floor():
		$PlayerSprite.play("Run")
		$PlayerSprite/GPUParticles2D.emitting = true
	elif is_on_floor():
		$PlayerSprite.play("Still")
		$PlayerSprite/GPUParticles2D.emitting = false
		
	if !is_on_floor() and $PlayerSprite.is_playing() and $PlayerSprite.animation == ("Run"):
		$PlayerSprite.stop()
		$PlayerSprite/GPUParticles2D.emitting = false

	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	
	move_and_slide()
	
	#Wall Slide/Jump Detection
	if is_on_wall_only() && CAN_WALL_JUMP && (Input.is_action_pressed("Right") || Input.is_action_pressed("Left")): 
		CAN_JUMP = true
		NUM_JUMPS = MAX_NUM_JUMPS
		$PlayerSprite.play("WallGrab")
		if velocity.y >= 0:
			velocity.y = WALL_SLIDE_SPEED
		else:
			velocity.y += GRAVITY * delta
	else:
		velocity.y += GRAVITY * delta
		
	
	
	
	if $RayCast2D.is_colliding():
		print("colliding")
		objectToCheck = $RayCast2D.get_collider()
		if objectToCheck.is_in_group("Breakable"):
			objectToCheck.destroy()
			velocity.y = -300



func jump_cut():
	if velocity.y < -100:
		velocity.y = -100

func reset():
	position = $"../ResetPosition".position
	
func ready():
	var spider = $"Animals/Spider"

func _on_item_collect_area_area_entered(area):
	if area.isItem == true:
		if area.itemName == "acorn":
			hasAcorn = true
			area.collect()
		elif area.itemName == "sack":
			hasSack = true
			area.collect()
		elif area.itemName == "scratcher":
			hasScratcher = true
			area.collect()
	if area.isNPC == true:
		if area.NPCname == "bear":
			if hasScratcher:
				area.goodDialog()
			else:
				area.questDialog()
		if area.NPCname == "spider":
			if hasSack:
				area.goodDialog()
			else:
				area.questDialog()
		if area.NPCname == "squirrel":
			if hasAcorn:
				area.goodDialog()
			else:
				area.questDialog()
	if area.killbox == true:
		$AnimationPlayer.play("reset")
