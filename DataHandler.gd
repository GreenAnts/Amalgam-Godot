extends Node

var board_dict := {
	#Centers
	Vector2(0,0): true,
	Vector2(0,1): true, Vector2(-1,0): true, Vector2(0,-1): true, Vector2(1,0): true,
	Vector2(0,2): true, Vector2(-2,0): true, Vector2(0,-2): true, Vector2(2,0): true, 
	Vector2(0,3): true, Vector2(-3,0): true, Vector2(0,-3): true, Vector2(3,0): true, 
	Vector2(0,4): true, Vector2(-4,0): true, Vector2(0,-4): true, Vector2(4,0): true, 
	Vector2(0,5): true, Vector2(-5,0): true, Vector2(0,-5): true, Vector2(5,0): true, 
	Vector2(0,6): true, Vector2(-6,0): true, Vector2(0,-6): true, Vector2(6,0): true, 
	Vector2(0,7): true, Vector2(-7,0): true, Vector2(0,-7): true, Vector2(7,0): true, 
	Vector2(0,8): true, Vector2(-8,0): true, Vector2(0,-8): true, Vector2(8,0): true,
	Vector2(0,9): true, Vector2(-9,0): true, Vector2(0,-9): true, Vector2(9,0): true,
	Vector2(0,10): true, Vector2(-10,0): true, Vector2(0,-10): true, Vector2(10,0): true,
	Vector2(0,11): true, Vector2(-11,0): true, Vector2(0,-11): true, Vector2(11,0): true,
	Vector2(0,12): true, Vector2(-12,0): true, Vector2(0,-12): true, Vector2(12,0): true,
	#Top Right
	Vector2(1,1): true, Vector2(1,2): true, Vector2(1,3): true, Vector2(1,4): true,
	Vector2(1,5): true, Vector2(1,6): true, Vector2(1,7): true, Vector2(1,8): true,
	Vector2(1,9): true, Vector2(1,10): true, Vector2(1,11): true,
	Vector2(2,1): true, Vector2(2,2): true, Vector2(2,3): true, Vector2(2,4): true,
	Vector2(2,5): true, Vector2(2,6): true, Vector2(2,7): true, Vector2(2,8): true,
	Vector2(2,9): true, Vector2(2,10): true, Vector2(2,11): true,
	Vector2(3,1): true, Vector2(3,2): true, Vector2(3,3): true, Vector2(3,4): true,
	Vector2(3,5): true, Vector2(3,6): true, Vector2(3,7): true, Vector2(3,8): true,
	Vector2(3,9): true, Vector2(3,10): true, Vector2(3,11): true,
	Vector2(4,1): true, Vector2(4,2): true, Vector2(4,3): true, Vector2(4,4): true,
	Vector2(4,5): true, Vector2(4,6): true, Vector2(4,7): true, Vector2(4,8): true,
	Vector2(4,9): true, Vector2(4,10): true, Vector2(4,11): true,
	Vector2(5,1): true, Vector2(5,2): true, Vector2(5,3): true, Vector2(5,4): true,
	Vector2(5,5): true, Vector2(5,6): true, Vector2(5,7): true, Vector2(5,8): true,
	Vector2(5,9): true, Vector2(5,10): true, Vector2(5,11): true,
	Vector2(6,1): true, Vector2(6,2): true, Vector2(6,3): true, Vector2(6,4): true,
	Vector2(6,5): true, Vector2(6,6): true, Vector2(6,7): true, Vector2(6,8): true,
	Vector2(6,9): true, Vector2(6,10): true,
	Vector2(7,1): true, Vector2(7,2): true, Vector2(7,3): true, Vector2(7,4): true,
	Vector2(7,5): true, Vector2(7,6): true, Vector2(7,7): true, Vector2(7,8): true,
	Vector2(7,9): true,
	Vector2(8,1): true, Vector2(8,2): true, Vector2(8,3): true, Vector2(8,4): true,
	Vector2(8,5): true, Vector2(8,6): true, Vector2(8,7): true, Vector2(8,8): true,
	Vector2(8,9): true,
	Vector2(9,1): true, Vector2(9,2): true, Vector2(9,3): true, Vector2(9,4): true,
	Vector2(9,5): true, Vector2(9,6): true, Vector2(9,7): true, Vector2(9,8): true,
	Vector2(10,1): true, Vector2(10,2): true, Vector2(10,3): true, Vector2(10,4): true,
	Vector2(10,5): true, Vector2(10,6): true,
	Vector2(11,1): true, Vector2(11,2): true, Vector2(11,3): true, Vector2(11,4): true,
	Vector2(11,5): true,
	#Top Left
	Vector2(-1,1): true, Vector2(-1,2): true, Vector2(-1,3): true, Vector2(-1,4): true,
	Vector2(-1,5): true, Vector2(-1,6): true, Vector2(-1,7): true, Vector2(-1,8): true,
	Vector2(-1,9): true, Vector2(-1,10): true, Vector2(-1,11): true,
	Vector2(-2,1): true, Vector2(-2,2): true, Vector2(-2,3): true, Vector2(-2,4): true,
	Vector2(-2,5): true, Vector2(-2,6): true, Vector2(-2,7): true, Vector2(-2,8): true,
	Vector2(-2,9): true, Vector2(-2,10): true, Vector2(-2,11): true,
	Vector2(-3,1): true, Vector2(-3,2): true, Vector2(-3,3): true, Vector2(-3,4): true,
	Vector2(-3,5): true, Vector2(-3,6): true, Vector2(-3,7): true, Vector2(-3,8): true,
	Vector2(-3,9): true, Vector2(-3,10): true, Vector2(-3,11): true,
	Vector2(-4,1): true, Vector2(-4,2): true, Vector2(-4,3): true, Vector2(-4,4): true,
	Vector2(-4,5): true, Vector2(-4,6): true, Vector2(-4,7): true, Vector2(-4,8): true,
	Vector2(-4,9): true, Vector2(-4,10): true, Vector2(-4,11): true,
	Vector2(-5,1): true, Vector2(-5,2): true, Vector2(-5,3): true, Vector2(-5,4): true,
	Vector2(-5,5): true, Vector2(-5,6): true, Vector2(-5,7): true, Vector2(-5,8): true,
	Vector2(-5,9): true, Vector2(-5,10): true, Vector2(-5,11): true,
	Vector2(-6,1): true, Vector2(-6,2): true, Vector2(-6,3): true, Vector2(-6,4): true,
	Vector2(-6,5): true, Vector2(-6,6): true, Vector2(-6,7): true, Vector2(-6,8): true,
	Vector2(-6,9): true, Vector2(-6,10): true,
	Vector2(-7,1): true, Vector2(-7,2): true, Vector2(-7,3): true, Vector2(-7,4): true,
	Vector2(-7,5): true, Vector2(-7,6): true, Vector2(-7,7): true, Vector2(-7,8): true,
	Vector2(-7,9): true,
	Vector2(-8,1): true, Vector2(-8,2): true, Vector2(-8,3): true, Vector2(-8,4): true,
	Vector2(-8,5): true, Vector2(-8,6): true, Vector2(-8,7): true, Vector2(-8,8): true,
	Vector2(-8,9): true,
	Vector2(-9,1): true, Vector2(-9,2): true, Vector2(-9,3): true, Vector2(-9,4): true,
	Vector2(-9,5): true, Vector2(-9,6): true, Vector2(-9,7): true, Vector2(-9,8): true,
	Vector2(-10,1): true, Vector2(-10,2): true, Vector2(-10,3): true, Vector2(-10,4): true,
	Vector2(-10,5): true, Vector2(-10,6): true,
	Vector2(-11,1): true, Vector2(-11,2): true, Vector2(-11,3): true, Vector2(-11,4): true,
	Vector2(-11,5): true,
	#Bottom Left
	Vector2(-1,-1): true, Vector2(-1,-2): true, Vector2(-1,-3): true, Vector2(-1,-4): true,
	Vector2(-1,-5): true, Vector2(-1,-6): true, Vector2(-1,-7): true, Vector2(-1,-8): true,
	Vector2(-1,-9): true, Vector2(-1,-10): true, Vector2(-1,-11): true,
	Vector2(-2,-1): true, Vector2(-2,-2): true, Vector2(-2,-3): true, Vector2(-2,-4): true,
	Vector2(-2,-5): true, Vector2(-2,-6): true, Vector2(-2,-7): true, Vector2(-2,-8): true,
	Vector2(-2,-9): true, Vector2(-2,-10): true, Vector2(-2,-11): true,
	Vector2(-3,-1): true, Vector2(-3,-2): true, Vector2(-3,-3): true, Vector2(-3,-4): true,
	Vector2(-3,-5): true, Vector2(-3,-6): true, Vector2(-3,-7): true, Vector2(-3,-8): true,
	Vector2(-3,-9): true, Vector2(-3,-10): true, Vector2(-3,-11): true,
	Vector2(-4,-1): true, Vector2(-4,-2): true, Vector2(-4,-3): true, Vector2(-4,-4): true,
	Vector2(-4,-5): true, Vector2(-4,-6): true, Vector2(-4,-7): true, Vector2(-4,-8): true,
	Vector2(-4,-9): true, Vector2(-4,-10): true, Vector2(-4,-11): true,
	Vector2(-5,-1): true, Vector2(-5,-2): true, Vector2(-5,-3): true, Vector2(-5,-4): true,
	Vector2(-5,-5): true, Vector2(-5,-6): true, Vector2(-5,-7): true, Vector2(-5,-8): true,
	Vector2(-5,-9): true, Vector2(-5,-10): true, Vector2(-5,-11): true,
	Vector2(-6,-1): true, Vector2(-6,-2): true, Vector2(-6,-3): true, Vector2(-6,-4): true,
	Vector2(-6,-5): true, Vector2(-6,-6): true, Vector2(-6,-7): true, Vector2(-6,-8): true,
	Vector2(-6,-9): true, Vector2(-6,-10): true,
	Vector2(-7,-1): true, Vector2(-7,-2): true, Vector2(-7,-3): true, Vector2(-7,-4): true,
	Vector2(-7,-5): true, Vector2(-7,-6): true, Vector2(-7,-7): true, Vector2(-7,-8): true,
	Vector2(-7,-9): true,
	Vector2(-8,-1): true, Vector2(-8,-2): true, Vector2(-8,-3): true, Vector2(-8,-4): true,
	Vector2(-8,-5): true, Vector2(-8,-6): true, Vector2(-8,-7): true, Vector2(-8,-8): true,
	Vector2(-8,-9): true,
	Vector2(-9,-1): true, Vector2(-9,-2): true, Vector2(-9,-3): true, Vector2(-9,-4): true,
	Vector2(-9,-5): true, Vector2(-9,-6): true, Vector2(-9,-7): true, Vector2(-9,-8): true,
	Vector2(-10,-1): true, Vector2(-10,-2): true, Vector2(-10,-3): true, Vector2(-10,-4): true,
	Vector2(-10,-5): true, Vector2(-10,-6): true,
	Vector2(-11,-1): true, Vector2(-11,-2): true, Vector2(-11,-3): true, Vector2(-11,-4): true,
	Vector2(-11,-5): true,
	#Bottom Right
	Vector2(1,-1): true, Vector2(1,-2): true, Vector2(1,-3): true, Vector2(1,-4): true,
	Vector2(1,-5): true, Vector2(1,-6): true, Vector2(1,-7): true, Vector2(1,-8): true,
	Vector2(1,-9): true, Vector2(1,-10): true, Vector2(1,-11): true,
	Vector2(2,-1): true, Vector2(2,-2): true, Vector2(2,-3): true, Vector2(2,-4): true,
	Vector2(2,-5): true, Vector2(2,-6): true, Vector2(2,-7): true, Vector2(2,-8): true,
	Vector2(2,-9): true, Vector2(2,-10): true, Vector2(2,-11): true,
	Vector2(3,-1): true, Vector2(3,-2): true, Vector2(3,-3): true, Vector2(3,-4): true,
	Vector2(3,-5): true, Vector2(3,-6): true, Vector2(3,-7): true, Vector2(3,-8): true,
	Vector2(3,-9): true, Vector2(3,-10): true, Vector2(3,-11): true,
	Vector2(4,-1): true, Vector2(4,-2): true, Vector2(4,-3): true, Vector2(4,-4): true,
	Vector2(4,-5): true, Vector2(4,-6): true, Vector2(4,-7): true, Vector2(4,-8): true,
	Vector2(4,-9): true, Vector2(4,-10): true, Vector2(4,-11): true,
	Vector2(5,-1): true, Vector2(5,-2): true, Vector2(5,-3): true, Vector2(5,-4): true,
	Vector2(5,-5): true, Vector2(5,-6): true, Vector2(5,-7): true, Vector2(5,-8): true,
	Vector2(5,-9): true, Vector2(5,-10): true, Vector2(5,-11): true,
	Vector2(6,-1): true, Vector2(6,-2): true, Vector2(6,-3): true, Vector2(6,-4): true,
	Vector2(6,-5): true, Vector2(6,-6): true, Vector2(6,-7): true, Vector2(6,-8): true,
	Vector2(6,-9): true, Vector2(6,-10): true,
	Vector2(7,-1): true, Vector2(7,-2): true, Vector2(7,-3): true, Vector2(7,-4): true,
	Vector2(7,-5): true, Vector2(7,-6): true, Vector2(7,-7): true, Vector2(7,-8): true,
	Vector2(7,-9): true,
	Vector2(8,-1): true, Vector2(8,-2): true, Vector2(8,-3): true, Vector2(8,-4): true,
	Vector2(8,-5): true, Vector2(8,-6): true, Vector2(8,-7): true, Vector2(8,-8): true,
	Vector2(8,-9): true,
	Vector2(9,-1): true, Vector2(9,-2): true, Vector2(9,-3): true, Vector2(9,-4): true,
	Vector2(9,-5): true, Vector2(9,-6): true, Vector2(9,-7): true, Vector2(9,-8): true,
	Vector2(10,-1): true, Vector2(10,-2): true, Vector2(10,-3): true, Vector2(10,-4): true,
	Vector2(10,-5): true, Vector2(10,-6): true,
	Vector2(11,-1): true, Vector2(11,-2): true, Vector2(11,-3): true, Vector2(11,-4): true,
	Vector2(11,-5): true
}
var golden_lines_dict := {
	Vector2(-12, 0): [Vector2(-11, 5), Vector2(-11, -5), Vector2(-8, 3), Vector2(-8, -3)],
	Vector2(-11, 5): [Vector2(-12, 0), Vector2(-9, 8)],
	Vector2(-9, 8): [Vector2(-11, 5), Vector2(-8, 3), Vector2(-6, 6), Vector2(-8, 9)],
	Vector2(-8, 9): [Vector2(-9, 8), Vector2(-5, 11), Vector2(-6, 6)],
	Vector2(-5, 11): [Vector2(-8, 9), Vector2(0, 12)],
	Vector2(0, 12): [Vector2(-5, 11), Vector2(5, 11)],
	Vector2(5, 11): [Vector2(0, 12), Vector2(8, 9)],
	Vector2(8, 9): [Vector2(5, 11), Vector2(9, 8), Vector2(6, 6)],
	Vector2(9, 8): [Vector2(11, 5), Vector2(8, 3), Vector2(6, 6), Vector2(8, 9)],
	Vector2(11, 5): [Vector2(12, 0), Vector2(9, 8)],
	Vector2(12, 0): [Vector2(11, 5), Vector2(11, -5), Vector2(8, 3), Vector2(8, -3)],
	Vector2(11, -5): [Vector2(12, 0), Vector2(9, -8)],
	Vector2(9, -8): [Vector2(11, -5), Vector2(8, -3), Vector2(6, -6), Vector2(8, -9)],
	Vector2(8, -9): [Vector2(9, -8), Vector2(5, -11), Vector2(6, -6)],
	Vector2(5, -11): [Vector2(8, -9), Vector2(0, -12)],
	Vector2(0, -12): [Vector2(5, -11), Vector2(-5, -11)],
	Vector2(-5, -11): [Vector2(0, -12), Vector2(-8, -9)],
	Vector2(-8, -9): [Vector2(-5, -11), Vector2(-9, -8), Vector2(-6, -6)],
	Vector2(-9, -8): [Vector2(-11, -5), Vector2(-8, -3), Vector2(-6, -6), Vector2(-8, -9)],
	Vector2(-11, -5): [Vector2(-12, 0), Vector2(-9, -8)],
	
	# Square Corners
	Vector2(6, 6): [Vector2(8, 9), Vector2(9, 8)],
	Vector2(6, -6): [Vector2(8, -9), Vector2(9, -8)],
	Vector2(-6, -6): [Vector2(-8, -9), Vector2(-9, -8)],
	Vector2(-6, 6): [Vector2(-8, 9), Vector2(-9, 8)],
	
	# Square Center Edge
	Vector2(6, 0): [Vector2(8, 3), Vector2(8, -3)],
	Vector2(-6, 0): [Vector2(-8, 3), Vector2(-8, -3)],
	
	# Outer Diamonds
	Vector2(-8, 3): [Vector2(-6, 0), Vector2(-12, 0), Vector2(-9, 8)],
	Vector2(-8, -3): [Vector2(-6, 0), Vector2(-12, 0), Vector2(-9, -8)],
	Vector2(8, 3): [Vector2(6, 0), Vector2(12, 0), Vector2(9, 8)],
	Vector2(8, -3): [Vector2(6, 0), Vector2(12, 0), Vector2(9, -8)],
	#Inner Lines ... *Sigh* - I'm not looking forward to typing these all out
	#Large Square
	Vector2(0,6): true, Vector2(1,6): true, Vector2(2,6): true, Vector2(3,6): true, Vector2(4,6): true, Vector2(5,6): true,
	Vector2(0,-6): true, Vector2(1,-6): true, Vector2(2,-6): true, Vector2(3,-6): true, Vector2(4,-6): true, Vector2(5,-6): true,
	Vector2(-1,6): true, Vector2(-2,6): true, Vector2(-3,6): true, Vector2(-4,6): true, Vector2(-5,6): true,
	Vector2(-1,-6): true, Vector2(-2,-6): true, Vector2(-3,-6): true, Vector2(-4,-6): true, Vector2(-5,-6): true,
	Vector2(6,1): true, Vector2(6,2): true, Vector2(6,3): true, Vector2(6,4): true, Vector2(6,5): true,
	Vector2(6,-1): true, Vector2(6,-2): true, Vector2(6,-3): true, Vector2(6,-4): true, Vector2(6,-5): true,
	Vector2(-6,1): true, Vector2(-6,2): true, Vector2(-6,3): true, Vector2(-6,4): true, Vector2(-6,5): true,
	Vector2(-6,-1): true, Vector2(-6,-2): true, Vector2(-6,-3): true, Vector2(-6,-4): true, Vector2(-6,-5): true,
	#Inner Rotated Square
	Vector2(1,5): true, Vector2(2,4): true, Vector2(3,3): true, Vector2(4,2): true, Vector2(5,1): true,
	Vector2(-1,5): true, Vector2(-2,4): true, Vector2(-3,3): true, Vector2(-4,2): true, Vector2(-5,1): true,
	Vector2(1,-5): true, Vector2(2,-4): true, Vector2(3,-3): true, Vector2(4,-2): true, Vector2(5,-1): true,
	Vector2(-1,-5): true, Vector2(-2,-4): true, Vector2(-3,-3): true, Vector2(-4,-2): true, Vector2(-5,-1): true,
	#Inner "X"
	Vector2(1,1): true, Vector2(2,2): true, Vector2(4,4): true, Vector2(5,5): true,
	Vector2(1,-1): true, Vector2(2,-2): true, Vector2(4,-4): true, Vector2(5,-5): true,
	Vector2(-1,1): true, Vector2(-2,2): true, Vector2(-4,4): true, Vector2(-5,5): true,
	Vector2(-1,-1): true, Vector2(-2,-2): true, Vector2(-4,-4): true, Vector2(-5,-5): true,
	#Horizontal Line
	Vector2(0,0): true, Vector2(1,0): true, Vector2(2,0): true, Vector2(3,0): true, Vector2(4,0): true, Vector2(5,0): true,
	Vector2(-1,0): true, Vector2(-2,0): true, Vector2(-3,0): true, Vector2(-4,0): true, Vector2(-5,0): true,
	Vector2(7,0): true, Vector2(8,0): true, Vector2(9,0): true, Vector2(10,0): true, Vector2(11,0): true,
	Vector2(-7,0): true, Vector2(-8,0): true, Vector2(-9,0): true, Vector2(-10,0): true, Vector2(-11,0): true,
	#Vertical Line
	Vector2(0,1): true, Vector2(0,2): true, Vector2(0,3): true, Vector2(0,4): true, Vector2(0,5): true,
	Vector2(0,-1): true, Vector2(0,-2): true, Vector2(0,-3): true, Vector2(0,-4): true, Vector2(0,-5): true,
	Vector2(0,7): true, Vector2(0,8): true, Vector2(0,9): true, Vector2(0,10): true, Vector2(0,11): true,
	Vector2(0,-7): true, Vector2(0,-8): true, Vector2(0,-9): true, Vector2(0,-10): true, Vector2(0,-11): true,
	#Upper Triangle
	Vector2(1,7): true, Vector2(2,8): true, Vector2(3,9): true, Vector2(4,10): true,
	Vector2(-1,7): true, Vector2(-2,8): true, Vector2(-3,9): true, Vector2(-4,10): true,
	#Lower Triangle
	Vector2(1,-7): true, Vector2(2,-8): true, Vector2(3,-9): true, Vector2(4,-10): true,
	Vector2(-1,-7): true, Vector2(-2,-8): true, Vector2(-3,-9): true, Vector2(-4,-10): true,
}

