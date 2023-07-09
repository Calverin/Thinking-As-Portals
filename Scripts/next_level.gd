extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self._on_Button_pressed)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when button is pressed.
func _on_Button_pressed():
	if name == "Start Button":
		get_tree().change_scene_to_file("res://Scenes/level1.tscn")
	elif $"../../../../..".name == "LEVEL 1": # I know this is bad
		get_tree().change_scene_to_file("res://Scenes/level2.tscn")
	elif $"../../../../..".name == "LEVEL 2":
		get_tree().change_scene_to_file("res://Scenes/level3.tscn")
