extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var items
var current_item = 0

var right_arrow
var left_arrow

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	items = self.get_parent().items()
	left_arrow = get_node("LeftArrow")
	right_arrow = get_node("RightArrow")
	if items.size() > 0:
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
	items[current_item].set_pos(Vector2(540, 550))
	
	# Disable arrows if they can't be used
	var leftmost = current_item == 0
	var rightmost = current_item == items.size() - 1
	left_arrow.set_opacity(1 - 0.8 * leftmost)
	right_arrow.set_opacity(1 - 0.8 * rightmost)

func selected_item():
	return items[current_item]