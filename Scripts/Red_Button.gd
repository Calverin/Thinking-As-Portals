extends Area2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var win_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for body in get_overlapping_bodies():
		if (body.name == "Box"):
			#print("button pressed")
			animated_sprite.play("button pressed")
			win_timer += 2
		else:
			if win_timer > 0:
				win_timer -= 1
			animated_sprite.play("default")
	if win_timer > 100:
		$"../GUI".next_level_screen() # Load next level screen
		$"../Blue Portal".active = false
		$"../Orange Portal".active = false
	
