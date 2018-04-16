extends Node2D

var _items = []

func _ready():
	pass

func items():
	if _items.size() > 0 and (typeof(_items[0]) == typeof("")):
		for i in range(_items.size()):
			_items[i] = get_node(_items[i])
	return _items

func _on_changed(index):
	GameData.chosen_map = index