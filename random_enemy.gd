extends AnimatedSprite

var time_elapsed = 0
var movement_direction = -1
var original_pos
var moving = false
var health = 2
var attack

func _ready():
	set_process(true)
	original_pos = get_pos()
	GameData.enemies.append(self)

func _process(delta):
	time_elapsed = time_elapsed + delta
	if not moving:
		if time_elapsed > 2:
			movement_direction = randi()%4
			moving = moveDirection(movement_direction)
			time_elapsed = 0
	else:
		if movement_direction == Enums.DIRECTION.LEFT:
			self.set_pos(get_pos() + Vector2(-128 * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			self.set_pos(get_pos() + Vector2(128 * (delta / 0.4), 0))
		if movement_direction == Enums.DIRECTION.UP:
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

func faceDirection(direction):
	if direction == Enums.DIRECTION.LEFT:
		pass
	elif direction == Enums.DIRECTION.RIGHT:
		pass

func moveDirection(direction):
	faceDirection(direction)
	attack = false
	var pos = get_pos()
	pos.x = int(pos.x / 128)
	pos.y = int(pos.y / 128)
	if direction == Enums.DIRECTION.UP:
		pos.y -= 1
	elif direction == Enums.DIRECTION.DOWN:
		pos.y += 1
	elif direction == Enums.DIRECTION.LEFT:
		self.set_flip_h( true )
		pos.x -= 1
	elif direction == Enums.DIRECTION.RIGHT:
		self.set_flip_h( false )
		pos.x += 1
	for i in range(GameData.enemies.size()):
		if GameData.enemies[i].original_pos.x / 128 == pos.x and GameData.enemies[i].original_pos.y / 128 == pos.y:
			attack = true
	if GameData.character.original_pos.x / 128 == pos.x and GameData.character.original_pos.y / 128 == pos.y:
		attack = true
	if GameData.walkable(pos.x, pos.y) and !attack:
		#should remove some health from them
		return true
	return false