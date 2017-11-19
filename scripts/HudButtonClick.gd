extends TextureButton
const InventoryType = preload("res://Inventory.tscn")

func _pressed():
	if !get_tree().get_current_scene().inventoryOpen:
		var new_inventory_instance = InventoryType.instance()
		new_inventory_instance.set_pos(Vector2(97, 245))
		new_inventory_instance.setType(self.get_parent().getType())  
		new_inventory_instance.set_name("Inventory")
		get_tree().get_current_scene().add_child(new_inventory_instance)
		new_inventory_instance.populateInventory()
		get_tree().get_current_scene().inventoryOpen = true
	else:
		get_tree().get_current_scene().inventoryOpen = false
		get_tree().get_current_scene().get_node("Inventory").queue_free()