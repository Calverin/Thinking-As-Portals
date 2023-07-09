extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var active = false

@onready var sprite = $Sprite2D
@onready var other_portal = $"../Blue Portal" if self.get("name") == "Orange Portal" else $"../Orange Portal"
@onready var entrance = $Entrance
@onready var box_check = $"Box Check"

var tp_cooldown = 10
var good_location = false

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
			# Set facing direction
#			if direction < 0:
#				sprite.flip_h = true
#			else:
#				sprite.flip_h = false
			
			velocity.x = move_toward(velocity.x, direction * SPEED, SPEED / 10)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED / 5)
		
		# Rotation
		var rotate_dir = Input.get_axis("rotate_left", "rotate_right")
		if rotate_dir:
			rotation_degrees = move_toward(rotation_degrees, snapped((rotation_degrees + 90 * rotate_dir), 90), SPEED * 3 * delta)
		else:
			rotation_degrees = move_toward(rotation_degrees, snapped((rotation_degrees), 90), SPEED * delta)
		
		# Switch active portal
		if Input.is_action_just_pressed("switch") and not other_portal.active and not Input.is_action_just_released("switch"):
			Input.action_release("switch")
			other_portal.active = true
			active = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		rotation_degrees = move_toward(rotation_degrees, snapped((rotation_degrees), 90), SPEED * delta)

	if tp_cooldown > 0:
		tp_cooldown -= 1

	move_and_slide()
	
	var pos = other_portal.position
	pos += Vector2(cos(other_portal.rotation), sin(other_portal.rotation)) * 48
	box_check.global_position = pos
				
	if entrance.has_overlapping_bodies():
		for body in entrance.get_overlapping_bodies():
			if body.name == "Box" and tp_cooldown == 0 and not box_check.has_overlapping_bodies(): # and active:
				body.goto_position = pos
				body.set_use_custom_integrator(true)
				tp_cooldown = 10
				other_portal.tp_cooldown = 5

#	for index in get_slide_collision_count():
#		var collision = get_slide_collision(index)
#		if (collision.get_collider().name == "Box") and active and tp_cooldown == 0:
#			var pos = other_portal.position
#
#			if (other_portal.sprite.flip_h == true):
#				pos.x -= 43
#			elif (other_portal.sprite.flip_h == false):
#				pos.x += 43
#			collision.get_collider().goto_position = pos
#			collision.get_collider().set_use_custom_integrator(true)
#			print("tp!")
#			tp_cooldown = 100
#			other_portal.tp_cooldown = 100
