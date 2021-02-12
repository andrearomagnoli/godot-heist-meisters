extends Node

func generate_combination(length):
	randomize()
	var combination = []
	for number in range(length):
		combination.append(randi() % 10)
	
	return combination
