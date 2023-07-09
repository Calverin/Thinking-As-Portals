extends Area2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

signal open_door(bool)


	
func _process(delta):
	for body in get_overlapping_bodies():
		if(body.name == "Box" or  body.name == "Orange Portal" or body.name == "Blue Portal"):
			print("button pressed")
			animated_sprite.play("button_pressed")
			emit_signal("open_door",true)
		else:
			animated_sprite.play("default")
			emit_signal("open_door",false)
	
	

