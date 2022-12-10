extends TileMap

export var generator_mode: Script
var generator: Generator

func _ready():
	generator = generator_mode.new()
	add_child(generator)
	generator.generate(self)

func _input(event):
	if event.is_action_pressed("generate"):
		generator.generate(self)
