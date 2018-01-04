extends "Character.gd"

signal healthChanged(change, value)

var time_elapsed = 0
var attack
var maxHealth

func _ready():
	set_process(true)
	EventListener.listen("SwipeCommand", funcref(self, "swiped"))
	maxHealth = health
	GameData.player = self
	GameData.characters.append(self)

func swiped(direction):
	if not moving:
		time_elapsed = 0
		moveDirection(direction)
		for i in range(GameData.characters.size()):
			if i < GameData.characters.size():
				GameData.characters[i].turn()

func _process(delta):
	if moving:
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
		if time_elapsed >= 0.4:
			if movement_direction == Enums.DIRECTION.LEFT:
				set_pos(original_pos + Vector2(-length, 0))
				set_animation("stand_left")
			elif movement_direction == Enums.DIRECTION.RIGHT:
				set_pos(original_pos + Vector2(length, 0))
				set_animation("stand_right")
			if movement_direction == Enums.DIRECTION.UP:
				set_pos(original_pos + Vector2(0, -length))
				set_animation("stand_up")
			elif movement_direction == Enums.DIRECTION.DOWN:
				set_pos(original_pos + Vector2(0, length))
				set_animation("stand_down")
			moving = false
			time_elapsed = 0
	else:
		time_elapsed += delta
		if time_elapsed >= 1:
			# forefit turn
			time_elapsed = 0
			moveDirection(Enums.DIRECTION.NONE)
			for i in range(GameData.characters.size()):
				if i < GameData.characters.size():
					GameData.characters[i].turn()

func takeDamage(damage):
	.takeDamage(damage)
	if self.health <= 0:
		self.hide()
		self.queue_free()
	emit_signal("healthChanged", "Down", -damage)

func heal(amount):
	if self.health < self.maxHealth:
		self.health += amount
		emit_signal("healthChanged", "Up", amount)

func increaseMax(amount):
	self.maxHealth += amount
	emit_signal("healthChanged", "Max", 0)
