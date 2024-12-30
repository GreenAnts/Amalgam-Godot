extends Node

var coord_arr = [Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0), Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game Logic: Ready")

func check_player_of_piece(piece_pos):
	if DataHandler.piece_dict[piece_pos].type in [0,1,2,3,4,5,6]:
		# true = Circle
		return true
	else:
		# false = Square
		return false

# Function to check if two positions are adjacent (horizontally, vertically, or diagonally)
func is_adjacent(pos1: Vector2, pos2: Vector2) -> bool:
	return abs(pos1.x - pos2.x) <= 1 and abs(pos1.y - pos2.y) <= 1

func move_is_valid(start_pos, end_pos):
	for i in standard_movement(start_pos):
		if i == end_pos && not DataHandler.piece_dict.has(end_pos):
			return true
	for i in portal_phase(start_pos):
		if i == end_pos:
			return true
	# If the Piece is a Non Portal
	if DataHandler.piece_dict[start_pos].type not in [5, 12]:
		for i in nexus_movement(start_pos):
			if i == end_pos && not DataHandler.piece_dict.has(end_pos):
				return true
	# If the Piece is a Portal
	else:
		for i in standard_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos) && not DataHandler.piece_dict.has(end_pos):
				return true
		for i in nexus_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos) && not DataHandler.piece_dict.has(end_pos):
				return true
		for i in portal_movement(start_pos):
			if i == end_pos && DataHandler.golden_lines_dict.has(end_pos) && not DataHandler.piece_dict.has(end_pos):
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

	# If the Piece is a Non Portal
	if DataHandler.piece_dict[start_pos].type not in [5, 12]:
		for i in nexus_movement(start_pos):
			available_moves.append(i)
	# If the Piece is a Portal
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
	# Non-Portal
	if DataHandler.piece_dict[start_pos].type not in [5,12]:
		for i in coord_arr:
			if DataHandler.board_dict.has(start_pos + i) && not DataHandler.piece_dict.has(start_pos + i):
				available_moves.append(start_pos + i)
		return available_moves
	# Portal
	else:
		for i in coord_arr:
			if DataHandler.golden_lines_dict.has(start_pos + i) && not DataHandler.piece_dict.has(start_pos + i):
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
				if move_pos != start_pos and not seen_moves.has(move_pos) && DataHandler.board_dict.has(move_pos) && not DataHandler.piece_dict.has(move_pos):
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
			if not DataHandler.piece_dict.has(i):
				available_moves.append(i)
		return available_moves
	return []
	
func portal_phase(start_pos):
	var available_moves = []
	var phase_found = false
	# NonPortal phasing through Portal
	if DataHandler.piece_dict[start_pos].type not in [5,12]:
		for i in coord_arr:
			phase_found = false
			var temp_pos = start_pos
			while DataHandler.piece_dict.has(temp_pos + i) && DataHandler.piece_dict[(temp_pos + i)].type in [5,12]:
				temp_pos = (temp_pos + i)
				phase_found = true
			if phase_found == true && DataHandler.board_dict.has(temp_pos + i) && not DataHandler.piece_dict.has(temp_pos + i):
				available_moves.append(temp_pos + i)
	# Portal phasing through everything
	if DataHandler.piece_dict[start_pos].type in [5,12]:
		for i in coord_arr:
			phase_found = false
			var temp_pos = start_pos
			while DataHandler.piece_dict.has(temp_pos + i):
				temp_pos = (temp_pos + i)
				phase_found = true
			if phase_found == true && DataHandler.golden_lines_dict.has(temp_pos + i) && not DataHandler.piece_dict.has(temp_pos + i):
				available_moves.append(temp_pos + i)
	return available_moves

func portal_swap(start_pos):
	var player = check_player_of_piece(start_pos)
	var available_moves = []
	for i in DataHandler.piece_dict:
		if DataHandler.piece_dict[i].type not in [5,12] && player == check_player_of_piece(i) && DataHandler.golden_lines_dict.has(DataHandler.piece_dict[i].slot_ID):
			available_moves.append(DataHandler.piece_dict[i].slot_ID)
	return available_moves

