extends AnimatedSprite

var moving = false
var movement_direction
var original_pos = get_pos()
var target_pos = get_pos()
var alive = true
var damageable = true
var health = 3
var strengh = 5
var damage = 1

const Hitmarker = preload("res://Characters/Hitmarker.tscn")

func _ready():
	original_pos = get_pos()
	target_pos = get_pos()

func turn():
	pass

func moveDirection(direction):
	if (not moving) and alive:
		original_pos = get_pos()
		movement_direction = Enums.DIRECTION.NONE
		if direction != Enums.DIRECTION.NONE:
			movement_direction = handleMove(direction)
		moving = true
		
		return true

func handleMove(direction):
	#think this is why enemies never use stand animation, face direction has no option for direction.none
	faceDirection(direction)
	var pos = setTarget(direction)
	var attack = handleCollisions(pos)
	if targetWalkable(pos, attack):
		setWalkAnimation(direction)
		
		return direction
	else:
		return Enums.DIRECTION.NONE

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

func setTarget(direction):
	var pos = original_pos
	pos.x = int(pos.x / GameData.TileSize)
	pos.y = int(pos.y / GameData.TileSize)
	pos = getNextTargetPos(pos, direction)
	target_pos = pos
	target_pos.x *= GameData.TileSize
	target_pos.y *= GameData.TileSize
	
	return pos

func getNextTargetPos(pos, direction):
	if direction == Enums.DIRECTION.UP:
		pos.y -= 1
	elif direction == Enums.DIRECTION.DOWN:
		pos.y += 1
	elif direction == Enums.DIRECTION.LEFT:
		pos.x -= 1
	elif direction == Enums.DIRECTION.RIGHT:
		pos.x += 1
	
	return pos

func handleCollisions(pos):
	var attack = false
	var collisions = GameData.charactersAtPos(pos)
	for i in range(collisions.size()):
			if not (collisions[i] == self):
				attack(collisions[i])
				attack = true
	
	return attack

func attack(character, damage):
	if alive:
		if (character == GameData.player) or (self == GameData.player):
			emit_signal("attack", self, damage);
			if (character.damageable):
				Audio.playHit()
				character.takeDamage(damage)

func takeDamage(damage):
	self.health -= damage
	if self.health <= 0:
		handleCharacterDeath()
	createHitmarker()

func handleCharacterDeath():
	playDeathAudio()
	GameData.characters.erase(self)
	alive = false
	set_animation("death")

func playDeathAudio():
	if(self == GameData.player):
		Audio.playSoundEffect("Player_Death", true)
	else:
		Audio.playSoundEffect("Enemy_Death", true)

func createHitmarker():
	var newNode = Hitmarker.instance()
	newNode.set_scale(Vector2(1,1) / (7*self.get_scale()) )
	newNode.setAmount(damage)
	self.add_child(newNode)

func targetWalkable(pos, attack):
	return !attack and GameData.walkable(pos.x, pos.y)

func setWalkAnimation(direction):
	if direction == Enums.DIRECTION.UP:
		self.set_animation("walk_up")
	elif direction == Enums.DIRECTION.DOWN:
		self.set_animation("walk_down")
	elif direction == Enums.DIRECTION.LEFT:
		self.set_animation("walk_left")
	elif direction == Enums.DIRECTION.RIGHT:
		self.set_animation("walk_right")