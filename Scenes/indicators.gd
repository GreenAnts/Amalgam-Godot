extends Sprite2D

var pos = Vector2()
var targets = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if DataHandler.launch_ready == true:
				print("LAUNCH Ready")
				# Loop through sap_targets to check if the current slot is one of the targets
				for movement_info in DataHandler.jade_targets:
					# Check if the current slot is in any of the target lists
					if self.pos in movement_info:
						# Execute sap on this target
						SignalBus.reset_movement_options.emit()
						SignalBus.reset_ability_indicators.emit()
						DataHandler.launch(self.pos)
						# Reset the sap ability and clear targets
						SignalBus.show_correct_icons.emit(null)
						DataHandler.launch_ready = false
						break  # Exit loop once sap is used
					else:
						DataHandler.launch_ready = true
