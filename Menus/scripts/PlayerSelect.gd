extends Node2D

var _items = ["BeserkerPlayer", "AngelPlayer", "WarriorPlayer"]

func _ready():
	pass

func items():
	if typeof(_items[0]) == typeof(""):
		for i in range(_items.size()):
			_items[i] = get_node(_items[i])
	return _items

func _on_changed(index):
	GameData.chosen_player = index