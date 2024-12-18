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
var assets := []
#enum PieceNames {WHITE_AMBER, WHITE_JADE, WHITE_RUBY, WHITE_PEARL, WHITE_VOID}
var piece_dict := {}

var clicked_piece = Vector2()
var clicked_slot = Vector2()
var icon_offset := Vector2(20, 20)

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
	assets.append("res://Images/Portal_Circle.png") #5
	assets.append("res://Images/Pieces/Void_Circle.png") #6
	#Square
	assets.append("res://Images/Pieces/Ruby_Square.png") #7
	assets.append("res://Images/Pieces/Pearl_Square.png") #8
	assets.append("res://Images/Pieces/Amber_Square.png") #9
	assets.append("res://Images/Pieces/Jade_Square.png") #10
	assets.append("res://Images/Pieces/Amalgam_Square.png") #11
	assets.append("res://Images/Portal_Square.png") #12
	assets.append("res://Images/Pieces/Void_Square.png") #13
# Called every frame. 'delta' is the elapsed time since the previous frame.

#func _process(delta: float) -> void:
#	pass

func change_pos():
	if piece_dict.has(clicked_piece):
		if !piece_dict.has(clicked_slot):
			piece_dict[clicked_piece].global_position = board_dict[clicked_slot].global_position + icon_offset
			SignalBus.changed_piece.emit(piece_dict[clicked_piece], clicked_slot)
			piece_dict[clicked_slot] = piece_dict[clicked_piece]
			piece_dict.erase(clicked_piece)
		clicked_piece = clicked_slot
		#clicked_piece = null

func slot_is_empty():
	if !piece_dict.has(clicked_slot):
		return true
