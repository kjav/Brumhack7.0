extends TextureButton

func _ready():
	set_process_input(true)

func _pressed():
	self.get_parent().pressed()