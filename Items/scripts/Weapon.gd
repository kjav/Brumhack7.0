extends Node

var damage
var name
var distance
var iconFilePath
var pos

#can be used for things like bows later on
func onUse():
	pass

func place(newPos):
	pos = newPos

func pickup():
	pos = null
	GameData.player.dropWeapon()
	GameData.player.setPrimaryWeapon(self)