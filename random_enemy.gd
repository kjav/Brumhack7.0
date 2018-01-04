extends "Character.gd"

var attack

func _ready():
	set_process(true)
	GameData.characters.append(self)

func turn():
	# Select movement direction towards player
	var pos = original_pos
	pos.x = int(pos.x / 128)
	pos.y = int(pos.y / 128)
	var player_pos = GameData.player.original_pos
	player_pos.x = int(player_pos.x / 128)
	player_pos.y = int(player_pos.y / 128)
	var path = GameData.tilemap.findPath(pos, player_pos)
	var movement_direction_vec2 = path[1] - path[0]
	var movement_direction = Enums.DIRECTION.NONE
	if movement_direction_vec2.x == 1:
		movement_direction = Enums.DIRECTION.RIGHT
	elif movement_direction_vec2.x == -1:
		movement_direction = Enums.DIRECTION.LEFT
	elif movement_direction_vec2.y == 1:
		movement_direction = Enums.DIRECTION.DOWN
	elif movement_direction_vec2.y == -1:
		movement_direction = Enums.DIRECTION.UP
	# Select random movement direction
	# movement_direction = randi()%
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