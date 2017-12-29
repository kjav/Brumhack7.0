extends AnimatedSprite

var moving = false
var movement_direction
var health = 3
var strengh = 5

const Hitmarker = preload("res://Hitmarker.tscn")

func _ready():
	pass

func turn():
	pass

func attack(character):
	character.takeDamage(1)
	pass

func takeDamage(damage):
	self.health -= damage
	if self.health <= 0:
		GameData.characters.erase(self)
		self.hide()
		self.queue_free()
	var newNode = Hitmarker.instance()
	newNode.set_scale(Vector2(1,1) / (7*self.get_scale()) )
	newNode.setAmount(damage)
	self.add_child(newNode)

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
		var collisions = GameData.charactersAtPos(pos)
		for i in range(collisions.size()):
			#should remove some health from them
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