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
	emit_signal("blockStateChanged", self, true);

func remove():
	var a = GameData.environmentObjectAtPos(pos/GameData.TileSize)
	GameData.RemoveEnvironment(a[0])
	hide()
	queue_free()