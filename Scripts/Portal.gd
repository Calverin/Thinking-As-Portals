extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal Orange_direction(bool)
var blue_direction: bool
var box_posistion

@export var active = false

@onready var sprite = $Sprite2D
@onready var other_portal = $"../Blue Portal" if self.get("name") == "Orange Portal" else $"../Orange Portal"
var other_portal_postion = Vector2.ZERO

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
		var Orange_direction = Input.get_axis("left", "right")
		if Orange_direction:
			# Set facing direction
			if Orange_direction < 0:
				sprite.flip_h = true
				emit_signal("Orange_direction",true)
			else:
				sprite.flip_h = false
				emit_signal("Orange_direction",false)
				
			velocity.x = move_toward(velocity.x, Orange_direction * SPEED, SPEED / 10)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED / 5)
	
		# Switch active portal
		if Input.is_action_just_pressed("switch") and not other_portal.active and not Input.is_action_just_released("switch"):
			Input.action_release("switch")
			other_portal.active = true
			active = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for index in get_slide_collision_count():
		var collision := get_slide_collision(index)
		if (collision.get_collider().name == "Box"):
			other_portal_postion = get_node("/root/ROOT/World/Blue Portal").position
			box_posistion = other_portal_postion
			
			print("the box position is", box_posistion)
			print("the blue portal position is", other_portal_postion)
			print("I collided with ", collision.get_collider().name)
			get_node("/root/ROOT/World/Box").position = box_posistion
			if (blue_direction == true):
				
				get_node("/root/ROOT/World/Box").position.x -= 40
			elif(blue_direction == false):
				get_node("/root/ROOT/World/Box").position.x += 40
		
			
			
func teleport_box(other_portal_postion: Node2D) -> void:
	var box_posistion = get_node("Box")
	box_posistion.position = other_portal_postion.position 


func _on_blue_portal_blue_direction(bool):
	if(bool == true):
		blue_direction = true
	elif(bool == false):
		blue_direction = false
		