func attack(coord):
	var player = check_player_of_piece(coord)
	# Void Attack
	if DataHandler.piece_dict[coord].type in [6,13]:
		for i in coord_arr:
			if DataHandler.board_dict.has(coord + i) && DataHandler.piece_dict.has(coord + i) == true && player != check_player_of_piece(coord +i):
				DataHandler.piece_dict[coord + i].queue_free()
				DataHandler.piece_dict.erase(coord + i)
	# Portal Attack
	elif DataHandler.piece_dict[coord].type in [5,12]:
		for i in coord_arr:
			# Standard Distance
			if DataHandler.board_dict.has(coord + i) && DataHandler.piece_dict.has(coord + i) == true && DataHandler.piece_dict[coord + i].type in [5,12] && player != check_player_of_piece(coord +i):
				DataHandler.piece_dict[coord + i].queue_free()
				DataHandler.piece_dict.erase(coord + i)
			# Portal Distance
			if typeof(DataHandler.golden_lines_dict[coord]) != 1:
				for n in DataHandler.golden_lines_dict[coord]:
					if DataHandler.piece_dict.has(n) == true && DataHandler.piece_dict[n].type in [5,12] && player != check_player_of_piece(n):
						DataHandler.piece_dict[n].queue_free()
						DataHandler.piece_dict.erase(n)
	# Non-Portal Attack
	else:
		for i in coord_arr:
			if DataHandler.board_dict.has(coord + i) && DataHandler.piece_dict.has(coord + i) == true && DataHandler.piece_dict[coord + i].type not in [5,12] && player != check_player_of_piece(coord +i):
				DataHandler.piece_dict[coord + i].queue_free()
				DataHandler.piece_dict.erase(coord + i)

func ruby_fireball(ruby_pos1: Vector2, ruby_pos2: Vector2) -> Array:
	# Ensure the two Ruby pieces are adjacent (horizontally, vertically, or diagonally)
	if not is_adjacent(ruby_pos1, ruby_pos2):
		return []  # Return an empty array if Rubies are not adjacent

	# Determine the direction of the Fireball based on the alignment of the two Rubies
	var direction = ruby_pos2 - ruby_pos1

	# Check if the Rubies are aligned (horizontally, vertically, or diagonally)
	if direction.x == 0 or direction.y == 0 or abs(direction.x) == abs(direction.y):
		# Initialize an array to store Fireball moves in both directions
		var fireball_targets_1 = []
		var fireball_targets_2 = []
		# Forward direction (from ruby_pos2 outward)
		fireball_targets_1.append_array(get_fireball_targets(ruby_pos2, direction))
		# Backward direction (from ruby_pos1 outward in reverse direction)
		fireball_targets_2.append_array(get_fireball_targets(ruby_pos1, -direction))
		# Return all possible target positions
		DataHandler.ruby_indicator_coord = [[ruby_pos2, direction],[ruby_pos1, -direction]]
		return [fireball_targets_1, fireball_targets_2]
	else:
		print("Fireball: The two Rubies are not aligned properly!")
		return []  # Return an empty array if Rubies are not properly aligned

# Function to calculate the potential fireball target positions
func get_fireball_targets(start_pos: Vector2, direction: Vector2) -> Array:
	var targets = []
	DataHandler.ruby_indicator_coord = []
	# Determine step direction for both x and y axes separately
	var step_x = sign(direction.x)
	var step_y = sign(direction.y)

	for step in range(1, 7):  # Fireball can move up to 6 spaces
		# Calculate target position by adding steps in the x and y direction separately
		var target_pos = start_pos + Vector2(step_x * step, step_y * step)
		# Check if the target position is on the board
		if not DataHandler.board_dict.has(target_pos):
			break  # Stop checking further if out of bounds
		# Check if the position is occupied by an opponent's piece (non-Portal)
		if DataHandler.piece_dict.has(target_pos) and check_player_of_piece(target_pos) != check_player_of_piece(start_pos):
			# Check if the position is occupied by a Portal piece
			if DataHandler.piece_dict[target_pos].type in [5, 12]:
				break  # Fireball stops at Portal pieces
			targets.append(target_pos)  # Add the opponent's piece as a valid target
			break  # Stop after the first opponent piece
		# If the position is empty, skip it (Fireball continues)
		if not DataHandler.piece_dict.has(target_pos):
			continue
	return targets

