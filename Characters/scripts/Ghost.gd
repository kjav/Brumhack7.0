extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
var turnBehaviour = Turn.InRangeMoveToOtherwiseRandomEveryNTurnsInvinsibleOnWait.new()
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
var processBehaviour = Process.StraightTransition.new()

func _ready():
	self.name = 'Ghost'
	base_damage = 2
	turnBehaviour.setTurnWait(2)
	turnBehaviour.setLimit(100)
	turnBehaviour.init()
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.1, "value": Constants.SpellClasses.FireSpell}])


func turn():
	moving = moveDirection(turnBehaviour.getDirection(original_pos))
	self.damageable = turnBehaviour.getDamageable()
	if (!self.damageable):
		set_animation("invinsible")

func _process(delta):
	var state = processBehaviour.getNewState(get_pos(), original_pos, movement_direction, moving, delta)
	if state[0] != null:
		self.set_pos(state[0])
	if (self.moving && !state[1]):
		original_pos = get_pos()
	if state[1] != null:
		self.moving = state[1]