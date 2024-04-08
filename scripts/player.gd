extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var Hold_Y_Data = Vector2.ZERO

@onready var _animated_sprite = $AnimatedSprite2D

func _process(_delta):
#	if not velocity.y > Hold_Y_Data.y:
#		Hold_Y_Data.y = velocity.y
#	else:
#		_animated_sprite.play("falling")
#		Hold_Y_Data.y = velocity.y
	if Input.is_action_pressed("move_right"):
		_animated_sprite.play("run_right")
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.play("run_left")
	else:
		_animated_sprite.play("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