func pearl_tidalwave(pearl_pos1: Vector2, pearl_pos2: Vector2) -> Array:
	# Ensure the two Pearl pieces are adjacent (horizontally, vertically, or diagonally)
	if not is_adjacent(pearl_pos1, pearl_pos2):
		return []  # Return an empty array if Pearls are not adjacent
	
	# Determine the direction of the Tidalwave based on the alignment of the two Pearls
	var direction = pearl_pos2 - pearl_pos1
	
	# Check if the Pearls are aligned (horizontally, vertically, or diagonally)
	if direction.x == 0 or direction.y == 0 or abs(direction.x) == abs(direction.y):
		# Initialize an array to store Tidalwave moves in both directions
		var tidalwave_targets_1 = []
		var tidalwave_targets_2 = []
		# Forward direction (from pearl_pos2 outward)
		tidalwave_targets_1.append_array(get_tidalwave_targets(pearl_pos2, direction))
		# Backward direction (from pearl_pos1 outward in reverse direction)
		tidalwave_targets_2.append_array(get_tidalwave_targets(pearl_pos1, -direction))
		# Return all possible target positions
		DataHandler.pearl_indicator_coord = [[pearl_pos2, direction],[pearl_pos1, -direction]]
		return [tidalwave_targets_1, tidalwave_targets_2]
	else:
		print("Tidalwave: The two Pearls are not aligned properly!")
		return []  # Return an empty array if Pearls are not properly aligned

func get_tidalwave_targets(start_pos: Vector2, direction: Vector2) -> Array:
	var targets = []
	DataHandler.pearl_indicator_coord = []
	
	# Normalize the direction to ensure correct grid-based movement
	if direction.x != 0:
		direction.x = direction.x / abs(direction.x)  # Ensure x is -1, 0, or 1
	if direction.y != 0:
		direction.y = direction.y / abs(direction.y)  # Ensure y is -1, 0, or 1

	# Determine if the direction is diagonal
	var is_diagonal: bool = direction.x != 0 and direction.y != 0
	var dir_right := Vector2(-direction.y, direction.x)  # Perpendicular vector to direction

	# Forward and sideways distances for the tidal wave
	var forward_dist = 4  # Extends 4 cells forward
	var sideways_dist = 2  # 2 cells to either side

	# A set to track unique positions
	var seen_positions = {}

	# Loop through forward distances
	for i in range(1, forward_dist + 1):
		# Calculate the leftmost position in the row
		var leftmost_in_row: Vector2 = start_pos + i * direction - sideways_dist * dir_right

		# Loop through sideways distances for this row
		for j in range(sideways_dist * 2 + 1):
			var coords: Vector2 = leftmost_in_row + j * dir_right

			# Add to targets if valid and not already seen
			if _validate_target(start_pos, coords) and not seen_positions.has(coords):
				seen_positions[coords] = true
				targets.append(coords)

		# Handle intermediate cells for diagonals
		if is_diagonal and i < forward_dist:
			var leftmost_in_subrow: Vector2 = leftmost_in_row + (direction + dir_right) / 2

			# Loop through intermediate cells
			for j in range(sideways_dist * 2):
				var coords: Vector2 = leftmost_in_subrow + j * dir_right

				# Add to targets if valid and not already seen
				if _validate_target(start_pos, coords) and not seen_positions.has(coords):
					seen_positions[coords] = true
					targets.append(coords)
	if targets != []:
		DataHandler.pearl_indicator_coord.append([start_pos, direction])
	return targets

func amber_sap(amber_pos1: Vector2, amber_pos2: Vector2) -> Array:
	# Ensure the two Amber pieces are aligned (horizontally, vertically, or diagonally)
	if amber_pos1.x == amber_pos2.x or amber_pos1.y == amber_pos2.y or abs(amber_pos1.x - amber_pos2.x) == abs(amber_pos1.y - amber_pos2.y):
		# Initialize an array to store valid target positions
		var targets = []

		# Determine the line between the two Amber pieces
		var line_points = get_points_on_line(amber_pos1.x, amber_pos1.y, amber_pos2.x, amber_pos2.y)

		# Iterate through the points on the line and process valid targets
		for point in line_points:
			if !DataHandler.board_dict.has(point):
				continue  # Skip if out of bounds

			if DataHandler.piece_dict.has(point):
				var piece = DataHandler.piece_dict[point]

				# Stop at Portal pieces
				if piece.type in [5, 12]:
					break  # Stop processing further along the line
				
				# Add opponent pieces to the targets
				if GameLogic.check_player_of_piece(point) != GameLogic.check_player_of_piece(amber_pos1):
					targets.append(point)
		
		# Return all valid targets
		return targets
	else:
		print("Amber Sap: The two pieces are not aligned!")
		return []  # Return an empty array if not aligned

