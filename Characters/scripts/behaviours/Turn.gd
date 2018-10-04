class MoveTo extends Node:
	func getDirection(pos):
		pos.x = int(pos.x / GameData.TileSize)
		pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.original_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		return GameData.tilemap.findNextDirection(pos, player_pos) 

class MoveRandom extends Node:
	func getDirection(pos):
		return randi()%5

class InRangeMoveToOtherwiseRandom extends Node:
	var random = MoveRandom.new()
	var moveTo = MoveTo.new()
	var limit = 100
	
	func setLimit(newLimit):
		limit = newLimit
	
	func getDirection(pos):
		var divided_pos = Vector2(0,0)
		divided_pos.x = int(pos.x / GameData.TileSize)
		divided_pos.y = int(pos.y / GameData.TileSize)
		var player_pos = GameData.player.original_pos
		player_pos.x = int(player_pos.x / GameData.TileSize)
		player_pos.y = int(player_pos.y / GameData.TileSize)
		if GameData.player.alive and divided_pos.distance_squared_to(player_pos) < limit:
			# Select movement direction towards player
			return moveTo.getDirection(pos)
		else:
			# Select random movement direction
			return random.getDirection(pos)


class BehaviourEveryN extends Node:
	var behaviour 
	var turnWait = 6
	var counter = 0
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
	
	func setBehaviour(newBehaviour):
		behaviour = newBehaviour
	
	func getDirection(pos):
		counter += 1
		if (counter % turnWait != 0):
			return behaviour.getDirection(pos)
		else:
			return Enums.DIRECTION.NONE
		

class InRangeMoveToOtherwiseRandomEveryNTurns extends Node:
	var turnBehaviour = InRangeMoveToOtherwiseRandom.new()
	var behaviourEveryN = BehaviourEveryN.new()
	var turnWait = 3
	var limit = 100
	
	func init():
		behaviourEveryN.setBehaviour(turnBehaviour)
		behaviourEveryN.setTurnWait(turnWait)
	
	func setTurnWait(newTurnWait):
		turnWait = newTurnWait
		behaviourEveryN.setTurnWait(turnWait)
		
	func setLimit(newLimit):
		limit = newLimit
		turnBehaviour.setLimit(limit)
	
	func getDirection(pos):
		return behaviourEveryN.getDirection(pos)