extends Node

var coord_arr = [Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game Logic: Ready")
	#print(move_is_valid(Vector2(1,2),Vector2(1,1)))

func move_is_valid(start_pos, end_pos):
	for i in standard_movement(start_pos):
		if i == end_pos && DataHandler.piece_dict.has(end_pos) == false:
			return true
	for i in portal_phase(start_pos):
		if i == end_pos:
			return true
	#If the Piece is a Non Portal
	if DataHandler.piece_dict[start_pos].type not in [5, 12]:
		for i in nexus_movement(start_pos):
			if i == end_pos && DataHandler.piece_dict.has(end_pos) == false:
				return true
	#If the Piece is a Portal
	else:
		for i in standard_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos) && DataHandler.piece_dict.has(end_pos) == false:
				return true
		for i in nexus_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos) && DataHandler.piece_dict.has(end_pos) == false:
				return true
		for i in portal_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos) && DataHandler.piece_dict.has(end_pos) == false:
				return true
		for i in portal_swap(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos):
				return true

func get_all_valid_moves_for_piece(start_pos):
	var available_moves = []
	for i in standard_movement(start_pos):
		available_moves.append(i)
	for i in portal_phase(start_pos):
		available_moves.append(i)

	#If the Piece is a Non Portal
	if DataHandler.piece_dict[start_pos].type not in [5, 12]:
		for i in nexus_movement(start_pos):
			available_moves.append(i)
	#If the Piece is a Portal
	else:
		for i in standard_movement(start_pos):
				available_moves.append(i)
		for i in nexus_movement(start_pos):
				available_moves.append(i)
		for i in portal_movement(start_pos):
				available_moves.append(i)
		for i in portal_swap(start_pos):
				available_moves.append(i)
	return available_moves
	
func standard_movement(start_pos):
	var available_moves = []
	#Non-Portal
	if DataHandler.piece_dict[start_pos].type not in [5,12]:
		for i in coord_arr:
			if DataHandler.board_dict.has(start_pos + i) && DataHandler.piece_dict.has(start_pos + i) == false:
				available_moves.append(start_pos + i)
		return available_moves
	#Portal
	else:
		for i in coord_arr:
			if DataHandler.golden_lines_dict.has(start_pos + i) && DataHandler.piece_dict.has(start_pos + i) == false:
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
				if move_pos != start_pos and not seen_moves.has(move_pos) && DataHandler.board_dict.has(move_pos) && DataHandler.piece_dict.has(move_pos) == false:
					if DataHandler.piece_dict[start_pos].type not in [5,12]:
						available_moves.append(move_pos)
						seen_moves[move_pos] = true  # Mark this move as seen to prevent duplicates
					elif DataHandler.piece_dict[start_pos].type in [5,12] && DataHandler.golden_lines_dict.has(move_pos):
						available_moves.append(move_pos)
						seen_moves[move_pos] = true  # Mark this move as seen to prevent duplicates
	return available_moves

func portal_movement(start_pos):
	var available_moves = []
	if typeof(DataHandler.golden_lines_dict[start_pos]) != 1:
		for i in DataHandler.golden_lines_dict[start_pos]:
			if DataHandler.piece_dict.has(i) == false:
				available_moves.append(i)
		return available_moves
	return []
	
func portal_phase(start_pos):
	var available_moves = []
	var phase_found = false
	#NonPortal phasing through Portal
	if DataHandler.piece_dict[start_pos].type not in [5,12]:
		for i in coord_arr:
			phase_found = false
			var temp_pos = start_pos
			while DataHandler.piece_dict.has(temp_pos + i) && DataHandler.piece_dict[(temp_pos + i)].type in [5,12]:
				temp_pos = (temp_pos + i)
				phase_found = true
			if phase_found == true && DataHandler.board_dict.has(temp_pos + i) && DataHandler.piece_dict.has(temp_pos + i) == false:
				available_moves.append(temp_pos + i)
	#Portal phasing through everything
	if DataHandler.piece_dict[start_pos].type in [5,12]:
		for i in coord_arr:
			phase_found = false
			var temp_pos = start_pos
			while DataHandler.piece_dict.has(temp_pos + i):
				temp_pos = (temp_pos + i)
				phase_found = true
			if phase_found == true && DataHandler.golden_lines_dict.has(temp_pos + i) && DataHandler.piece_dict.has(temp_pos + i) == false:
				available_moves.append(temp_pos + i)
	return available_moves

func portal_swap(start_pos):
	var player = check_player_of_piece(start_pos)
	var available_moves = []
	for i in DataHandler.piece_dict:
		print(i)
		if DataHandler.piece_dict[i].type not in [5,12] && player == check_player_of_piece(i) && DataHandler.golden_lines_dict.has(DataHandler.piece_dict[i].slot_ID):
			available_moves.append(DataHandler.piece_dict[i].slot_ID)
	return available_moves

func attack(coord):
	var player = check_player_of_piece(coord)
	#Void Attack
	if DataHandler.piece_dict[coord].type in [6,13]:
			for i in coord_arr:
				if DataHandler.board_dict.has(coord + i) && DataHandler.piece_dict.has(coord + i) == true && player != check_player_of_piece(coord +i):
					DataHandler.piece_dict[coord + i].queue_free()
					DataHandler.piece_dict.erase(coord + i)
	#Portal Attack
	elif DataHandler.piece_dict[coord].type in [5,12]:
		print("portal")
		for i in coord_arr:
			#Standard Distance
			if DataHandler.board_dict.has(coord + i) && DataHandler.piece_dict.has(coord + i) == true && DataHandler.piece_dict[coord + i].type in [5,12] && player != check_player_of_piece(coord +i):
				DataHandler.piece_dict[coord + i].queue_free()
				DataHandler.piece_dict.erase(coord + i)
			#Portal Distance
			if typeof(DataHandler.golden_lines_dict[coord]) != 1:
				for n in DataHandler.golden_lines_dict[coord]:
					if DataHandler.piece_dict.has(n) == true && DataHandler.piece_dict[n].type in [5,12] && player != check_player_of_piece(n):
						DataHandler.piece_dict[n].queue_free()
						DataHandler.piece_dict.erase(n)
	#Non-Portal Attack
	else:
		for i in coord_arr:
			if DataHandler.board_dict.has(coord + i) && DataHandler.piece_dict.has(coord + i) == true && DataHandler.piece_dict[coord + i].type not in [5,12] && player != check_player_of_piece(coord +i):
				DataHandler.piece_dict[coord + i].queue_free()
				DataHandler.piece_dict.erase(coord + i)

func check_player_of_piece(piece_pos):
	if DataHandler.piece_dict[piece_pos].type in [0,1,2,3,4,5,6]:
		# true = Circle
		return true
	else:
		# false = Square
		return false