func jade_launch(jade_pos1: Vector2, jade_pos2: Vector2) -> Array:
	# Ensure the two Jade pieces are adjacent (horizontally, vertically, or diagonally)
	if not is_adjacent(jade_pos1, jade_pos2):
		return []  # Return an empty array if Jades are not adjacent
	
	# Determine the direction of the Launch based on the alignment of the two Jades
	var direction = jade_pos2 - jade_pos1
	
	# Check if the Jades are aligned (horizontally, vertically, or diagonally)
	if direction.x == 0 or direction.y == 0 or abs(direction.x) == abs(direction.y):
		# Initialize a Vector2 to store Launch piece in both directions
		var launch_piece_1 = null
		var launch_piece_2 = null
		# Forward direction (from jade_pos2 outward)
		if DataHandler.piece_dict.has(jade_pos2 + direction):
			launch_piece_1 = { "Piece": (jade_pos2 + direction),
								"launch": get_launch_targets(jade_pos1, -direction)
				}
		# Backward direction (from jade_pos1 outward in reverse direction)
		if DataHandler.piece_dict.has(jade_pos1 - direction):
			launch_piece_2 = { "Piece": (jade_pos1 - direction),
								"launch": get_launch_targets(jade_pos2, direction)
				}
		# Return all possible target positions
		return [launch_piece_1, launch_piece_2]
	else:
		print("Launch: The two Jades are not aligned properly!")
		return []  # Return an empty array if Jades are not properly aligned

func get_launch_targets(start_pos: Vector2, direction: Vector2) -> Array:
	var targets = []
	
	# Determine step direction for both x and y axes separately
	var step_x = sign(direction.x)
	var step_y = sign(direction.y)

	for step in range(1, 5):  # Launch can move up to 4 spaces
		# Calculate target position by adding steps in the x and y direction separately
		var target_pos = start_pos + Vector2(step_x * step, step_y * step)
		# Check if the target position is on the board
		if not DataHandler.board_dict.has(target_pos):
			break  # Stop checking further if out of bounds
		# Check if the position is occupied by your own piece
		if DataHandler.piece_dict.has(target_pos) and check_player_of_piece(target_pos) == check_player_of_piece(start_pos):
			continue  # Launch cannot land on your own piece
		targets.append(target_pos)  # Add the intersection as a valid launch
	return targets
	
# Helper function to get points on a line between two coordinates
func get_points_on_line(x1: int, y1: int, x2: int, y2: int) -> Array:
	var points = []
	# Vertical line
	if x1 == x2:
		var step = 1 if y2 > y1 else -1
		for y in range(y1 + step, y2, step):
			points.append(Vector2(x1, y))
	# Horizontal line
	elif y1 == y2:
		var step = 1 if x2 > x1 else -1
		for x in range(x1 + step, x2, step):
			points.append(Vector2(x, y1))
	# Diagonal line
	elif abs(x2 - x1) == abs(y2 - y1):
		var x_step = 1 if x2 > x1 else -1
		var y_step = 1 if y2 > y1 else -1
		for i in range(1, abs(x2 - x1)):
			points.append(Vector2(x1 + i * x_step, y1 + i * y_step))
	return points

# Helper function to validate a target position
func _validate_target(start_pos: Vector2, target_pos: Vector2) -> bool:
	# Check if the target position is on the board
	if not DataHandler.board_dict.has(target_pos):
		return false  # Out of bounds

	# Check if the position is occupied by a Portal piece
	if DataHandler.piece_dict.has(target_pos) and DataHandler.piece_dict[target_pos].type in [5, 12]:
		return false  # Skip Portal pieces

	# Check if the position is occupied by an opponent's piece (non-Portal)
	if DataHandler.piece_dict.has(target_pos) and GameLogic.check_player_of_piece(target_pos) != GameLogic.check_player_of_piece(start_pos):
		return true  # Valid opponent target

	return false  # Not valid if empty or not an opponent
