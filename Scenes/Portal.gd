extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var active = false

@onready var sprite = $Sprite2D
@onready var other_portal = $"../Blue Portal" if self.get("name") == "Orange Portal" else $"../Orange Portal"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# If this is the active portal, allow movement
	if active:
		# Handle Jump.
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	
		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("left", "right")
		if direction:
			if direction < 0:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
				
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if Input.is_action_just_pressed("switch"):
			active = false
			other_portal.active = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
