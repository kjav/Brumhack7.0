tool
extends Node2D

export(Texture) var characterTexture setget setCharacterTexture, getCharacterTexture
export(String) var characterName setget setCharacterName, getCharacterName
export(int) var characterStrength setget setCharacterStrength, getCharacterStrength
export(int) var characterDefence setget setCharacterDefence, getCharacterDefence
export(int) var characterHitpoints setget setCharacterHitpoints, getCharacterHitpoints
export(int) var characterSpeed setget setCharacterSpeed, getCharacterSpeed
export(String) var characterDescription setget setCharacterDescription, getCharacterDescription
export(bool) var characterEditable setget setCharacterEditable, getCharacterEditable

func setCharacterTexture(t):
	if typeof(t) == TYPE_OBJECT:
		get_node("CharacterImage").set_texture(t)
		characterTexture = t

func getCharacterTexture():
	return characterTexture

func setCharacterName(n):
	if typeof(n) == TYPE_STRING:
		get_node("CharacterNameLabel").text = n
		characterName = n

func getCharacterName():
	return characterName

func setCharacterStrength(value):
	if typeof(value) == TYPE_INT:
		get_node("StrengthRange").progress = value
		characterStrength = get_node("StrengthRange").progress

func getCharacterStrength():
	return characterStrength

func setCharacterDefence(value):
	if typeof(value) == TYPE_INT:
		get_node("DefenceRange").progress = value
		characterDefence = get_node("DefenceRange").progress

func getCharacterDefence():
	return characterDefence

func setCharacterHitpoints(value):
	if typeof(value) == TYPE_INT:
		get_node("HitpointsRange").progress = value
		characterHitpoints = get_node("HitpointsRange").progress

func getCharacterHitpoints():
	return characterHitpoints

func setCharacterSpeed(value):
	if typeof(value) == TYPE_INT:
		get_node("SpeedRange").progress = value
		characterSpeed = get_node("SpeedRange").progress

func getCharacterSpeed():
	return characterSpeed

func setCharacterDescription(value):
	if typeof(value) == TYPE_STRING:
		get_node("CharacterDescriptionLabel").text = value
		characterDescription = value

func getCharacterDescription():
	return characterDescription

func setCharacterEditable(value):
	if typeof(value) == TYPE_BOOL:
		characterEditable = value
		get_node("StrengthRange").editable = value
		get_node("DefenceRange").editable = value
		get_node("HitpointsRange").editable = value
		get_node("SpeedRange").editable = value

func getCharacterEditable():
	return characterEditable