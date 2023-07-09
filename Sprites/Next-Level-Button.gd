extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.pressed.connect(self._on_Button_pressed)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when button is pressed.
func _on_Button_pressed():
	print("Hello World!")
