extends Generator	

func collapse(matrix, i, j):
	pass

func get_random(collection: Array) -> String:
	randomize()
	return collection[randi() % collection.size()]

func set_cell(dungeon: TileMap, i: int, j: int, state_name: String):
	dungeon.set_cell(i, j, dungeon.tile_set.find_tile_by_name(state_name))

func generate(dungeon: TileMap):
	var dungeon_size := (OS.window_size / dungeon.cell_size).ceil()
	
	# Create entropy matrix
	var entropy_matrix := []
	for x in range(dungeon_size.x):
		entropy_matrix.append([])
		for y in range(dungeon_size.y):
			entropy_matrix[x].append(Array(States.data.keys()))
	
	# Force collapse for index 0,0 (choose random value)
	var state_name := get_random(States.data.keys())
	set_cell(dungeon, 0, 0, state_name)

	# Find cell with lowest entropy
	for i in dungeon_size.x:
		for j in dungeon_size.y:
			#dungeon.set_cell(i,j, randi() % tile_types.size())
			#print(dungeon.get_cell(i,j))
			pass
