extends CharacterBody2D


@export var WALK_FORCE = 1000
const WALK_MAX_SPEED = 125
const STOP_FORCE = 900
const GRAVITY = 400.0
const JUMP_VELOCITY = 200

var walk = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	
	walk = WALK_FORCE * (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -JUMP_VELOCITY

	if Input.is_action_just_released("ui_accept"):
		jump_cut()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction > 0 or direction < 0:
		$PlayerSprite.scale.x = direction
	
	if direction:
		velocity.x += walk * delta
	else:
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)

	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	
	move_and_slide()

func jump_cut():
	if velocity.y < -100:
		velocity.y = -100
