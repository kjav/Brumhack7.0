extends TextureButton

func _pressed():
	var parent = self.get_parent()
	parent.queue_free()
	parent.instance.onUse()
	parent.hide()
	#needs to remove from gamedata list
