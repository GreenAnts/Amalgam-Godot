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
			if DataHandler.fireball_ready == true:
				DataHandler.fireball(self.targets)
				# Reset the fireball ability and clear targets
				SignalBus.show_correct_icons.emit("Ruby_Used")
				DataHandler.fireball_ready = false
				SignalBus.reset_movement_options.emit()
				SignalBus.reset_ability_indicators.emit()
			elif DataHandler.tidalwave_ready == true:
				DataHandler.tidalwave(self.targets)
				# Reset the fireball ability and clear targets
				SignalBus.show_correct_icons.emit("Pearl_Used")
				DataHandler.tidalwave_ready = false
				SignalBus.reset_movement_options.emit()
				SignalBus.reset_ability_indicators.emit()
			elif DataHandler.sap_ready == true:
				DataHandler.sap(self.targets)
				# Reset the fireball ability and clear targets
				SignalBus.show_correct_icons.emit("Amber_Used")
				DataHandler.sap_ready = false
				SignalBus.reset_movement_options.emit()
				SignalBus.reset_ability_indicators.emit()
