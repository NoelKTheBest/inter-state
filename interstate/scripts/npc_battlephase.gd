extends Sprite2D

signal respond(response: String)

#const empathy: int = 1
const sympathy: int = 1
const kindess: int = 2

# pity > resistance > willingness > pity
var pity: int = 1
var resistance: int = 9
var willingness: int = 1

var convinced: bool = false

var plead_d = ["Beg all you want", "Well...", "Maybe"]
var insist_d = ["No.", "I don't know", "I suppose i could"]
var complain_d = ["Dang man....", "That sucks...", "Wow, that's crazy..."]
var talk_d = ["Tell me a joke then, I got time to kill",
"Where are you even going? I have a right to know",
 "Your story is amusing, but it doesn't convince me... "]
var di: int = 0


func receive_action(player_action) -> void:
	var response
	match player_action:
		"PLEAD":
			var pi = 0
			pity += (1 + sympathy)
			resistance -= 1
			if pity < 5: pi = 0
			elif pity >= 5 and pity < 10: pi = 1
			elif pity >= 10: pi = 2
			response = "Chanel: " + plead_d[pi]
		"INSIST":
			var ii = 0
			willingness += (1 + kindess)
			pity -= 1
			if willingness < 5: ii = 0
			elif willingness >= 5 and willingness < 10: ii = 1
			elif willingness >= 10: ii = 2
			response = "Chanel: " + insist_d[ii]
		"COMPLAIN":
			var ci = 0
			resistance += 1
			willingness -= 1
			if resistance < 5: ci = 0
			elif resistance >= 5 and resistance < 10: ci = 1
			elif resistance >= 10: ci = 2
			response = "Chanel: " + complain_d[ci]
		"TALK":
			response = "Chanel: " + talk_d[di]
			di += 1
			if di > 2: di = 0
	
	respond.emit(response)
