extends Node

var description
var name
var iconFilePath
var pos = null

func onUse():
	pass

func place(newPos):
	pos = newPos

func pickup():
	pos = null