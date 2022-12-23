extends Reference
class_name WFC

static func sort_by_entropy(a, b):
	return a.options.size() < b.options.size()

static func load_all_options() -> Dictionary:
	var data := {}
	var json_data := {}
	
	var file = File.new()
	
	file.open("res://data/wfc_dungeon.json", File.READ)
	json_data = parse_json(file.get_as_text())
	
	var opt: Option
	for state_name in json_data:
		opt = Option.new()
		for side in json_data[state_name]["spread"]:
			opt.link(side, json_data[state_name]["spread"][side])
		data[state_name] = opt
	
	return data
