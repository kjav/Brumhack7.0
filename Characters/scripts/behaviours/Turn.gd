class InRangeMoveToOtherwiseRandom extends Node:
	func getDirection(pos, limit):
		pos.x = int(pos.x / 128)
		pos.y = int(pos.y / 128)
		var player_pos = GameData.player.original_pos
		player_pos.x = int(player_pos.x / 128)
		player_pos.y = int(player_pos.y / 128)
		if GameData.player.alive and pos.distance_squared_to(player_pos) < limit:
			# Select movement direction towards player
			return GameData.tilemap.findNextDirection(pos, player_pos)
		else:
			# Select random movement direction
			return randi()%5

class InRangeMoveToOtherwiseRandomEveryNTurns extends Node:
	var turnBehaviour = InRangeMoveToOtherwiseRandom.new()
	var counter = 0
	var turnWait = 1
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
	
	func getDirection(pos, limit):
		print(counter % 2)
		print(counter % turnWait)
		#if (counter % turnWait == 0):
		return turnBehaviour.getDirection(pos, limit)
		counter += 1