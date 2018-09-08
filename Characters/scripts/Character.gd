extends AnimatedSprite

var moving = false
var movement_direction
var original_pos = get_pos()
var target_pos = get_pos()
var alive = true
var health = 3
var strengh = 5
var damage = 1

const Hitmarker = preload("res://Characters/Hitmarker.tscn")

func _ready():
	original_pos = get_pos()
	target_pos = get_pos()

func turn():
	pass

func attack(character, damage):
	if alive:
		if (character == GameData.player) or (self == GameData.player):
			Audio.playHit()
			character.takeDamage(damage)

func takeDamage(damage):
	self.health -= damage
	if self.health <= 0:
		if(self == GameData.player):
			Audio.playSoundEffect("Player_Death", true)
		else:
			Audio.playSoundEffect("Enemy_Death", true)
		GameData.characters.erase(self)
		# self.hide()
		# self.queue_free()
		alive = false
		set_animation("death")
	var newNode = Hitmarker.instance()
	newNode.set_scale(Vector2(1,1) / (7*self.get_scale()) )
	newNode.setAmount(damage)
	self.add_child(newNode)

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

func setTarget(pos, direction):
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
	return pos

func moveDirection(direction):
	# If not already moving
	if (not moving) and alive:
		original_pos = get_pos()
		var attack = false
		faceDirection(direction)
		var pos = setTarget(pos, direction)
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
		else:
			movement_direction = Enums.DIRECTION.NONE
			moving = false
		moving = true
		return true
