extends RigidBody2D

signal Play_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

var goto_position = null

#func _on_button_area_entered(area):
#	print("button pressed")
	
	
func _process(delta):
	if contact_monitor != null:
		for body in get_colliding_bodies():
			if(body.name == "button"):
				print("button")
				emit_signal("Play_animation",true)
			else:
				emit_signal("Play_animation",false)

func _integrate_forces(state) -> void:
	if goto_position != null:
		var temp_transform = state.get_transform()
		temp_transform.origin = goto_position
		state.set_transform(temp_transform)
		goto_position = null
	set_use_custom_integrator(false)
