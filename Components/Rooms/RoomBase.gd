var Set = load("res://Components/Distributions/Set.gd")
var NumberOf = load("res://Components/Distributions/NumberOf.gd")
var Distribution = load("res://Components/Distributions/Distribution.gd")
var IndependentDistribution = load("res://Components/Distributions/Distribution.gd")

var environment_distribution
var item_distribution
var npc_distribution
var extents_distribution

func setup_params():
	pass

func _init():
	setup_params()

func get():
	# Pick from the spawn distributions
	return {
		"extents": extents_distribution.pick()[0],
		"environments": environment_distribution.pick(),
		"items": item_distribution.pick(),
		"npcs": npc_distribution.pick()
	}