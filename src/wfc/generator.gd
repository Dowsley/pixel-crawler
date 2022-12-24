extends Reference
class_name Generator

var options: Dictionary
var grid := []
var size: Vector2

func get_all_options():
	return options.keys().duplicate()

func convert_coordinates(i: int, j: int) -> int:
	return int(i + j * size.x)

func get_tile(i: int, j: int, alt_grid = null) -> Tile:
	var target = alt_grid if alt_grid else grid
	return target[convert_coordinates(i, j)]

func set_tile(i: int, j: int, t: Tile) -> void:
	grid[convert_coordinates(i, j)] = t

func collapse_by_pos(i: int, j: int) -> void:
	var t: Tile = get_tile(i, j)
	t.options = [Utils.get_random_element(t.options)]
	t.collapsed = true

func collapse_by_ref(t: Tile) -> void:
	t.options = [Utils.get_random_element(t.options)]
	t.collapsed = true

func init_grid(size: Vector2):
	self.size = size
	options = WFC.load_all_options()
	
	grid.clear()
	grid.resize(size.x * size.y)
	for x in range(size.x):
		for y in range(size.y):
			set_tile(x, y, Tile.new(get_all_options()))

func get_lowest_entropy_tile() -> Tile:
	randomize()
	
	var grid_copy = grid.duplicate()
	grid_copy.sort_custom(WFC, "sort_by_entropy")
	for i in range(grid_copy.size()-1, -1, -1):
		if grid_copy[i].collapsed:
			grid_copy.remove(i)
			
	if grid_copy.size() == 0:
		return null
	
	var max_len: int = grid_copy[0].options.size()
	var stop_index := 0
	
	var i := 1
	while (i < grid_copy.size()):
		if (grid_copy[i].options.size() > max_len):
			stop_index = i
			break
		i += 1
	
	if stop_index == 0:
		return Utils.get_random_element(grid_copy)
	else:
		return grid_copy[int(rand_range(0, stop_index))]

func print_grid():
	for x in range(size.x):
		for y in range(size.y):
			print(get_tile(x, y).options)

func generate():
	#collapse_by_pos(0, 0)
	
	var t: Tile
	t = get_lowest_entropy_tile()
	if not t:
		return
	collapse_by_ref(t)

	var next_grid := {}
	for i in range(size.x):
		for j in range(size.y):
			t = get_tile(i, j)
			if (t.collapsed):
				next_grid[convert_coordinates(i, j)] = t
			else:
				var valid_for_side: Array
				var options_local = get_all_options()
				# Look up
				if j > 0:
					t = get_tile(i, j-1)
					valid_for_side = []
					for opt in t.options:
						valid_for_side += options[opt].get_options_for("down")
					check_valid(options_local, valid_for_side)
				# Look right
				if i < size.x - 1:
					t = get_tile(i+1, j)
					valid_for_side = []
					for opt in t.options:
						valid_for_side += options[opt].get_options_for("left")
					check_valid(options_local, valid_for_side)
				# Look down
				if j < size.y - 1:
					t = get_tile(i, j+1)
					valid_for_side = []
					for opt in t.options:
						valid_for_side += options[opt].get_options_for("up")
					check_valid(options_local, valid_for_side)
				# Look left
				if i > 0:
					t = get_tile(i-1, j)
					valid_for_side = []
					for opt in t.options:
						valid_for_side += options[opt].get_options_for("right")
					check_valid(options_local, valid_for_side)
				
				next_grid[convert_coordinates(i, j)] = Tile.new(options_local)
	
	update_grid_from(next_grid) 

func update_grid_from(next_grid: Dictionary):
	var keys := next_grid.keys().duplicate()
	keys.sort()

	var tmp := []
	for k in keys:
		tmp.append(next_grid[k])
	grid = tmp

func check_valid(arr: Array, valid: Array):
	var element
	for i in range(arr.size()-1, -1, -1):
		element = arr[i]
		if not valid.has(element):
			arr.remove(i)
