class StraightTransition extends Node:
	func getNewState(pos, original_pos, movement_direction, moving, delta):
		var returnedPos
		var returnedMoving = moving
		if moving:
			if movement_direction == Enums.DIRECTION.LEFT:
				returnedPos = (pos + Vector2(-128 * (delta / 0.4), 0))
			elif movement_direction == Enums.DIRECTION.RIGHT:
				returnedPos = (pos + Vector2(128 * (delta / 0.4), 0))
			elif movement_direction == Enums.DIRECTION.UP:
				returnedPos = (pos + Vector2(0, -128 * (delta / 0.4)))
			elif movement_direction == Enums.DIRECTION.DOWN:
				returnedPos = (pos + Vector2(0, 128 * (delta / 0.4)))
			if returnedPos != null:
				if returnedPos.distance_to(original_pos) >= 128:
					if movement_direction == Enums.DIRECTION.LEFT:
						returnedPos = (original_pos + Vector2(-128, 0))
					elif movement_direction == Enums.DIRECTION.RIGHT:
						returnedPos = (original_pos + Vector2(128, 0))
					if movement_direction == Enums.DIRECTION.UP:
						returnedPos = (original_pos + Vector2(0, -128))
					elif movement_direction == Enums.DIRECTION.DOWN:
						returnedPos = (original_pos + Vector2(0, 128))
					returnedMoving = false
		return([returnedPos, returnedMoving])