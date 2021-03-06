extends AnimatedSprite

signal blockStateChanged(environmentObject, blockedState)

var walkable
var pos
var name

func _ready():
	self.get_node("/root/Node2D").connectEnvironmentToPathfinding(self)
	pos = get_pos()

func setPos(_pos):
	set_pos(_pos)
	pos = _pos

func onWalkedInto(character):
	pass

func emitSignal(lockedState):
	emit_signal("blockStateChanged", self, true)

func remove():
	GameData.RemoveEnvironment(self)
	hide()
	queue_free()