extends TextureButton

const InventoryType = preload("res://Inventory.tscn")
var type

func _pressed():
	print("Potion" + "hudbutton")
	var new_inventory_instance = InventoryType.instance()
	new_inventory_instance.set_pos(Vector2(97, 245))
	new_inventory_instance.setType(self.get_parent());
	get_tree().get_current_scene().add_child(new_inventory_instance)