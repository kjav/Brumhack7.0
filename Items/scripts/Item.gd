extends Node
var description
var name
var iconFilePath
var pos = null

func onUse():
	pass

func place(newPos):
	pos = newPos
	GameData.placeItem(self)

func pickup():
	pos = null