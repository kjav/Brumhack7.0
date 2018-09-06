extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
var turnBehaviour = Turn.InRangeMoveToOtherwiseRandom.new()
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
var processBehaviour = Process.StraightTransition.new()
var turnCounter = 0
func _ready():
	self.damage = 2
	self.name = 'Baby Ogre'

func turn():
	if (turnCounter % 2 == 0):
		moving = moveDirection(turnBehaviour.getDirection(original_pos, 100))
	turnCounter += 1

func _process(delta):
	var state = processBehaviour.getNewState(get_pos(), original_pos, movement_direction, moving, delta)
	if state[0] != null:
		self.set_pos(state[0])
	if (self.moving && !state[1]):
		original_pos = get_pos()
	self.moving = state[1]