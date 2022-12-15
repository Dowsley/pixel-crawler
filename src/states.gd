extends Node

var data := {}
var json_data := {}

func addState(state_name: String):
	var s := State.new()
	for side in json_data[state_name]["spread"]:
		s.addSpread(side, json_data[state_name]["spread"][side])
	data[state_name] = s


func _ready():
	var file = File.new()
	file.open("res://data/wfc_dungeon.json", File.READ)
	json_data = parse_json(file.get_as_text())
	
	for state_name in json_data:
		addState(state_name)
