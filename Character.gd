extends Sprite

var time_elapsed = 0
var animation = []
var animation_index = 0
var animation_direction = 1
var movement_direction
var original_pos
var attack

func _ready():
	set_process(true)
	EventListener.listen("SwipeCommand", funcref(self, "moveDirection"))
	original_pos = get_pos()
	set_frame(2)
	GameData.character = self

func _process(delta):
	if animation.size() > 0:
		var length = 128
		time_elapsed = time_elapsed + delta
		if movement_direction == Enums.DIRECTION.LEFT:
			self.set_pos(get_pos() + Vector2(-length * (delta / 0.4), 0))
		elif movement_direction == Enums.DIRECTION.RIGHT:
			self.set_pos(get_pos() + Vector2(length * (delta / 0.4), 0))
		if movement_direction == Enums.DIRECTION.UP:
			self.set_pos(get_pos() + Vector2(0, -length * (delta / 0.4)))
		elif movement_direction == Enums.DIRECTION.DOWN:
			self.set_pos(get_pos() + Vector2(0, length * (delta / 0.4)))
		if time_elapsed > 0.1:
			animation_index += animation_direction
			set_frame(animation[animation_index])
			if animation_index == 0 or animation_index == animation.size() - 1:
				animation_direction = animation_direction * -1
			time_elapsed = 0
			print("Distance moved: ")
			print(get_pos().distance_to(original_pos))
		if get_pos().distance_to(original_pos) >= length:
			if movement_direction == Enums.DIRECTION.LEFT:
				set_pos(original_pos + Vector2(-length, 0))
			elif movement_direction == Enums.DIRECTION.RIGHT:
				set_pos(original_pos + Vector2(length, 0))
			if movement_direction == Enums.DIRECTION.UP:
				set_pos(original_pos + Vector2(0, -length))
			elif movement_direction == Enums.DIRECTION.DOWN:
				set_pos(original_pos + Vector2(0, length))
			animation = []
	else:
		time_elapsed = 0
		animation_index = 0
		animation_direction = 1
		original_pos = get_pos()

func faceDirection(direction):
	if direction == Enums.DIRECTION.UP:
		set_frame(10)
	elif direction == Enums.DIRECTION.DOWN:
		set_frame(1)
	elif direction == Enums.DIRECTION.LEFT:
		set_frame(4)
	elif direction == Enums.DIRECTION.RIGHT:
		set_frame(7)

func moveDirection(direction):
	# If not already moving
	print("moveDirection")
	if animation.size() == 0:
		attack = false
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
		if  !attack and GameData.walkable(pos.x, pos.y):
			movement_direction = direction
			if direction == Enums.DIRECTION.UP:
				animation = [9, 10, 11]
			elif direction == Enums.DIRECTION.DOWN:
				animation = [0, 1, 2]
			elif direction == Enums.DIRECTION.LEFT:
				animation = [3, 4, 5]
			elif direction == Enums.DIRECTION.RIGHT:
				animation = [6, 7, 8]
		
		