extends Sprite2D

func _ready():
	connect("mouse_entered", Callable(self, "_on_area_2d_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_area_2d_mouse_exited"))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if is_pixel_opaque(get_local_mouse_position()):
				DataHandler.clicked_piece = self.get_parent().slot_ID
				# Emit movement options based on the clicked piece
				SignalBus.movement_options.emit(GameLogic.nexus_movement(self.get_parent().slot_ID))
				SignalBus.movement_options.emit(GameLogic.standard_movement(self.get_parent().slot_ID))
				if DataHandler.piece_dict[self.get_parent().slot_ID].type in [5, 12]:
					SignalBus.movement_options.emit(GameLogic.portal_movement(self.get_parent().slot_ID))
				if DataHandler.remove == true:
					DataHandler.remove = false
					DataHandler.piece_dict.erase(get_parent().slot_ID)
					get_parent().queue_free()
		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			SignalBus.reset_movement_options.emit()

# This is called when the mouse enters the Area2D
func _on_area_2d_mouse_entered() -> void:
	print("Mouse entered")
	if is_pixel_opaque(get_local_mouse_position()):
		SignalBus.movement_options.emit(GameLogic.nexus_movement(self.get_parent().slot_ID))
		SignalBus.movement_options.emit(GameLogic.standard_movement(self.get_parent().slot_ID))
		if DataHandler.piece_dict[self.get_parent().slot_ID].type in [5, 12]:
			SignalBus.movement_options.emit(GameLogic.portal_movement(self.get_parent().slot_ID))

# This is called when the mouse exits the Area2D
func _on_area_2d_mouse_exited() -> void:
	print("Mouse exited")
	SignalBus.reset_movement_options.emit()
