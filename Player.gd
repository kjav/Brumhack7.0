extends "Character.gd"

var time_elapsed = 0
var original_pos
var attack
var health 

func _ready():
	set_process(true)
	EventListener.listen("SwipeCommand", funcref(self, "moveDirection"))
	original_pos = get_pos()
	GameData.player = self

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
		if get_pos().distance_to(original_pos) >= length:
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
	else:
		time_elapsed = 0
		original_pos = get_pos()