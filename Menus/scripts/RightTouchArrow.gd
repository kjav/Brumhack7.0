extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here2
	pass

func _input_event(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed):
		self.get_parent().right()