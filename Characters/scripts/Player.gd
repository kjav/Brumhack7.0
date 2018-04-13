extends "Character.gd"

signal healthChanged(change, value)
signal weaponChanged(slot, weapon)

var time_elapsed = 0
var attack
var maxHealth
var weapons = preload("res://Items/scripts/Weapons.gd")
var primaryWeapon = weapons.BasicSword.new()
var secondaryWeapon = weapons.BasicShield.new()

func _ready():
	set_process(true)
	EventListener.listen("SwipeCommand", funcref(self, "swiped"))
	maxHealth = health
	GameData.player = self
	GameData.characters.append(self)

func swapWeapons():
	var temp = primaryWeapon
	setPrimaryWeapon(secondaryWeapon)
	setSecondaryWeapon(temp)

func setPrimaryWeapon(weapon):
	primaryWeapon = weapon
	emit_signal("weaponChanged", "Primary", primaryWeapon)
	get_node("PrimaryWeapon").set_texture(primaryWeapon.texture)
	
func setSecondaryWeapon(weapon):
	secondaryWeapon = weapon
	emit_signal("weaponChanged", "Secondary", secondaryWeapon)
	get_node("SecondaryWeapon").set_texture(secondaryWeapon.texture)

func dropWeapon():
	primaryWeapon.place(get_pos())
	primaryWeapon = null

func swiped(direction):
	if not moving:
		time_elapsed = 0
		moveDirection(direction)
		set_weapon_positions(direction)
		for i in range(GameData.characters.size()):
			if i < GameData.characters.size():
				GameData.characters[i].turn()

func attack(character):
	if alive:
		character.takeDamage(primaryWeapon.damage)

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
			elif movement_direction == Enums.DIRECTION.UP:
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
	emit_signal("healthChanged", "Down", -damage)

func heal(amount):
	if self.health < self.maxHealth:
		self.health += amount
		emit_signal("healthChanged", "Up", amount)

func increaseMax(amount):
	self.maxHealth += amount
	emit_signal("healthChanged", "Max", 0)

func set_weapon_positions(dir):
	var weapon = self.get_node("PrimaryWeapon")
	var secondary = self.get_node("SecondaryWeapon")
	if dir == Enums.DIRECTION.DOWN:
		weapon.set_draw_behind_parent(false)
		if weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(false)
		weapon.set_pos(Vector2(16, 27))
		secondary.set_draw_behind_parent(false)
		secondary.set_flip_h(false)
		secondary.set_pos(Vector2(32, 27))
	elif dir == Enums.DIRECTION.UP:
		weapon.set_draw_behind_parent(true)
		if !weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(true)
		weapon.set_pos(Vector2(32, 27))
		secondary.set_draw_behind_parent(true)
		secondary.set_flip_h(true)
		secondary.set_pos(Vector2(16, 27))
	elif dir == Enums.DIRECTION.LEFT:
		weapon.set_draw_behind_parent(true)
		if weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(false)
		weapon.set_pos(Vector2(24, 27))
		secondary.set_draw_behind_parent(false)
		secondary.set_flip_h(false)
		secondary.set_pos(Vector2(24, 27))
	elif dir == Enums.DIRECTION.RIGHT:
		weapon.set_draw_behind_parent(false)
		if !weapon.is_flipped_h():
			weapon.set_offset(weapon.get_offset() * Vector2(-1, 1))
		weapon.set_flip_h(true)
		weapon.set_pos(Vector2(24, 27))
		secondary.set_draw_behind_parent(true)
		secondary.set_flip_h(true)
		secondary.set_pos(Vector2(24, 27))