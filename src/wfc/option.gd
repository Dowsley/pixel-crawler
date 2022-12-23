extends Reference
class_name Option

var sides = {
	"left": [],
	"right": [],
	"up": [],
	"down": []
}

func link(side_name: String, options: Array) -> Option:
	assert(side_name in sides.keys())
	sides[side_name] = options
	return self
