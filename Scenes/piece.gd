extends Node2D

@onready var icon_path = $Icon
var slot_ID := Vector2(0,0)
var type: int #piece color - see DataHandler.gd and gui.gd

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.changed_piece.connect(change_ID)

func load_icon(piece_name) -> void:
	icon_path.texture = load(DataHandler.assets[piece_name])

func change_ID(piece, coordinates):
	#slot_ID = coordinates
	if self == piece:
		slot_ID = coordinates
