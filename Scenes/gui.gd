extends Control

@onready var slot_scene = preload("res://Scenes/slot.tscn")
@onready var board_grid = $Board/BoardGrid
@onready var board = $Board
@onready var piece_scene = preload("res://Scenes/piece.tscn")
var grid_array := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.ready_to_add_piece.connect(add_piece)
	var ycor = 12
	for i in range(25):
		var xcor = -12
		for n in range(25):
			create_slot()
			grid_array[-1].slot_ID = Vector2(xcor, ycor)
			if DataHandler.board_dict.has(grid_array[-1].slot_ID):
				DataHandler.board_dict[grid_array[-1].slot_ID] = grid_array[-1]
			xcor += 1
		ycor -= 1
	board_setup.call_deferred()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func board_setup():
	#Void
	add_piece(6, Vector2(0,12)) #Void-B
	add_piece(13, Vector2(0,-12)) #Void-W
	#Amalgam
	add_piece(4, Vector2(0,6)) #Amalgam-B
	add_piece(11, Vector2(0,-6)) #Amalgam-W
	#Portal
	add_piece(5, Vector2(6,6)) #Portal-B1
	add_piece(12, Vector2(6,-6)) #Portal-W1
	add_piece(5, Vector2(-6,6)) #Portal-B2
	add_piece(12, Vector2(-6,-6)) #Portal-W2
	#Ruby
	add_piece(0, Vector2(1,10)) #Ruby-B1
	add_piece(7, Vector2(1,-10)) #Ruby-W1
	add_piece(0, Vector2(1,11)) #Ruby-B2
	add_piece(7, Vector2(1,-11)) #Ruby-W2
	#Pearl
	add_piece(1, Vector2(2,10)) #Pearl-B1
	add_piece(8, Vector2(2,-10)) #Pearl-W1
	add_piece(1, Vector2(2,11)) #Pearl-B2
	add_piece(8, Vector2(2,-11)) #Pearl-W2
	#Amber
	add_piece(2, Vector2(3,10)) #Amber-B1
	add_piece(9, Vector2(3,-10)) #Amber-W1
	add_piece(2, Vector2(3,11)) #Amber-B2
	add_piece(9, Vector2(3,-11)) #Amber-W2
	#Jade
	add_piece(3, Vector2(1,8)) #Jade-B1
	add_piece(10, Vector2(1,-8)) #Jade-W1
	add_piece(3, Vector2(1,9)) #Jade-B2
	add_piece(10, Vector2(1,-9)) #Jade-W2
	
func create_slot():
	var new_slot = slot_scene.instantiate()
	board_grid.add_child(new_slot)
	grid_array.append(new_slot)

func add_piece(piece_type, location)->void:
	if DataHandler.slot_is_empty():
		var new_piece = piece_scene.instantiate()
		board.add_child(new_piece)
		new_piece.type = piece_type
		new_piece.load_icon(piece_type)
		new_piece.global_position = DataHandler.board_dict[location].global_position + DataHandler.icon_offset
		new_piece.slot_ID = location
		DataHandler.piece_dict[new_piece.slot_ID] = new_piece
		DataHandler.clicked_piece = null
	else:
		SignalBus.toggle_add_piece.emit(piece_type)
		print('slot taken')
		
func _on_ruby_pressed() -> void:
	SignalBus.toggle_add_piece.emit(0)

func _on_pearl_pressed() -> void:
	SignalBus.toggle_add_piece.emit(1)
	
func _on_amber_pressed() -> void:
	SignalBus.toggle_add_piece.emit(2)
	
func _on_jade_pressed() -> void:
	SignalBus.toggle_add_piece.emit(3)

func _on_amalgam_pressed() -> void:
	SignalBus.toggle_add_piece.emit(4)

func _on_portal_pressed() -> void:
	SignalBus.toggle_add_piece.emit(5)

func _on_void_pressed() -> void:
	SignalBus.toggle_add_piece.emit(6)

func _on_remove_piece_pressed() -> void:
	DataHandler.remove = true

func _on_setup_pressed() -> void:
	for n in $Board.get_children():
		if n != $Board/BoardGrid and n != $Board/BoardBackground:
			$Board.remove_child(n)
	DataHandler.piece_dict = {}
	board_setup()
