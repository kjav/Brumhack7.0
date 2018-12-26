extends Node2D

const KeyIcon = preload("res://Hud/KeyIcon.tscn")

func AddKey(key):
	KeyAmountChanged()

func KeyAmountChanged():
	for child in get_node("HudCanvasLayer/Keys").get_children():
		child.queue_free()
		child.hide()
	
	var UnlockGuidsFound = []
	
	for key in GameData.keys:
		if !UnlockGuidsFound.has(key.UnlockGuid):
			var new_node = KeyIcon.instance()
			new_node.setTexture(key.texture)
			
			get_node("HudCanvasLayer/Keys").add_child(new_node)
			
			UnlockGuidsFound.append(key.UnlockGuid)