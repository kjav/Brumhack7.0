extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
var turnBehaviour = Turn.InRangeMoveToOtherwiseRandomEveryNTurns.new()
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
var processBehaviour = Process.StraightTransition.new()
func _ready():
	self.damage = 2
	self.health = 4
	self.name = 'Baby Ogre'
	turnBehaviour.setTurnWait(2)
	turnBehaviour.setLimit(100)
	turnBehaviour.init()

func turn():
	moving = moveDirection(turnBehaviour.getDirection(original_pos))

func _process(delta):
	var state = processBehaviour.getNewState(get_pos(), original_pos, movement_direction, moving, delta)
	if state[0] != null:
		self.set_pos(state[0])
	if (self.moving && !state[1]):
		original_pos = get_pos()
	self.moving = state[1]