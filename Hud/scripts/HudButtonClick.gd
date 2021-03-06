extends TextureButton
signal InventoryOpened(inventory)
const InventoryType = preload("res://Hud/Inventory.tscn")

func _pressed():
    if not get_tree().get_current_scene().get_node("HudNode").inventoryOpen:
        Audio.playSoundEffect("Inventory_Open",true)
        var new_inventory_instance = InventoryType.instance()
        new_inventory_instance.set_pos(Vector2(97, 245))
        new_inventory_instance.setType(self.get_parent().getType())  
        new_inventory_instance.set_name("Inventory")
        get_tree().get_current_scene().get_node("HudNode").get_node("HudCanvasLayer").add_child(new_inventory_instance)
        new_inventory_instance.populateInventory()
        get_tree().get_current_scene().get_node("HudNode").inventoryOpen = true
        emit_signal("InventoryOpened", get_tree().get_current_scene().get_node("HudNode").get_node("HudCanvasLayer").get_node("Inventory"))