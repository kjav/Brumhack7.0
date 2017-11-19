extends Sprite

func _ready():
	set_process(true)

func _process():
	var new_frame = self.get_frame() + 1
	if new_frame > 10:
		new_frame = 0
	self.set_frame(new_frame)