#For DEBUG
var use_indicators = false
#End DEBUG

var assets := []
#enum PieceNames {WHITE_AMBER, WHITE_JADE, WHITE_RUBY, WHITE_PEARL, WHITE_VOID}
var piece_dict := {}

var clicked_piece = Vector2()
var clicked_slot = Vector2()
var icon_offset := Vector2(20, 20)

var indicators_active = false

#icons
var swap_ready = null
var fireball_ready = false
var tidalwave_ready = false

#Abilities
var ruby_targets = []
var tidalwave_targets = []
var piece_using_ability = Vector2()

var add_piece = null
var remove = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Circle
	assets.append("res://Images/Pieces/Ruby_Circle.png") #0
	assets.append("res://Images/Pieces/Pearl_Circle.png") #1
	assets.append("res://Images/Pieces/Amber_Circle.png") #2
	assets.append("res://Images/Pieces/Jade_Circle.png") #3
	assets.append("res://Images/Pieces/Amalgam_Circle.png") #4
	assets.append("res://Images/Pieces/Portal_Circle.png") #5
	assets.append("res://Images/Pieces/Void_Circle.png") #6
	#Square
	assets.append("res://Images/Pieces/Ruby_Square.png") #7
	assets.append("res://Images/Pieces/Pearl_Square.png") #8
	assets.append("res://Images/Pieces/Amber_Square.png") #9
	assets.append("res://Images/Pieces/Jade_Square.png") #10
	assets.append("res://Images/Pieces/Amalgam_Square.png") #11
	assets.append("res://Images/Pieces/Portal_Square.png") #12
	assets.append("res://Images/Pieces/Void_Square.png") #13
	#Misc
	assets.append("res://Images/Icons/Portal_Swap.png") #14
	assets.append("res://Images/Icons/Portal_Swap_Toggle.png") #15
# Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta: float) -> void:
#	pass

func slot_is_empty():
	if !piece_dict.has(clicked_slot):
		return true

func swap_pos():
	if piece_dict.has(clicked_slot) && piece_dict.has(clicked_piece) && piece_dict[swap_ready].type in [5,12]:
		if GameLogic.move_is_valid(swap_ready, clicked_slot):
			#Change Pieces positions'
			piece_dict[swap_ready].global_position = board_dict[clicked_slot].global_position + icon_offset
			piece_dict[clicked_slot].global_position = board_dict[swap_ready].global_position + icon_offset
			#Update piece.slot_ID
			SignalBus.changed_piece.emit(piece_dict[swap_ready], clicked_slot)
			SignalBus.changed_piece.emit(piece_dict[clicked_slot], swap_ready)
			#update piece_dict
			var temp_piece_node = piece_dict[clicked_slot]
			piece_dict[clicked_slot] = piece_dict[swap_ready]
			piece_dict[swap_ready] = temp_piece_node
			#Remove old entries into piece_dict
			SignalBus.reset_movement_options.emit()
			indicators_active = false
			clicked_piece = null
			DataHandler.swap_ready = null
			SignalBus.show_correct_icons.emit(null)

func change_pos():
	if piece_dict.has(clicked_piece):
		if !piece_dict.has(clicked_slot) and GameLogic.move_is_valid(clicked_piece, clicked_slot):
			# Update piece position
			piece_dict[clicked_piece].global_position = board_dict[clicked_slot].global_position + icon_offset
			SignalBus.changed_piece.emit(piece_dict[clicked_piece], clicked_slot)
			piece_dict[clicked_slot] = piece_dict[clicked_piece]
			piece_dict.erase(clicked_piece)
			SignalBus.reset_movement_options.emit()
			indicators_active = false
			
			# Attack phase
			GameLogic.attack(clicked_slot)
			
			# Abilities
			var player = GameLogic.check_player_of_piece(clicked_slot)
			check_ability(player, clicked_slot)

