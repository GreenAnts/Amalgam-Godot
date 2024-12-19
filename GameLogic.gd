extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game Logic:")
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
	#If the Piece is a Non Portal
	if DataHandler.piece_dict[start_pos].type != 5 && DataHandler.piece_dict[start_pos].type != 12:
		if standard_movement(start_pos, end_pos) || nexus_movement(start_pos, end_pos):
			return true
	#If the Piece is a Portal
	else:
		if DataHandler.golden_lines_dict.has(end_pos) && (nexus_movement(start_pos, end_pos) || standard_movement(start_pos, end_pos)):
			return true
		elif portal_movement(start_pos, end_pos):
			return true

func standard_movement(start_pos, end_pos):
	if abs(start_pos.x - end_pos.x) <= 1 && abs(start_pos.y - end_pos.y) <= 1 && start_pos != end_pos:
		return true

func nexus_movement(start_pos, end_pos):
	return false

func portal_movement(start_pos, end_pos):
	if DataHandler.golden_lines_dict.has(end_pos) && typeof(DataHandler.golden_lines_dict[start_pos]) != 1:
		print(DataHandler.golden_lines_dict[start_pos])
		print(DataHandler.golden_lines_dict[end_pos])
		if DataHandler.golden_lines_dict[start_pos].has(end_pos):
			return true
