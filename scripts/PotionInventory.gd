extends TextureButton

const InventoryType = preload("res://Inventory.tscn")

func _pressed():
	self.get_parent().frameStyle
	var new_inventory_instance = InventoryType.instance()
	get_tree().get_current_scene().add_child()