extends AnimatedSprite

var walkable
var pos

func _ready():
	GameData.environmentObjects.append(self)
	pos = get_pos()

func setPos(_pos):
	set_pos(_pos)
	pos = _pos

func onWalkedInto(character):
	pass