func check_ability(player: bool, moved_piece: Vector2):
	var piece = DataHandler.piece_dict[moved_piece]
	if not piece:
		print("Error: No piece found at moved position.")
		return

	# Check based on the piece type
	if piece.type in [0, 7]:  # Ruby types (Circle and Square)
		check_fireball(player, moved_piece)
	elif piece.type in [1, 8]:  # Pearl types (Circle and Square)
		check_tidalwave(player, moved_piece)
	elif piece.type in [4, 11]:  # Amalgam types (Circle and Square)
		check_fireball(player, moved_piece)
		check_tidalwave(player, moved_piece)

func check_fireball(player: bool, moved_piece: Vector2):
	# Clear previous ruby targets and fireball state
	DataHandler.ruby_targets.clear()
	DataHandler.fireball_ready = false

	var rubies = []
	var amalgams = []
	
	# Collect Rubies and Amalgams based on the player's type (Circle or Square)
	for piece_pos in DataHandler.piece_dict:
		var piece = DataHandler.piece_dict[piece_pos]
		if player:  # Circle player
			if piece.type == 0:  # Ruby
				rubies.append(piece_pos)
			elif piece.type == 4:  # Amalgam
				amalgams.append(piece_pos)
		else:  # Square player
			if piece.type == 7:  # Ruby
				rubies.append(piece_pos)
			elif piece.type == 11:  # Amalgam
				amalgams.append(piece_pos)

	# Check all combinations of Rubies and Amalgams for Fireball alignment
	for ruby_pos in rubies:
		for secondary_piece in rubies + amalgams:
			if ruby_pos != secondary_piece && (moved_piece == ruby_pos || moved_piece == secondary_piece):
				var targets = GameLogic.ruby_fireball(ruby_pos, secondary_piece)
				if targets.size() > 0:
					# Store the valid targets and involved pieces
					DataHandler.ruby_targets.append({ 
						"primary": ruby_pos, 
						"secondary": secondary_piece, 
						"targets": targets 
					})

	# If valid targets exist, mark Fireball as ready and show indicator
	if DataHandler.ruby_targets.size() > 0:
		DataHandler.fireball_ready = true
		# Highlight the first valid Ruby piece
		SignalBus.show_correct_icons.emit(DataHandler.piece_dict[DataHandler.ruby_targets[0]["primary"]])

