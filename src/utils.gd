extends Reference
class_name Utils

static func get_random_element(collection: Array):
	randomize()
	return collection[randi() % collection.size()]
