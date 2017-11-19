extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var _items = ["BeserkerCharacter", "AngelCharacter", "WarriorCharacter"]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func items():
	if typeof(_items[0]) == typeof(""):
		for i in range(_items.size()):
			_items[i] = get_node(_items[i])
	return _items