func check_tidalwave(player: bool, moved_piece: Vector2):
	# Clear previous targets and ready state
	DataHandler.tidalwave_targets.clear()
	DataHandler.tidalwave_ready = false

	var pearls = []

	# Collect Pearls
	for piece_pos in DataHandler.piece_dict:
		var piece = DataHandler.piece_dict[piece_pos]
		if player:
			if piece.type == 1: pearls.append(piece_pos)  # Pearl (Circle)
		else:
			if piece.type == 8: pearls.append(piece_pos)  # Pearl (Square)

	# Check combinations for valid Tidalwave targets
	for pearl_pos in pearls:
		for secondary_piece in pearls:
			if pearl_pos != secondary_piece and (moved_piece == pearl_pos or moved_piece == secondary_piece):
				var targets = GameLogic.pearl_tidalwave(pearl_pos, secondary_piece)
				if targets.size() > 0:
					DataHandler.tidalwave_targets.append({ 
						"primary": pearl_pos, 
						"secondary": secondary_piece, 
						"targets": targets 
					})

	# Update ready state and show indicator if targets exist
	if DataHandler.tidalwave_targets.size() > 0:
		DataHandler.tidalwave_ready = true
		SignalBus.show_correct_icons.emit(DataHandler.piece_dict[DataHandler.tidalwave_targets[0]["primary"]])

func fireball(target_pos: Vector2):
	# Validate the target exists before removing it
	if DataHandler.piece_dict.has(target_pos):
		DataHandler.piece_dict[target_pos].queue_free()
		DataHandler.piece_dict.erase(target_pos)
	else:
		print("Error: Attempted to fireball a piece that doesn't exist.")
