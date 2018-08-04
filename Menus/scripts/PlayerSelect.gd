extends Node2D

var _item_names = ["BeserkerPlayer", "AngelPlayer", "WarriorPlayer"]
var _items = []

func _ready():
	pass

func items():
	if typeof(_item_names[0]) == typeof(""):
		for i in range(_item_names.size()):
			_items.push_back(get_node(_item_names[i]))
	return _items

func _on_changed(index):
	GameData.chosen_player = _item_names[index]