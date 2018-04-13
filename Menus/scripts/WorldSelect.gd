extends Node2D

var _items = []

func items():
	if _items.size() > 0 and (typeof(_items[0]) == typeof("")):
		for i in range(_items.size()):
			_items[i] = get_node(_items[i])
	return _items