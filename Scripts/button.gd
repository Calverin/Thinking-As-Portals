extends RigidBody2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_box_play_animation(bool):
	if (bool == true):
		animated_sprite.play("button pressed")
	elif(bool == false):
		animated_sprite.play("default")
