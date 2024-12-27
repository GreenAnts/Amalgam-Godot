extends Control

var slot_ID := Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.toggle_add_piece.connect(adding_piece)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func adding_piece(piece):
	DataHandler.add_piece = piece

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and DataHandler.board_dict.has(slot_ID):
			DataHandler.clicked_slot = slot_ID
			if DataHandler.add_piece != null:
				SignalBus.ready_to_add_piece.emit(DataHandler.add_piece, slot_ID)
				DataHandler.add_piece = null
			#SWAP
			elif DataHandler.swap_ready != null:
				DataHandler.swap_pos()
			#FIREBALL
			elif DataHandler.fireball_ready == true:
				print("FB Ready")
				if DataHandler.piece_dict.has(self.slot_ID):
					var player = GameLogic.check_player_of_piece(self.slot_ID)
				# Loop through ruby_targets to check if the current slot is one of the targets
				for target_info in DataHandler.ruby_targets:
					# Check if the current slot is in any of the target lists
					if self.slot_ID in target_info:
						# Execute fireball on this target
						DataHandler.fireball(self.slot_ID)
						# Reset the fireball ability and clear targets
						SignalBus.show_correct_icons.emit(null)
						DataHandler.fireball_ready = false
						SignalBus.reset_movement_options.emit()
						break  # Exit loop once fireball is used
					else:
						DataHandler.fireball_ready = true
			#TIDALWAVE
			elif DataHandler.tidalwave_ready == true:
				print("TW Ready")
				if DataHandler.piece_dict.has(self.slot_ID):
					var player = GameLogic.check_player_of_piece(self.slot_ID)
				# Loop through pearl_targets to check if the current slot is one of the targets
				for target_info in DataHandler.pearl_targets:
					# Check if the current slot is in any of the target lists
					if self.slot_ID in target_info:
						# Execute tidalwave on this target
						DataHandler.tidalwave(self.slot_ID)
						# Reset the tidalwave ability and clear targets
						SignalBus.show_correct_icons.emit(null)
						DataHandler.tidalwave_ready = false
						SignalBus.reset_movement_options.emit()
						break  # Exit loop once tidalwave is used
					else:
						DataHandler.tidalwave_ready = true
			elif DataHandler.sap_ready == true:
				print("SAP Ready")
				if DataHandler.piece_dict.has(self.slot_ID):
					var player = GameLogic.check_player_of_piece(self.slot_ID)
				# Loop through sap_targets to check if the current slot is one of the targets
				for target_info in DataHandler.amber_targets:
					# Check if the current slot is in any of the target lists
					if self.slot_ID in target_info:
						# Execute sap on this target
						DataHandler.sap(self.slot_ID)
						# Reset the sap ability and clear targets
						SignalBus.show_correct_icons.emit(null)
						DataHandler.sap_ready = false
						SignalBus.reset_movement_options.emit()
						break  # Exit loop once sap is used
					else:
						DataHandler.sap_ready = true
			else:
				DataHandler.change_pos()
			
