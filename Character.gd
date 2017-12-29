extends AnimatedSprite

var moving = false
var movement_direction
var original_pos = get_pos()
var target_pos = get_pos()
var alive = true
var health = 3
var strengh = 5

func _ready():
	pass

func turn():
	pass

func attack(character):
	if alive:
		character.takeDamage(1)

func takeDamage(damage):
	self.health -= damage
	if self.health <= 0:
		GameData.characters.erase(self)
		# self.hide()
		# self.queue_free()
		alive = false
		set_animation("death")

func faceDirection(direction):
	if alive:
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
	if (not moving) and alive:
		original_pos = get_pos()
		var attack = false
		faceDirection(direction)
		var pos = original_pos
		pos.x = int(pos.x / 128)
		pos.y = int(pos.y / 128)
		if direction == Enums.DIRECTION.UP:
			pos.y -= 1
		elif direction == Enums.DIRECTION.DOWN:
			pos.y += 1
		elif direction == Enums.DIRECTION.LEFT:
			pos.x -= 1
		elif direction == Enums.DIRECTION.RIGHT:
			pos.x += 1
		target_pos = pos
		target_pos.x *= 128
		target_pos.y *= 128
		var collisions = GameData.charactersAtPos(pos)
		for i in range(collisions.size()):
			if not (collisions[i] == self):
				#should remove some health from them
				print("Attacked", self, collisions[i])
				attack(collisions[i])
				attack = true
		if  !attack and GameData.walkable(pos.x, pos.y):
			if direction == Enums.DIRECTION.UP:
				self.set_animation("walk_up")
			elif direction == Enums.DIRECTION.DOWN:
				self.set_animation("walk_down")
			elif direction == Enums.DIRECTION.LEFT:
				self.set_animation("walk_left")
			elif direction == Enums.DIRECTION.RIGHT:
				self.set_animation("walk_right")
			movement_direction = direction
			moving = true
			return true