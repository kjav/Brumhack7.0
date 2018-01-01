extends Node2D

var description
var name

func setDescription(newDescription):
	if typeof(newDescription) == TYPE_STRING:
		description = newDescription
		get_node("Description").add_text(description)

func setName(newName):
	if typeof(newName) == TYPE_STRING:
		name = newName
		get_node("Name").add_text(name)