extends AnimatedSprite

signal blockStateChanged(environmentObject, blockedState)

var walkable
var pos
var Name

func _ready():
	GameData.environmentObjects.append(self)
	self.get_node("/root/Node2D").connectEnvironmentToPathfinding(self)
	pos = get_pos()

func setPos(_pos):
	set_pos(_pos)
	pos = _pos

func onWalkedInto(character):
	pass

func emitSignal(lockedState):
	emit_signal("blockStateChanged", self, true);

func remove():
	#needs to remove from gamedata
	#need to delete self