extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var vector = get_viewport().get_rect().size
	print(vector)
	var target = get_node("Background")
	var scale = vector.y / target.get_size().y
	target.set_scale(Vector2(scale, scale))
	pass
