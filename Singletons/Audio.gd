extends SamplePlayer

func playHit():
	randomize()
	var which = randi()%3
	if (which == 0):
		Audio.play("Hit_1")
	elif (which == 1):
		Audio.play("Hit_2")
	else:
		Audio.play("Hit_3")
	