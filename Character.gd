extends AnimatedSprite

var moving = false
var movement_direction

func _ready():
	pass

func faceDirection(direction):
	if direction == Enums.DIRECTION.UP:
		set_animation("stand_up")
	elif direction == Enums.DIRECTION.DOWN:
		set_animation("stand_down")
	elif direction == Enums.DIRECTION.LEFT:
		set_animation("stand_left")
	elif direction == Enums.DIRECTION.RIGHT:
		set_animation("stand_right")

func moveDirection(direction):
	# If not already moving
	if not moving:
		var attack = false
		faceDirection(direction)
		var pos = get_pos()
		pos.x = int(pos.x / 128)
		pos.y = int(pos.y / 128)
		print(pos)
		if direction == Enums.DIRECTION.UP:
			pos.y -= 1
		elif direction == Enums.DIRECTION.DOWN:
			pos.y += 1
		elif direction == Enums.DIRECTION.LEFT:
			pos.x -= 1
		elif direction == Enums.DIRECTION.RIGHT:
			pos.x += 1
		for i in range(GameData.enemies.size()):
			if GameData.enemies[i].original_pos.x / 128 == pos.x and GameData.enemies[i].original_pos.y / 128 == pos.y:
				#should remove some health from them
				attack = true
		if direction == Enums.DIRECTION.UP:
			self.set_animation("walk_up")
		elif direction == Enums.DIRECTION.DOWN:
			self.set_animation("walk_down")
		elif direction == Enums.DIRECTION.LEFT:
			self.set_animation("walk_left")
		elif direction == Enums.DIRECTION.RIGHT:
			self.set_animation("walk_right")
		if  !attack and GameData.walkable(pos.x, pos.y):
			movement_direction = direction
			moving = true