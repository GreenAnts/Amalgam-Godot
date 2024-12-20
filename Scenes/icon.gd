extends Sprite2D

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				DataHandler.clicked_piece = self.get_parent().slot_ID
				SignalBus.movement_options.emit(GameLogic.nexus_movement(self.get_parent().slot_ID))
				if DataHandler.remove == true:
					DataHandler.remove = false
					DataHandler.piece_dict.erase(get_parent().slot_ID)
					get_parent().queue_free()
	if event is InputEventMouseButton: 
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			SignalBus.reset_movement_options.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
