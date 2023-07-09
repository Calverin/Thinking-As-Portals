extends Sprite2D

var move_speed : float = 80.0

@export var move_dir : Vector2

var start_pos : Vector2
var target_pos : Vector2

var openDoor : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = global_position
	target_pos = start_pos + move_dir
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(openDoor == true):
		global_position = global_position.move_toward(target_pos, move_speed * delta)
	else:
		global_position = global_position.move_toward(start_pos, move_speed * delta)
		


func _on_blue_button_open_door(bool):
	if(bool == true):
		openDoor = true
	elif(bool == false):
		openDoor = false
