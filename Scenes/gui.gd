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
	add_piece.call_deferred(4, Vector2(0,12))
	add_piece.call_deferred(4, Vector2(0,-12))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func board_setup():
	add_piece(4, Vector2(0,12))
	add_piece(4, Vector2(0,-12))

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
	
func _on_jade_pressed() -> void:
	SignalBus.toggle_add_piece.emit(0)
	
func _on_pearl_pressed() -> void:
	SignalBus.toggle_add_piece.emit(1)

func _on_amber_pressed() -> void:
	SignalBus.toggle_add_piece.emit(2)

func _on_ruby_pressed() -> void:
	SignalBus.toggle_add_piece.emit(3)

func _on_amalgam_pressed() -> void:
	pass

func _on_portal_pressed() -> void:
	pass # Replace with function body.

func _on_void_pressed() -> void:
	SignalBus.toggle_add_piece.emit(4)

func _on_remove_piece_pressed() -> void:
	DataHandler.remove = true

func _on_setup_pressed() -> void:
	board_setup()
