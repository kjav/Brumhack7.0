extends TextureButton

func _ready():
	set_process_input(true)

func _pressed():
	Audio.play("Button_Click", true)
	self.get_parent().pressed()