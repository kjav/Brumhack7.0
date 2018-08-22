extends "Character.gd"

var attack
var name = 'Bat'
signal attack(character, amount)

func _ready():
	set_process(true)
	GameData.characters.append(self)

func attack(character):
	emit_signal("attack", self, 1);
	.attack(character);
	
func turn():
	var pos = original_pos
	pos.x = int(pos.x / 128)
	pos.y = int(pos.y / 128)
	var player_pos = GameData.player.original_pos
	player_pos.x = int(player_pos.x / 128)
	player_pos.y = int(player_pos.y / 128)
	if GameData.player.alive and pos.distance_squared_to(player_pos) < 100:
		# Select movement direction towards player
		moving = moveDirection(GameData.tilemap.findNextDirection(pos, player_pos))
	else:
		# Select random movement direction
		movement_direction = randi()%5
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