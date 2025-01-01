extends Node

var player_turn : String

var turn_step = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_turn = "Squares"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func next_turn_step():
	if turn_step == 1:
		SignalBus.show_end_turn.emit(true)
	if turn_step < 2:
		turn_step += 1
		
func end_turn():
	if turn_step > 1:
		if player_turn == "Squares":
			player_turn = "Circles"
		elif player_turn == "Circles":
			player_turn = "Squares"
		turn_step = 1
	SignalBus.show_end_turn.emit(false)
	DataHandler
