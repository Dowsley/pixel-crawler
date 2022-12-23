extends Reference
class_name Generator

var options: Dictionary
var grid := []
var size: Vector2

func convert_coordinates(i: int, j: int) -> int:
	return int(i + j * size.x)

func get_tile(i: int, j: int) -> Tile:
	return grid[convert_coordinates(i, j)]

func set_tile(i: int, j: int, t: Tile) -> void:
	grid[convert_coordinates(i, j)] = t

func collapse_by_pos(i: int, j: int) -> void:
	var t: Tile = get_tile(i, j)
	# Choose a random element from array
	t.options = [Utils.get_random_element(t.options)]
	t.collapsed = true

func collapse_by_ref(t: Tile) -> void:
	# Choose a random element from array
	t.options = [Utils.get_random_element(t.options)]
	t.collapsed = true

func init_grid(size: Vector2):
	grid.clear()
	grid.resize(size.x * size.y)
	for x in range(size.x):
		for y in range(size.y):
			set_tile(x, y, Tile.new(Array(options.keys())))

func get_lowest_entropy_tile() -> Tile:
	var grid_copy = Array(grid)
	grid_copy.sort_custom(WFC, "sort_by_entropy")
	
	var max_len: int = grid_copy[0].options.size()
	var stop_index := 0
	
	var i := 1
	while (i < grid_copy.size()):
		if (grid_copy[i].options.size() > max_len):
			stop_index = i
			break
		i += 1
	
	var r := int(rand_range(0, stop_index))
	return grid_copy[r]

func print_grid():
	for x in range(size.x):
		for y in range(size.y):
			print(get_tile(x, y).options)

func generate(size: Vector2):
	self.size = size
	options = WFC.load_all_options()
	init_grid(size)
	
	# First random collapse to trigger reaction
	collapse_by_pos(0, 0)
	
	var t: Tile
	t = get_lowest_entropy_tile()
	print(t.options)
	collapse_by_ref(t)
