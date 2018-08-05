extends TextureButton

func _ready():
	set_process_input(true)

func _pressed():
	Audio.play("Button_Click")
	self.get_parent().pressed()