extends Node

var coord_arr = [Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game Logic: Ready")
	#print(move_is_valid(Vector2(1,2),Vector2(1,1)))

func get_direction(coord, direction):
	if direction == "North":
		return coord + Vector2(0,1)
	if direction == "NorthEast":
		return coord + Vector2(1,1)
	if direction == "East":
		return coord + Vector2(1,0)
	if direction == "SouthEast":
		return coord + Vector2(1,-1)
	if direction == "South":
		return coord + Vector2(0,-1)
	if direction == "SouthWest":
		return coord + Vector2(-1,-1)
	if direction == "West":
		return coord + Vector2(-1,0)
	if direction == "NorthWest":
		return coord + Vector2(-1,1)

func move_is_valid(start_pos, end_pos):
	for i in standard_movement(start_pos):
		if i == end_pos:
			return true
	#If the Piece is a Non Portal
	if DataHandler.piece_dict[start_pos].type not in [5, 12]:
		for i in nexus_movement(start_pos):
			if i == end_pos:
				return true
	#If the Piece is a Portal
	else:
		for i in standard_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos):
				return true
		for i in nexus_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos):
				return true
		for i in portal_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos):
				return true

func standard_movement(start_pos):
	var available_moves = []
	#Non-Portal
	if DataHandler.piece_dict[start_pos].type not in [5,12]:
		for i in coord_arr:
			if DataHandler.board_dict.has(start_pos + i):
				available_moves.append(start_pos + i)
		return available_moves
	#Portal
	else:
		for i in coord_arr:
			if DataHandler.golden_lines_dict.has(start_pos + i):
				available_moves.append(start_pos + i)
		return available_moves

func nexus_movement(start_pos):
	var available_moves = []
	var nexus_positions = []
	
	# Step 1: Find all Nexus formations
	for coord1 in coord_arr:  # Check adjacent positions
		var first_pos = start_pos + coord1
		if DataHandler.piece_dict.has(first_pos):
			var first_type = DataHandler.piece_dict[first_pos].type
			if first_type in [1, 8, 2, 9, 4, 11]:  # Valid first piece
				for coord2 in coord_arr:  # Check for a second piece
					var second_pos = first_pos + coord2
					if DataHandler.piece_dict.has(second_pos) and second_pos != start_pos:
						var second_type = DataHandler.piece_dict[second_pos].type
						if second_type in [1, 8, 2, 9, 4, 11] and first_type != second_type:  # Valid Nexus
							if first_pos not in nexus_positions:
								nexus_positions.append(first_pos)
							if second_pos not in nexus_positions:
								nexus_positions.append(second_pos)
	
	# Step 2: Collect all valid moves adjacent to all Nexus formations
	if nexus_positions:
		var seen_moves = {}
		for nexus_pos in nexus_positions:
			for coord in coord_arr:
				var move_pos = nexus_pos + coord
				if move_pos != start_pos and not seen_moves.has(move_pos) && DataHandler.board_dict.has(move_pos):
					available_moves.append(move_pos)
					seen_moves[move_pos] = true  # Mark this move as seen to prevent duplicates

	return available_moves

func portal_movement(start_pos):
	var available_moves = []
	if typeof(DataHandler.golden_lines_dict[start_pos]) != 1:
		for i in DataHandler.golden_lines_dict[start_pos]:
			available_moves.append(i)
		return available_moves
	return []
	#if DataHandler.golden_lines_dict.has(end_pos) && typeof(DataHandler.golden_lines_dict[start_pos]) != 1:
		#if DataHandler.golden_lines_dict[start_pos].has(end_pos):
