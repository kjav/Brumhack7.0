extends Node2D

func _ready():
	for i in GameData.placedItems:
		addItem(i)
	GameData.connect("itemDropped", self, "addItem")

func setupConnection():
#todo, need to call this
	GameData.player.connect("itemPickedUp", self, "remove")

func remove(item):
	for i in get_children(): 
		#might get wrong one if two of same type in the same place
		if (i.texture == item.texture and i.get_pos() == item.pos + Vector2(64,64)):
			i.hide()
			i.queue_free()
			break

func addItem(newItem):
	var s = Sprite.new()
	s.set_texture(newItem.texture) 
	s.set_scale(Vector2(2,2))
	s.set_pos(newItem.pos + Vector2(64,64))
	add_child(s)
