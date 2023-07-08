extends RigidBody2D

signal Play_animation(bool)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass




func _on_button_area_entered(area):
	print("button pressed")
	
	
func _process(delta):
	for body in get_colliding_bodies():
		if(body.name == "button"):
			print("button")
			emit_signal("Play_animation",true)
		else:
			emit_signal("Play_animation",false)
		
