extends Generator	


func generate(dungeon: TileMap):
	var dungeon_size := (OS.window_size / dungeon.cell_size).ceil()
	var tile_types := dungeon.tile_set.get_tiles_ids()
	
	randomize()
	for i in dungeon_size.x:
		for j in dungeon_size.y:
			dungeon.set_cell(i,j, randi() % tile_types.size())
