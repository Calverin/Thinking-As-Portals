extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta


	var collision_data = move_and_collide(velocity * delta)
#	if collision_data:
#		velocity = velocity.bounce(collision_data.get_normal())
#		velocity *= 0.9
