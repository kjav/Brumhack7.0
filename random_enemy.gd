extends "Character.gd"

var attack

func _ready():
	set_process(true)
	GameData.characters.append(self)

func turn():
	movement_direction = randi()%4
	moving = moveDirection(movement_direction)

func _process(delta):
	if moving:
		if movement_direction == Enums.DIRECTION.LEFT:
			self.set_pos(get_pos() + Vector2(-128 * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			self.set_pos(get_pos() + Vector2(128 * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.UP:
			self.set_pos(get_pos() + Vector2(0, -128 * (delta / 0.4)))
		elif movement_direction == Enums.DIRECTION.DOWN:
			self.set_pos(get_pos() + Vector2(0, 128 * (delta / 0.4)))
		if get_pos().distance_to(original_pos) >= 128:
			if movement_direction == Enums.DIRECTION.LEFT:
				set_pos(original_pos + Vector2(-128, 0))
			elif movement_direction == Enums.DIRECTION.RIGHT:
				set_pos(original_pos + Vector2(128, 0))
			if movement_direction == Enums.DIRECTION.UP:
				set_pos(original_pos + Vector2(0, -128))
			elif movement_direction == Enums.DIRECTION.DOWN:
				set_pos(original_pos + Vector2(0, 128))
			moving = false
			original_pos = get_pos()