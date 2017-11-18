extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input_event(event):
	print(event.type)
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed):
		print("hello hello")
		self.set_pos(self.get_pos() + Vector2(5, 0))