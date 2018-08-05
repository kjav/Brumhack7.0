extends Node
var description
var name
var iconFilePath
var pos = null
var useSound

func onUse():
	pass

func place(newPos):
	pos = newPos
	GameData.placeItem(self)

func pickup():
	pos = null
	GameData.pickedUp(self)