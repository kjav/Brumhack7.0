extends TextureButton

func _pressed():
	var parent = self.get_parent()
	parent.queue_free()
	parent.hide()
	#needs to activate onconsumption effect
