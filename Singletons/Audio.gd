extends SamplePlayer

func playHit():
	randomize()
	var which = randi()%3
	if (which == 0):
		Audio.play("Hit_1", true)
	elif (which == 1):
		Audio.play("Hit_2", true)
	else:
		Audio.play("Hit_3", true)

func stopLooped(soundID):
	var id = soundID
	#stop the audio associated with iD

func playLooped(name):
	Audio.play(name, true)
	#creat an ID, associate and return