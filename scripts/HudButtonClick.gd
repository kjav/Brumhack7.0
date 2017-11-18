extends TextureButton

const InventoryType = preload("res://Inventory.tscn")

func _pressed():
	self.get_parent().frameStyle
	var new_inventory_instance = InventoryType.instance()
	new_inventory_instance.set_pos(Vector2(97, 245))
	get_tree().get_current_scene().add_child(new_inventory_instance)