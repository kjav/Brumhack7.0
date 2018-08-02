extends Node

var damage
var name
var distance
var iconFilePath
var pos
#Down, Up, Left, Right
var holdOffset

#can be used for things like bows later on
func onUse():
	pass

func place(newPos):
	pos = newPos
	GameData.placeItem(self)

func pickup():
	pos = null
	GameData.pickedUp(self)
	GameData.player.dropWeapon()
	GameData.player.setPrimaryWeapon(self)