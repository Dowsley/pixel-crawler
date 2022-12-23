extends TileMap
onready var generator := Generator.new()
onready var size := (OS.window_size / cell_size).ceil()

func generate_map():
	#generator.print_grid()
	generator.generate()
	#generator.print_grid()
	for i in size.x:
		for j in size.y:
			if generator.get_tile(i,j).collapsed:
				set_cell(
					i,
					j,
					tile_set.find_tile_by_name(generator.get_tile(i,j).options[0])
			)

func _ready():
	generator.init_grid(size)
	generate_map()
	# Load data
	#dungeon.set_cell(i, j, dungeon.tile_set.find_tile_by_name(state_name))

func _input(event):
	if event.is_action_pressed("generate"):
		generate_map()
