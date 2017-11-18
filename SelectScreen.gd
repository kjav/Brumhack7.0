extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var items
var current_item = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	items = self.get_parent().items()
	select_item(0)

func left():
	if current_item > 0:
		select_item(current_item - 1)

func right():
	if current_item < items.size() - 1:
		select_item(current_item + 1)

func select_item(item):
	current_item = item
	for i in range(items.size()):
		items[i].set_pos(Vector2(10000, 10000))
	items[current_item].set_pos(Vector2(430, 200))

func selected_item():
	return items[current_item]