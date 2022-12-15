extends Reference
class_name State

var spread = {
	"left": [],
	"right": [],
	"up": [],
	"down": []
}

func is_spread_valid(which: String, new_spread: Dictionary) -> bool:
	var sum := 0.0
	for element in spread.values():
		 sum += element
	return sum <= 1.0 and sum >= 0.0

func addSpread(side: String, new_spread: Array) -> State:
	#assert(is_spread_valid("left", new_spread))
	spread[side] = new_spread
	return self
